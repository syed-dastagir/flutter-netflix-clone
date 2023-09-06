import 'package:flutter/material.dart';

import '../../data/remote/api_client.dart';
import '../../data/remote/api_endpoints.dart';

class HomeRepository {
  Future<String?> fetchNowPlaying() async {
    try {
      final response = await ApiClient().get(ApiEndpoints.nowPlayingMovies);
      return response;
    } on Exception catch (e) {
      debugPrint('exception in fetchNowPlaying:${e.toString()}');
      return null;
    }
  }

  Future<String?> fetchTrailers() async {
    try {
      final response = await ApiClient().get(ApiEndpoints.upcomingMovies);
      return response;
    } on Exception catch (e) {
      debugPrint('exception in fetchTrailers:${e.toString()}');
      return null;
    }
  }

  Future<String?> fetchTrendings() async {
    try {
      final response = await ApiClient().get(ApiEndpoints.popularMovies);
      return response;
    } on Exception catch (e) {
      debugPrint('exception in fetchTrendings:${e.toString()}');
      return null;
    }
  }
}
