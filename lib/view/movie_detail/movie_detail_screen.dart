import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchit/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:watchit/repos/movie_detail/movie_detail_repo.dart';
import 'package:watchit/view/movie_detail/widgets/recommended_movie.dart';
import '../../model/movie_detail.dart';
import '../../model/recommended_movie.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movieId});
  final String movieId;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  var enableDownload = true;
  final _statesController = MaterialStatesController();
  var thumbnailUrl = '';
  MovieDetail? movieDetail;
  List<RecommendedMovie> recommendedMovies = [];

  void downloadMovie() {
    if (enableDownload) {
      _statesController.update(MaterialState.disabled, true);
    } else {
      _statesController.update(MaterialState.disabled, false);
    }
    enableDownload = !enableDownload;
  }

  void closeScreen() {
    Navigator.of(context).pop();
  }

  void goToMovieDetailScreen(String id) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MovieDetailScreen(movieId: id);
    }));
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final isDarkModeOn =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return RepositoryProvider(
      create: (context) => MovieDetailRepository(),
      child: BlocProvider(
        create: (context) => MovieDetailBloc(
            movieDetailRepository:
                RepositoryProvider.of<MovieDetailRepository>(context))
          ..add(FetchMovieDetailScreenData(widget.movieId)),
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
          builder: (context, state) {
            if (state is MovieDetailInitial) {
              debugPrint(' state is MovieDetailInitial');
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.red,
              ));
            } else if (state is MovieDetailLoaded) {
              movieDetail = state.movieDetail;

              debugPrint(' state is MovieDetailLoaded');
            } else if (state is MovieDetailError) {
              debugPrint(' state is MovieDetailError');
              return Material(
                child: Center(
                  child: InkWell(
                    onTap: closeScreen,
                    child: const Text(
                        'Something went wrong, please try again later.'),
                  ),
                ),
              );
            } else if (state is RecommendedMovieLoaded) {
              recommendedMovies = state.listOfrecommendedMovies;

              debugPrint(' state is RecommendedMovieLoaded');
            }
            return Material(
              color: isDarkModeOn ? Colors.black : Colors.white,
              child: SafeArea(
                maintainBottomViewPadding: true,
                child: SizedBox(
                  height: double.infinity,
                  child: Column(
                    children: [
                      buildThumbnail(),
                      buildMovieTitle(textTheme, context),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomScrollView(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            slivers: [
                              SliverToBoxAdapter(
                                child: Column(
                                  children: [
                                    Column(
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: ElevatedButton.icon(
                                            onPressed: () {
                                              downloadMovie();
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: isDarkModeOn
                                                  ? Colors.white
                                                  : Colors.red,
                                              disabledForegroundColor:
                                                  Colors.white, // background
                                              disabledBackgroundColor: Colors
                                                  .grey.shade800, // foreground
                                            ),
                                            statesController: _statesController,
                                            icon: Image.asset(
                                              'assets/downloads.png',
                                              color: isDarkModeOn
                                                  ? Colors.black
                                                  : Colors.white,
                                            ),
                                            label: Text(
                                              'Download',
                                              style: textTheme.bodyLarge!
                                                  .copyWith(
                                                      color: isDarkModeOn
                                                          ? Colors.black
                                                          : Colors.white),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            movieDetail!.tagline,
                                            style: textTheme.titleMedium
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w700),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            movieDetail!.overview,
                                            style: textTheme.bodyMedium,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 24,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                Image.asset(
                                                  'assets/add_large.png',
                                                  color: isDarkModeOn
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Text(
                                                  'My List',
                                                  style: textTheme.labelMedium,
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Image.asset(
                                                  'assets/like.png',
                                                  color: isDarkModeOn
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Text(
                                                  'Rate',
                                                  style: textTheme.labelMedium,
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Image.asset(
                                                  'assets/share.png',
                                                  color: isDarkModeOn
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                Text(
                                                  'Share',
                                                  style: textTheme.labelMedium,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Text(
                                          'More Like This',
                                          style: textTheme.titleLarge,
                                        ),
                                        const SizedBox(
                                          height: 12,
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SliverGrid(
                                  delegate: SliverChildBuilderDelegate(
                                      (context, index) => RecommendedMovies(
                                          onRecommendedMovieClick: () {
                                            goToMovieDetailScreen(
                                                recommendedMovies[index].id);
                                          },
                                          imageUrl: recommendedMovies[index]
                                              .posterPath,
                                          title:
                                              recommendedMovies[index].title),
                                      childCount: recommendedMovies.length),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 10,
                                          crossAxisSpacing: 10))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Padding buildMovieTitle(TextTheme textTheme, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset('assets/logo_small.png'),
              const SizedBox(
                width: 4,
              ),
              const Text(
                'SERIES',
                style: TextStyle(
                  letterSpacing: 3,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              movieDetail!.title,
              style: textTheme.titleMedium,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                movieDetail!.year,
                style: Theme.of(context).textTheme.labelSmall,
              ),
              const SizedBox(
                width: 4,
              ),
              Container(
                padding:
                    const EdgeInsets.only(left: 6, right: 6, top: 2, bottom: 2),
                decoration: BoxDecoration(
                    color: Colors.grey.shade500,
                    borderRadius: const BorderRadius.all(Radius.circular(2))),
                child: Text(
                  'TV-MA',
                  style: textTheme.labelSmall!.copyWith(letterSpacing: 1),
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                'All Seasons',
                style: textTheme.bodySmall,
              ),
              const SizedBox(
                width: 4,
              ),
              Image.asset('assets/dolby_vision.png'),
              const SizedBox(
                width: 4,
              ),
              Image.asset('assets/hd.png'),
              const SizedBox(
                width: 4,
              ),
              Image.asset('assets/ad.png')
            ],
          )
        ],
      ),
    );
  }

  Stack buildThumbnail() {
    return Stack(
      children: [
        Image.network(
          'https://image.tmdb.org/t/p/w500//${movieDetail!.imgUrl}',
          width: double.infinity,
          height: 300,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 300,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 16, top: 16),
                    child: Image.asset('assets/screen_share.png'),
                  ),
                  InkWell(
                    onTap: closeScreen,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 16, top: 16),
                      child: Image.asset('assets/close_ic.png'),
                    ),
                  ),
                ],
              ),
              Image.asset('assets/play_ic.png'),
              const Padding(
                padding: EdgeInsets.only(left: 16, bottom: 16),
                child: SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Trailer',
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 0.25,
                          fontWeight: FontWeight.w800,
                          fontSize: 14),
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }
}
