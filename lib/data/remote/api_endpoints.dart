class ApiEndpoints {
  const ApiEndpoints();

  static const nowPlayingMovies = 'movie/now_playing';
  static const popularMovies = 'movie/popular';
  static const upcomingMovies = 'movie/upcoming';
  static const movieDetail = 'movie/{movieId}';
  static const recommendedMovies = 'movie/{movieId}/similar';
}
