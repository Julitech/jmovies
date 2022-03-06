class DecodeMovieDetails {
  String status;
  String statusMessage;
  Data data;

  DecodeMovieDetails({
    this.status,
    this.statusMessage,
    this.data,
  });

  DecodeMovieDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusMessage = json['status_message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_message'] = this.statusMessage;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  Movie movie;

  Data({this.movie});

  Data.fromJson(Map<String, dynamic> json) {
    movie = json['movie'] != null ? new Movie.fromJson(json['movie']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.movie != null) {
      data['movie'] = this.movie.toJson();
    }
    return data;
  }
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
  int downloadCount;
  int likeCount;
  String descriptionIntro;
  String descriptionFull;
  String ytTrailerCode;
  String language;
  String mpaRating;
  String backgroundImage;
  String backgroundImageOriginal;
  String smallCoverImage;
  String mediumCoverImage;
  String largeCoverImage;
  String mediumScreenshotImage1;
  String mediumScreenshotImage2;
  String mediumScreenshotImage3;
  String largeScreenshotImage1;
  String largeScreenshotImage2;
  String largeScreenshotImage3;
  List<Cast> cast;
  List<Torrents> torrents;
  String dateUploaded;
  int dateUploadedUnix;

  Movie(
      {this.id,
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
      this.downloadCount,
      this.likeCount,
      this.descriptionIntro,
      this.descriptionFull,
      this.ytTrailerCode,
      this.language,
      this.mpaRating,
      this.backgroundImage,
      this.backgroundImageOriginal,
      this.smallCoverImage,
      this.mediumCoverImage,
      this.largeCoverImage,
      this.mediumScreenshotImage1,
      this.mediumScreenshotImage2,
      this.mediumScreenshotImage3,
      this.largeScreenshotImage1,
      this.largeScreenshotImage2,
      this.largeScreenshotImage3,
      this.cast,
      this.torrents,
      this.dateUploaded,
      this.dateUploadedUnix});

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    imdbCode = json['imdb_code'];
    title = json['title'];
    titleEnglish = json['title_english'];
    titleLong = json['title_long'];
    slug = json['slug'];
    year = json['year'];
    rating = json['rating'].toDouble();
    runtime = json['runtime'];
    genres = json['genres'].cast<String>();
    downloadCount = json['download_count'];
    likeCount = json['like_count'];
    descriptionIntro = json['description_intro'];
    descriptionFull = json['description_full'];
    ytTrailerCode = json['yt_trailer_code'];
    language = json['language'];
    mpaRating = json['mpa_rating'];
    backgroundImage = json['background_image'];
    backgroundImageOriginal = json['background_image_original'];
    smallCoverImage = json['small_cover_image'];
    mediumCoverImage = json['medium_cover_image'];
    largeCoverImage = json['large_cover_image'];
    mediumScreenshotImage1 = json['medium_screenshot_image1'];
    mediumScreenshotImage2 = json['medium_screenshot_image2'];
    mediumScreenshotImage3 = json['medium_screenshot_image3'];
    largeScreenshotImage1 = json['large_screenshot_image1'];
    largeScreenshotImage2 = json['large_screenshot_image2'];
    largeScreenshotImage3 = json['large_screenshot_image3'];
    if (json['cast'] != null) {
      cast = new List<Cast>();
      json['cast'].forEach((v) {
        cast.add(new Cast.fromJson(v));
      });
    }
    if (json['torrents'] != null) {
      torrents = new List<Torrents>();
      json['torrents'].forEach((v) {
        torrents.add(new Torrents.fromJson(v));
      });
    }
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['imdb_code'] = this.imdbCode;
    data['title'] = this.title;
    data['title_english'] = this.titleEnglish;
    data['title_long'] = this.titleLong;
    data['slug'] = this.slug;
    data['year'] = this.year;
    data['rating'] = this.rating;
    data['runtime'] = this.runtime;
    data['genres'] = this.genres;
    data['download_count'] = this.downloadCount;
    data['like_count'] = this.likeCount;
    data['description_intro'] = this.descriptionIntro;
    data['description_full'] = this.descriptionFull;
    data['yt_trailer_code'] = this.ytTrailerCode;
    data['language'] = this.language;
    data['mpa_rating'] = this.mpaRating;
    data['background_image'] = this.backgroundImage;
    data['background_image_original'] = this.backgroundImageOriginal;
    data['small_cover_image'] = this.smallCoverImage;
    data['medium_cover_image'] = this.mediumCoverImage;
    data['large_cover_image'] = this.largeCoverImage;
    data['medium_screenshot_image1'] = this.mediumScreenshotImage1;
    data['medium_screenshot_image2'] = this.mediumScreenshotImage2;
    data['medium_screenshot_image3'] = this.mediumScreenshotImage3;
    data['large_screenshot_image1'] = this.largeScreenshotImage1;
    data['large_screenshot_image2'] = this.largeScreenshotImage2;
    data['large_screenshot_image3'] = this.largeScreenshotImage3;
    if (this.cast != null) {
      data['cast'] = this.cast.map((v) => v.toJson()).toList();
    }
    if (this.torrents != null) {
      data['torrents'] = this.torrents.map((v) => v.toJson()).toList();
    }
    data['date_uploaded'] = this.dateUploaded;
    data['date_uploaded_unix'] = this.dateUploadedUnix;
    return data;
  }
}

class Cast {
  String name;
  String characterName;
  String urlSmallImage;
  String imdbCode;

  Cast({this.name, this.characterName, this.urlSmallImage, this.imdbCode});

  Cast.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    characterName = json['character_name'];
    urlSmallImage = json['url_small_image'];
    imdbCode = json['imdb_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['character_name'] = this.characterName;
    data['url_small_image'] = this.urlSmallImage;
    data['imdb_code'] = this.imdbCode;
    return data;
  }
}

class Torrents {
  String url;
  String hash;
  String quality;
  String type;
  int seeds;
  int peers;
  String size;
  int sizeBytes;
  String dateUploaded;
  int dateUploadedUnix;

  Torrents(
      {this.url,
      this.hash,
      this.quality,
      this.type,
      this.seeds,
      this.peers,
      this.size,
      this.sizeBytes,
      this.dateUploaded,
      this.dateUploadedUnix});

  Torrents.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    hash = json['hash'];
    quality = json['quality'];
    type = json['type'];
    seeds = json['seeds'];
    peers = json['peers'];
    size = json['size'];
    sizeBytes = json['size_bytes'];
    dateUploaded = json['date_uploaded'];
    dateUploadedUnix = json['date_uploaded_unix'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['hash'] = this.hash;
    data['quality'] = this.quality;
    data['type'] = this.type;
    data['seeds'] = this.seeds;
    data['peers'] = this.peers;
    data['size'] = this.size;
    data['size_bytes'] = this.sizeBytes;
    data['date_uploaded'] = this.dateUploaded;
    data['date_uploaded_unix'] = this.dateUploadedUnix;
    return data;
  }
}
