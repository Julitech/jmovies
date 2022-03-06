import 'dart:convert';

Wel welcomeFromJson(String str) => Wel.fromJson(json.decode(str));

String welcomeToJson(Wel data) => json.encode(data?.toJson());

class Wel {
  String status;
  String statusMessage;
  Data data;
  Meta meta;

  Wel({
    this.status,
    this.statusMessage,
    this.data,
    this.meta,
  });

  factory Wel.fromJson(Map<String, dynamic> json) => Wel(
        status: json["status"],
        statusMessage: json["status_message"],
        data: Data.fromJson(json["data"]),
        meta: Meta.fromJson(json["@meta"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "status_message": statusMessage,
        "data": data.toJson(),
        "@meta": meta.toJson(),
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
        movieCount: json["movie_count"],
        limit: json["limit"],
        pageNumber: json["page_number"],
        movies: List<Movie>.from(json["movies"].map((x) => Movie.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "movie_count": movieCount,
        "limit": limit,
        "page_number": pageNumber,
        "movies": List<dynamic>.from(movies.map((x) => x.toJson())),
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
  String language;
  String mpaRating;
  String backgroundImage;
  String backgroundImageOriginal;
  String smallCoverImage;
  String mediumCoverImage;
  String largeCoverImage;
  String state;
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
        id: json["id"],
        url: json["url"],
        imdbCode: json["imdb_code"],
        title: json["title"],
        titleEnglish: json["title_english"],
        titleLong: json["title_long"],
        slug: json["slug"],
        year: json["year"],
        rating: json["rating"].toDouble(),
        runtime: json["runtime"],
        genres: List<String>.from(json["genres"].map((x) => x)),
        summary: json["summary"],
        descriptionFull: json["description_full"],
        synopsis: json["synopsis"],
        ytTrailerCode: json["yt_trailer_code"],
        language: json["language"],
        mpaRating: json["mpa_rating"],
        backgroundImage: json["background_image"],
        backgroundImageOriginal: json["background_image_original"],
        smallCoverImage: json["small_cover_image"],
        mediumCoverImage: json["medium_cover_image"],
        largeCoverImage: json["large_cover_image"],
        state: json["state"],
//        torrents: json["torrents"].length > 1
//            ? List<Torrent>.from(
//                json["torrents"].map((x) => Torrent.fromJson(x)),
//              )
//            : List<Torrent>.from(json["torrents"][0].map((x) {
//                print(x);
//                return Torrent.fromJson(x);
//              })),
        torrents: List<Torrent>.from(
            json["torrents"].map((x) => Torrent.fromJson(x)).toList()),
        dateUploaded: DateTime.parse(json["date_uploaded"]),
        dateUploadedUnix: json["date_uploaded_unix"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "imdb_code": imdbCode,
        "title": title,
        "title_english": titleEnglish,
        "title_long": titleLong,
        "slug": slug,
        "year": year,
        "rating": rating,
        "runtime": runtime,
        "genres": List<dynamic>.from(genres.map((x) => x)),
        "summary": summary,
        "description_full": descriptionFull,
        "synopsis": synopsis,
        "yt_trailer_code": ytTrailerCode,
        "language": language,
        "mpa_rating": mpaRating,
        "background_image": backgroundImage,
        "background_image_original": backgroundImageOriginal,
        "small_cover_image": smallCoverImage,
        "medium_cover_image": mediumCoverImage,
        "large_cover_image": largeCoverImage,
        "state": state,
        "torrents": List<dynamic>.from(torrents.map((x) => x.toJson())),
        "date_uploaded": dateUploaded.toIso8601String(),
        "date_uploaded_unix": dateUploadedUnix,
      };
}

class Torrent {
  String url;
  String hash;
  String quality;
  String type;
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
        url: json["url"],
        hash: json["hash"],
        quality: json["quality"],
        type: json["type"],
        seeds: json["seeds"],
        peers: json["peers"],
        size: json["size"],
        sizeBytes: json["size_bytes"],
        dateUploaded: DateTime.parse(json["date_uploaded"]),
        dateUploadedUnix: json["date_uploaded_unix"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "hash": hash,
        "quality": quality,
        "type": type,
        "seeds": seeds,
        "peers": peers,
        "size": size,
        "size_bytes": sizeBytes,
        "date_uploaded": dateUploaded.toIso8601String(),
        "date_uploaded_unix": dateUploadedUnix,
      };
}

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
        serverTime: json["server_time"],
        serverTimezone: json["server_timezone"],
        apiVersion: json["api_version"],
        executionTime: json["execution_time"],
      );

  Map<String, dynamic> toJson() => {
        "server_time": serverTime,
        "server_timezone": serverTimezone,
        "api_version": apiVersion,
        "execution_time": executionTime,
      };
}
