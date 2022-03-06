import 'package:flutter/material.dart';

class MyValues {
  static const Color mainBlue = Color(0xFF00ace6);
  static const Color accentColor = Colors.orange;
  static const Color mainWhite = Color(0xffEEEEEE);

  static const String email = "julitech.jmovies@gmail.com";
  static const String playStoreURL =
      "https://play.google.com/store/apps/details?id=com.julitech.jmovies";

  static const String movieDetails =
      "https://yts.mx/api/v2/movie_details.json?movie_id=15&with_images=true&with_cast=true";

  static const List<String> genres = [
    "Action",
    "Adventure",
    "Animation",
    "Biography",
    "Comedy",
    "Crime",
    "Documentary",
    "Drama",
    "Family",
    "Fantasy",
    "History",
    "Horror",
    "Musical",
    "Romance",
    "Sci-Fi",
    "Sport",
    "Thriller",
    "War"
  ];

  static Map<String, String> bgImages = {
    "action": "assets/images/genres/avengers_bg.jpeg",
    "adventure": "assets/images/genres/adventure.jpeg",
    "animation": "assets/images/genres/animation.jpeg",
    "biography": "assets/images/genres/documentary.jpeg",
    "comedy": "assets/images/genres/comedy.jpeg",
    "crime": "assets/images/genres/crime.jpeg",
    "documentary": "assets/images/genres/documentary.jpeg",
    "drama": "assets/images/genres/drama.jpeg",
    "family": "assets/images/genres/family.jpeg",
    "fantasy": "assets/images/genres/fantasy.jpeg",
    "history": "assets/images/genres/history.jpeg",
    "horror": "assets/images/genres/horror.jpeg",
    "musical": "assets/images/genres/musical.jpeg",
    "romance": "assets/images/genres/romance.jpeg",
    "sci-fi": "assets/images/genres/sci.jpeg",
    "sport": "assets/images/genres/sports.jpeg",
    "thriller": "assets/images/avengers_bg.jpeg",
    "war": "assets/images/genres/war.jpeg",
  };

  static const List<String> quality = ["720p", "1080p", "3D"];

  static const List<String> sortBy = [
    "Date_added",
    "Download_count",
    "Year",
    "Rating",
    "Title",
  ];
  static const List<int> ratings = [9, 8, 7, 6, 5, 4, 3, 2, 1, 0];
}
