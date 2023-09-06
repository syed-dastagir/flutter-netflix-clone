import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:watchit/repos/home/home_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository homeRepository;

  HomeBloc(this.homeRepository) : super(HomeBlocInitial()) {
    on<FetchHomeScreenData>((event, emit) async {
      final nowPlayingResponse = await homeRepository.fetchNowPlaying();
      final nowPlayings = nowPlayingResponse == null
          ? []
          : jsonDecode(nowPlayingResponse)['results'];

      final trailersResponse = await homeRepository.fetchTrailers();
      final trailers = trailersResponse == null
          ? []
          : jsonDecode(trailersResponse)['results'];

      final trendingResponse = await homeRepository.fetchTrendings();
      final trendings = trendingResponse == null
          ? []
          : jsonDecode(trendingResponse)['results'];

      emit(HomeScreenDataLoaded(nowPlayings, trailers, trendings));
    });

    on<GoToMovieDetail>((event, emit) {
      emit(NavigateToMovieDetailScreen(movieId: event.id));
    });
  }
}
