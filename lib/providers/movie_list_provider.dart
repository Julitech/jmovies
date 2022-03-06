import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jmovies/models/movieList.dart';
import 'package:jmovies/widget/widgets.dart';

class MovieListProvider with ChangeNotifier {
  //Load Movie list
  Future<List<dynamic>> loadMoviesList({String sortBy, int pageCount}) async {
    try {
      String url =
          "https://yts.mx/api/v2/list_movies.json?sort_by=$sortBy&page=$pageCount";
      final response = await http.get(url);

      final result = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> data =
          MovieList.fromJson(result).data.toJson()["movies"];

      return data;
    } on SocketException catch (error) {
      throw "Internet Error";
    } catch (e) {
      return [];
    }
  }

  //Load Trending movies with min rating
  Future<List<dynamic>> loadTrendingMovies() async {
    try {
      String url =
          "https://yts.mx/api/v2/list_movies.json?sort_by=download_count&limit=20";
      final response = await http.get(url);

      final result = json.decode(response.body) as Map<String, dynamic>;

      final List<dynamic> data =
          MovieList.fromJson(result).data.toJson()["movies"];
      return data;
    } catch (error) {
      print("Error when loading movies: $error");
      return null;
    }
  }

  //Load categorised movies
  Stream<List<dynamic>> loadGenreMoviesStream(String genre, String sortBy,
      {int page}) async* {
    try {
      String url =
          "https://yts.mx/api/v2/list_movies.json?genre=$genre&sort_by=$sortBy&limit=20&page=$page";
      final response = await http.get(url);
      final result = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> data =
          MovieList.fromJson(result).data.toJson()["movies"];
      yield data;
    } on ArgumentError catch (e) {
      yield [];
      print(e);
      showToast("An Error Occurred");
      throw "Error";
    } on SocketException catch (error) {
      throw "Internet Error";
    }
  }

  //Search for movies
  Stream<List<dynamic>> searchMoviesList(String searchUrl) async* {
    try {
      final response = await http.get(searchUrl);

      final result = json.decode(response.body) as Map<String, dynamic>;

      int moviesFound = result['data']['movie_count'];
      List<dynamic> data;

      //If no movies found return null
      if (moviesFound == 0) {
        yield [];
      } else if (moviesFound > 0) {
        data = MovieList.fromJson(result).data.toJson()["movies"];
      }
      yield data;
    } on SocketException catch (error) {
      showToast("No Internet Connection");
      throw "Internet Error";
    } catch (error) {
      showToast("Search Failed...Please Try Again $error");
    }
  }
}
