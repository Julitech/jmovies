import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:jmovies/models/movie.dart' as movieDetails;
import 'package:http/http.dart' as http;

class MyMovieProvider with ChangeNotifier {
  static String id;
  movieDetails.Data data;
  movieDetails.Movie movie;
  String movieUrl;

  //Load details and decode it
  Future<movieDetails.Movie> decodeMovieDetails(String id) async {
    try {
      movieUrl =
          "https://yts.mx/api/v2/movie_details.json?movie_id=$id&with_images=true&with_cast=true";

      final response = await http.get(movieUrl);

      final result = json.decode(response.body) as Map<String, dynamic>;

      data = movieDetails.Data.fromJson(result["data"]);
      return movie = data.movie;
    } on Exception catch (exception) {
      print("Json Exception: " + exception.toString());
      return null;
    } catch (error) {
      print("Error Message: $error.toString()");
      return null;
    }
  }
}
