part of 'home_bloc.dart';

@immutable
sealed class HomeState extends Equatable {}

final class HomeBlocInitial extends HomeState {
  @override
  List<Object?> get props => throw UnimplementedError();
}

final class HomeScreenDataLoaded extends HomeState {
  HomeScreenDataLoaded(this.nowPlaying, this.trailers, this.trendings);
  final dynamic nowPlaying;
  final dynamic trailers;
  final dynamic trendings;

  @override
  List<Object?> get props => throw Exception('Failed to load data...');
}

final class NavigateToMovieDetailScreen extends HomeState {
  NavigateToMovieDetailScreen({required this.movieId});
  final String movieId;
  @override
  List<Object?> get props =>
      throw Exception('Exception while navitating to Movie detail screen');
}
