import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:watchit/data/remote/api_endpoints.dart';
import 'package:watchit/repos/movie_detail/movie_detail_repo.dart';

import '../../model/movie_detail.dart';
import '../../model/recommended_movie.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final MovieDetailRepository movieDetailRepository;

  MovieDetailBloc({required this.movieDetailRepository})
      : super(MovieDetailInitial()) {
    on<FetchMovieDetailScreenData>((event, emit) async {
      final response = await movieDetailRepository.fetchMovieDetail(ApiEndpoints
          .movieDetail
          .replaceFirst(RegExp('{movieId}'), event.movieId));
      if (response != null && response.isNotEmpty) {
        final json = jsonDecode(response);
        emit(MovieDetailLoaded(
            movieDetail: MovieDetail(
                json['backdrop_path'],
                json['original_title'],
                json['overview'],
                json['release_date'].toString().split('-').first,
                json['tagline'],
                json['id'].toString())));
      } else {
        emit(MovieDetailError());
      }

      final recommendedMovieResponse = await movieDetailRepository
          .recommendedMovies(ApiEndpoints.recommendedMovies
              .replaceFirst(RegExp('{movieId}'), event.movieId));
      if (recommendedMovieResponse != null &&
          recommendedMovieResponse.isNotEmpty) {
        final responseBody = jsonDecode(recommendedMovieResponse);
        final result = responseBody['results'] as List<dynamic>;
        List<RecommendedMovie> listOfRecommendedMovies = [];
        for (final i in result) {
          if (i['poster_path'] != null) {
            listOfRecommendedMovies.add(RecommendedMovie(
              i['original_title'],
              i['poster_path'],
              i['id'].toString(),
            ));
          }
        }

        emit(RecommendedMovieLoaded(listOfRecommendedMovies));
      } else {
        emit(RecommendedMovieError());
      }
    });
  }
}
