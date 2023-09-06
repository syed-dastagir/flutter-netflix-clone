part of 'movie_detail_bloc.dart';

sealed class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

final class MovieDetailInitial extends MovieDetailState {}

final class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail movieDetail;
  const MovieDetailLoaded({required this.movieDetail});
}

final class MovieDetailError extends MovieDetailState {}

final class RecommendedMovieLoaded extends MovieDetailState {
  final List<RecommendedMovie> listOfrecommendedMovies;
  const RecommendedMovieLoaded(this.listOfrecommendedMovies);
}

final class RecommendedMovieError extends MovieDetailState {}
