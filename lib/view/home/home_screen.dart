import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watchit/bloc/home_bloc/home_bloc.dart';
import 'package:watchit/repos/home/home_repository.dart';
import 'package:watchit/view/home/widgets/vertical_poster_widget.dart';
import 'package:watchit/view/home/widgets/horizontal_poster_widget.dart';
import 'package:watchit/view/movie_detail/movie_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> nowPlaying = [];
  List<dynamic> trendings = [];
  List<dynamic> trailers = [];

  void goToMovieDetailScreen(String id) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MovieDetailScreen(movieId: id);
    }));
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return BlocProvider(
      create: (context) =>
          HomeBloc(RepositoryProvider.of<HomeRepository>(context))
            ..add(FetchHomeScreenData()),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          leading: Image.asset(
            'assets/large_n.png',
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                children: [
                  ImageIcon(
                    const AssetImage('assets/screen_share.png'),
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(
                    Icons.notifications,
                  )
                ],
              ),
            ),
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeScreenDataLoaded) {
              nowPlaying = state.nowPlaying;
              trailers = state.trailers;
              trendings = state.trendings;
              debugPrint(
                  'Home data loaded. nowPlaying size: ${nowPlaying.length}, trailers size: ${trailers.length}, trendings size: ${trendings.length}');
            } else if (state is HomeBlocInitial) {
              debugPrint('Loading Home data');
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.red,
              ));
            } else {
              debugPrint('Failed to load home data');
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    fit: StackFit.loose,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: Image.network(
                          'https://image.tmdb.org/t/p/original/tlu71AgaL3EQBBCNGsAwZLPbV5D.jpg',
                          fit: BoxFit.fitWidth,
                          height: 538,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black54],
                                begin: Alignment.center,
                                end: Alignment.bottomCenter)),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                  colors: [Colors.transparent, Colors.black],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter)),
                          child: Column(
                            children: [
                              Text('Exciting • Reality Tv • Competition',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: Colors.white)),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Column(
                                    children: [
                                      Icon(Icons.add, color: Colors.white),
                                      Text(
                                        'My List',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                  ElevatedButton.icon(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white),
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.play_arrow,
                                        color: Colors.black,
                                      ),
                                      label: InkWell(
                                        onTap: () {
                                          goToMovieDetailScreen('787752');
                                        },
                                        child: const Text(
                                          'Play',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      )),
                                  const Column(
                                    children: [
                                      Icon(
                                        Icons.info_outline,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Info',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  nowPlaying.isEmpty
                      ? Container()
                      : VerticalPostersWidget(
                          'Now Playing',
                          list: nowPlaying,
                          onItemClick: (id) {
                            goToMovieDetailScreen(id);
                          },
                        ),
                  trailers.isEmpty
                      ? Container()
                      : HorizontalPosterWidget(
                          'Latest Trailers',
                          list: trailers,
                          onTrailerClick: (trailerId) {
                            goToMovieDetailScreen(trailerId);
                          },
                        ),
                  trendings.isEmpty
                      ? Container()
                      : VerticalPostersWidget(
                          'Trending',
                          list: trendings,
                          onItemClick: (id) {
                            goToMovieDetailScreen(id);
                          },
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
