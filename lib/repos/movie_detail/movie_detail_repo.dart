import 'package:flutter/cupertino.dart';
import 'package:watchit/data/remote/api_client.dart';

class MovieDetailRepository {
  Future<String>? fetchMovieDetail(String endpoint) {
    try {
      final response = ApiClient().get(endpoint);
      return response;
    } on Exception catch (e) {
      debugPrint('exception in fetchMovieDetail:${e.toString()}');
      return null;
    }
  }

  Future<String>? recommendedMovies(String endpoint) {
    try {
      final response = ApiClient().get(endpoint);
      return response;
    } on Exception catch (e) {
      debugPrint('exception in recommendedMovies:${e.toString()}');
      return null;
    }
  }
}
