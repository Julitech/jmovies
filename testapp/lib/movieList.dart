// To parse this JSON data, do
//
//     final movieList = movieListFromJson(jsonString);

import 'dart:convert';

MovieList movieListFromJson(String str) => MovieList.fromJson(json.decode(str));

String movieListToJson(MovieList data) => json.encode(data.toJson());

class MovieList {
  Stat status;
  String statusMessage;
  Data data;
  Meta meta;

  MovieList({
    this.status,
    this.statusMessage,
    this.data,
    this.meta,
  });

  factory MovieList.fromJson(Map<String, dynamic> json) => MovieList(
        status: json["status"] == null ? null : statValues.map[json["status"]],
        statusMessage:
            json["status_message"] == null ? null : json["status_message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        meta: json["@meta"] == null ? null : Meta.fromJson(json["@meta"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : statValues.reverse[status],
        "status_message": statusMessage == null ? null : statusMessage,
        "data": data == null ? null : data.toJson(),
        "@meta": meta == null ? null : meta.toJson(),
      };
}

class Data {
  int movieCount;
  int limit;
  int pageNumber;
  List<Movie> movies;

  Data({
    this.movieCount,
    this.limit,
    this.pageNumber,
    this.movies,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        movieCount: json["movie_count"] == null ? null : json["movie_count"],
        limit: json["limit"] == null ? null : json["limit"],
        pageNumber: json["page_number"] == null ? null : json["page_number"],
        movies: json["movies"] == null
            ? null
            : List<Movie>.from(json["movies"].map((x) => Movie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "movie_count": movieCount == null ? null : movieCount,
        "limit": limit == null ? null : limit,
        "page_number": pageNumber == null ? null : pageNumber,
        "movies": movies == null
            ? null
            : List<dynamic>.from(movies.map((x) => x.toJson())),
      };
}

class Movie {
  int id;
  String url;
  String imdbCode;
  String title;
  String titleEnglish;
  String titleLong;
  String slug;
  int year;
  double rating;
  int runtime;
  List<String> genres;
  String summary;
  String descriptionFull;
  String synopsis;
  String ytTrailerCode;
  Language language;
  MpaRating mpaRating;
  String backgroundImage;
  String backgroundImageOriginal;
  String smallCoverImage;
  String mediumCoverImage;
  String largeCoverImage;
  Stat state;
  List<Torrent> torrents;
  DateTime dateUploaded;
  int dateUploadedUnix;

  Movie({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.summary,
    this.descriptionFull,
    this.synopsis,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.state,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json["id"] == null ? null : json["id"],
        url: json["url"] == null ? null : json["url"],
        imdbCode: json["imdb_code"] == null ? null : json["imdb_code"],
        title: json["title"] == null ? null : json["title"],
        titleEnglish:
            json["title_english"] == null ? null : json["title_english"],
        titleLong: json["title_long"] == null ? null : json["title_long"],
        slug: json["slug"] == null ? null : json["slug"],
        year: json["year"] == null ? null : json["year"],
        rating: json["rating"] == null ? null : json["rating"].toDouble(),
        runtime: json["runtime"] == null ? null : json["runtime"],
        genres: json["genres"] == null
            ? null
            : List<String>.from(json["genres"].map((x) => x)),
        summary: json["summary"] == null ? null : json["summary"],
        descriptionFull:
            json["description_full"] == null ? null : json["description_full"],
        synopsis: json["synopsis"] == null ? null : json["synopsis"],
        ytTrailerCode:
            json["yt_trailer_code"] == null ? null : json["yt_trailer_code"],
        language: json["language"] == null
            ? null
            : languageValues.map[json["language"]],
        mpaRating: json["mpa_rating"] == null
            ? null
            : mpaRatingValues.map[json["mpa_rating"]],
        backgroundImage:
            json["background_image"] == null ? null : json["background_image"],
        backgroundImageOriginal: json["background_image_original"] == null
            ? null
            : json["background_image_original"],
        smallCoverImage: json["small_cover_image"] == null
            ? null
            : json["small_cover_image"],
        mediumCoverImage: json["medium_cover_image"] == null
            ? null
            : json["medium_cover_image"],
        largeCoverImage: json["large_cover_image"] == null
            ? null
            : json["large_cover_image"],
        state: json["state"] == null ? null : statValues.map[json["state"]],
        torrents: json["torrents"] == null
            ? null
            : List<Torrent>.from(
                json["torrents"].map((x) => Torrent.fromJson(x))),
        dateUploaded: json["date_uploaded"] == null
            ? null
            : DateTime.parse(json["date_uploaded"]),
        dateUploadedUnix: json["date_uploaded_unix"] == null
            ? null
            : json["date_uploaded_unix"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "url": url == null ? null : url,
        "imdb_code": imdbCode == null ? null : imdbCode,
        "title": title == null ? null : title,
        "title_english": titleEnglish == null ? null : titleEnglish,
        "title_long": titleLong == null ? null : titleLong,
        "slug": slug == null ? null : slug,
        "year": year == null ? null : year,
        "rating": rating == null ? null : rating,
        "runtime": runtime == null ? null : runtime,
        "genres":
            genres == null ? null : List<dynamic>.from(genres.map((x) => x)),
        "summary": summary == null ? null : summary,
        "description_full": descriptionFull == null ? null : descriptionFull,
        "synopsis": synopsis == null ? null : synopsis,
        "yt_trailer_code": ytTrailerCode == null ? null : ytTrailerCode,
        "language": language == null ? null : languageValues.reverse[language],
        "mpa_rating":
            mpaRating == null ? null : mpaRatingValues.reverse[mpaRating],
        "background_image": backgroundImage == null ? null : backgroundImage,
        "background_image_original":
            backgroundImageOriginal == null ? null : backgroundImageOriginal,
        "small_cover_image": smallCoverImage == null ? null : smallCoverImage,
        "medium_cover_image":
            mediumCoverImage == null ? null : mediumCoverImage,
        "large_cover_image": largeCoverImage == null ? null : largeCoverImage,
        "state": state == null ? null : statValues.reverse[state],
        "torrents": torrents == null
            ? null
            : List<dynamic>.from(torrents.map((x) => x.toJson())),
        "date_uploaded":
            dateUploaded == null ? null : dateUploaded.toIso8601String(),
        "date_uploaded_unix":
            dateUploadedUnix == null ? null : dateUploadedUnix,
      };
}

enum Language { ENGLISH }

final languageValues = EnumValues({"English": Language.ENGLISH});

enum MpaRating { R, EMPTY, PG_13, PG }

final mpaRatingValues = EnumValues({
  "": MpaRating.EMPTY,
  "PG": MpaRating.PG,
  "PG-13": MpaRating.PG_13,
  "R": MpaRating.R
});

enum Stat { OK }

final statValues = EnumValues({"ok": Stat.OK});

class Torrent {
  String url;
  String hash;
  Quality quality;
  Type type;
  int seeds;
  int peers;
  String size;
  int sizeBytes;
  DateTime dateUploaded;
  int dateUploadedUnix;

  Torrent({
    this.url,
    this.hash,
    this.quality,
    this.type,
    this.seeds,
    this.peers,
    this.size,
    this.sizeBytes,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  factory Torrent.fromJson(Map<String, dynamic> json) => Torrent(
        url: json["url"] == null ? null : json["url"],
        hash: json["hash"] == null ? null : json["hash"],
        quality:
            json["quality"] == null ? null : qualityValues.map[json["quality"]],
        type: json["type"] == null ? null : typeValues.map[json["type"]],
        seeds: json["seeds"] == null ? null : json["seeds"],
        peers: json["peers"] == null ? null : json["peers"],
        size: json["size"] == null ? null : json["size"],
        sizeBytes: json["size_bytes"] == null ? null : json["size_bytes"],
        dateUploaded: json["date_uploaded"] == null
            ? null
            : DateTime.parse(json["date_uploaded"]),
        dateUploadedUnix: json["date_uploaded_unix"] == null
            ? null
            : json["date_uploaded_unix"],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "hash": hash == null ? null : hash,
        "quality": quality == null ? null : qualityValues.reverse[quality],
        "type": type == null ? null : typeValues.reverse[type],
        "seeds": seeds == null ? null : seeds,
        "peers": peers == null ? null : peers,
        "size": size == null ? null : size,
        "size_bytes": sizeBytes == null ? null : sizeBytes,
        "date_uploaded":
            dateUploaded == null ? null : dateUploaded.toIso8601String(),
        "date_uploaded_unix":
            dateUploadedUnix == null ? null : dateUploadedUnix,
      };
}

enum Quality { THE_720_P, THE_1080_P }

final qualityValues =
    EnumValues({"1080p": Quality.THE_1080_P, "720p": Quality.THE_720_P});

enum Type { BLURAY, WEB }

final typeValues = EnumValues({"bluray": Type.BLURAY, "web": Type.WEB});

class Meta {
  int serverTime;
  String serverTimezone;
  int apiVersion;
  String executionTime;

  Meta({
    this.serverTime,
    this.serverTimezone,
    this.apiVersion,
    this.executionTime,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        serverTime: json["server_time"] == null ? null : json["server_time"],
        serverTimezone:
            json["server_timezone"] == null ? null : json["server_timezone"],
        apiVersion: json["api_version"] == null ? null : json["api_version"],
        executionTime:
            json["execution_time"] == null ? null : json["execution_time"],
      );

  Map<String, dynamic> toJson() => {
        "server_time": serverTime == null ? null : serverTime,
        "server_timezone": serverTimezone == null ? null : serverTimezone,
        "api_version": apiVersion == null ? null : apiVersion,
        "execution_time": executionTime == null ? null : executionTime,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
