import 'package:dio/dio.dart';
import 'package:movie_villa/models/movie_response.dart';

class MovieRepository {
  final String apiKey = 'add0b3dd2f97f0d1b15f491aa82b0aea';
  static String mainUrl = 'https://api.themoviedb.org/3';
  final Dio _dio = Dio();
  var getMoviesUrl = '$mainUrl/discover/movie';

  Future<MovieResponse> getMovies() async {
    var params = {
      'api_key': apiKey,
      'language': 'en-US',
      'page': 1
    };

    try {
      Response response = await _dio.get(getMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch(error, stackTrace) {
      print('Exception occurred: $error stackTrace: $stackTrace');
      return MovieResponse.withError('$error');
    }
  }
}