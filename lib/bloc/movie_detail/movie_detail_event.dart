part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieDetailScreenData extends MovieDetailEvent {
  const FetchMovieDetailScreenData(this.movieId);
  final String movieId;
}
