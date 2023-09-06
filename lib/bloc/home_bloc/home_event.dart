part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class FetchHomeScreenData extends HomeEvent {}

class FetchNowPlayings extends HomeEvent {}

class FetchTrailers extends HomeEvent {}

class FetchTrendings extends HomeEvent {}

class GoToMovieDetail extends HomeEvent {
  GoToMovieDetail(this.id);
  final String id;
}
