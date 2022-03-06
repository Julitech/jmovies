import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:jmovies/helpers/logic.dart';
import 'package:jmovies/helpers/values.dart';
import 'package:jmovies/items/torrent_item.dart';
import 'package:jmovies/models/movie.dart';
import 'package:jmovies/providers/movie_provider.dart';
import 'package:jmovies/widget/trailer.dart';
import 'package:jmovies/widget/widgets.dart';
import 'package:share/share.dart';

class MovieDetails extends StatefulWidget {
  static const routeName = '/details';

  MovieDetails({Key key}) : super(key: key);

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  Movie _movieDetails;
  bool _moreText = true;
  String storyLine;
  String shortText;
  String fullText;
  List<Cast> cast;
  List<String> screenshot;
  List<String> genres;
  List<Torrents> torrents;

  @override
  Widget build(BuildContext context) {
    final String movieId = ModalRoute.of(context).settings.arguments.toString();
    TextTheme text = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: <Widget>[
          Container(
            child: MyActionButton(
              () {
                if (_movieDetails != null) {
                  showDialog(
                      context: context,
                      builder: (ctx) => Dialog(
                            elevation: 10,
                            backgroundColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                  color: MyValues.mainWhite, width: 2),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: CachedNetworkImage(
                                    imageUrl: _movieDetails.largeCoverImage,
                                    fit: BoxFit.fill,
                                    progressIndicatorBuilder:
                                        (ctx, value, progress) {
                                      return Container(
//                                width: double.infinity,
                                        color: Colors.white,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            value: progress.progress,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ));
                }
              },
              Icons.remove_red_eye,
            ),
          ),
          Container(
            child: MyActionButton(
              () async {
                Future<Uri> createMovieLink({@required int movieId}) async {
                  DynamicLinkParameters params = DynamicLinkParameters(
                      uriPrefix: "https://jmovie.page.link?movie",
                      link: Uri.parse(
                          "https://jmovie.page.link?movieid=$movieId"),
                      androidParameters: AndroidParameters(
                        packageName: "com.julitech.jmovies",
                        fallbackUrl: Uri.parse(MyValues.playStoreURL),
                      ),
                      socialMetaTagParameters: SocialMetaTagParameters(
                          imageUrl: Uri.parse(_movieDetails.mediumCoverImage),
                          title: "Download ${_movieDetails.title} from JMovies",
                          description: _movieDetails.descriptionIntro));
                  final link = await params.buildShortLink();
                  return link.shortUrl;
                }

                Uri movieLink =
                    await createMovieLink(movieId: _movieDetails.id);
                Share.share(movieLink.toString());
              },
              Icons.share,
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      body: FutureBuilder(
        future: MyMovieProvider().decodeMovieDetails(
          movieId,
        ),
        builder: (BuildContext context, AsyncSnapshot<Movie> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: MyLoadingSpinner());
          } else {
            _movieDetails = snapshot.data;
            cast = _movieDetails.cast;
            genres = _movieDetails.genres;
            torrents = _movieDetails.torrents;
            storyLine = _movieDetails.descriptionIntro;
            //Process storyline
            if (storyLine.length > 200) {
              shortText = storyLine.substring(0, 200);
              fullText = storyLine.substring(200, storyLine.length);
            } else {
              shortText = storyLine;
              fullText = "";
            }
            screenshot = [
              _movieDetails.mediumScreenshotImage1,
              _movieDetails.mediumScreenshotImage2,
              _movieDetails.mediumScreenshotImage3
            ];

            return CachedNetworkImage(
              imageUrl: _movieDetails.largeCoverImage,
              progressIndicatorBuilder: (context, value, progress) {
//                return Center(
//                  child: CircularProgressIndicator(
//                    value: progress.progress,
//                  ),
//                );
                return Center(child: MyLoadingSpinner());
              },
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.fill,
                  ),
                  color: MyValues.mainBlue,
                ),
                child: DraggableScrollableSheet(
                  expand: true,
                  initialChildSize: .60,
                  maxChildSize: .87,
                  minChildSize: .60,
                  builder: (ctx, scroll) {
                    return Container(
                      child: SingleChildScrollView(
                        controller: scroll,
                        child: Card(
                          margin: const EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                width: 60,
                                height: 3,
                                margin:
                                    const EdgeInsets.only(top: 10, bottom: 0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.orange,
                                ),
                              ),

                              //Movie Title
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(
                                  left: 10,
                                  right: 20,
                                  top: 0,
                                ),
                                padding: EdgeInsets.only(top: 10),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        _movieDetails.titleLong,
                                        maxLines: 5,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              //IMDB Ratings
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(
                                  left: 10,
                                  right: 20,
                                  top: 5,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    MyRatingBar(_movieDetails.rating),
                                  ],
                                ),
                              ),

                              //Movie Genre
                              Container(
                                width: double.infinity,
                                height: 20,
                                margin:
                                    const EdgeInsets.only(top: 10, left: 10),
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (ctx, i) => Caption(
                                    genre: genres[i],
                                  ),
                                  itemCount: genres.length,
                                ),
                              ),

                              SizedBox(height: 20),
                              //Trailer video player
                              TrailerContainer(_movieDetails.ytTrailerCode),
                              SizedBox(height: 20),
                              //Movie Stats
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: <Widget>[
                                    TitleRow(
                                      "Duration:",
                                      MyLogic.getDuration(
                                          _movieDetails.runtime),
                                    ),
                                    SizedBox(height: 10),
                                    TitleRow(
                                      "Language:",
                                      _movieDetails.language,
                                    ),
                                    SizedBox(height: 10),
                                    TitleRow(
                                      "Downloads:",
                                      _movieDetails.downloadCount.toString(),
                                    ),
                                    SizedBox(height: 10),
                                    TitleRow(
                                      "Release Date:",
                                      _movieDetails.year.toString(),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 20),

                              //StoryLine
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Storyline",
                                  style: text.headline5,
                                ),
                              ),

                              //Movie Storyline
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(
                                    left: 10, top: 10, right: 10),
                                child: fullText.isEmpty
                                    ? Text(
                                        shortText,
                                        style: text.subtitle1,
                                        textAlign: TextAlign.justify,
                                      )
                                    : Column(
                                        children: <Widget>[
                                          Text(
                                            _moreText
                                                ? (shortText + "...")
                                                : (shortText + fullText),
                                            textAlign: TextAlign.justify,
                                            style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              height: 1.5,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    _moreText = !_moreText;
                                                  });
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      right: 10,
                                                      top: 10,
                                                      bottom: 10),
                                                  child: Text(
                                                    _moreText
                                                        ? "show more"
                                                        : "show less",
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .primaryColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                              ),

                              //Photos Title
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: const EdgeInsets.only(
                                  left: 10,
                                  bottom: 10,
                                  top: 10,
                                ),
                                padding: const EdgeInsets.only(top: 0),
                                child: Text(
                                  "Photos",
                                  style: text.headline5,
                                ),
                              ),
                              //Movie Photos
                              Container(
                                width: double.infinity,
                                height: 100,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (ctx, i) =>
                                      MoviePhoto(screenshot, i),
                                  itemCount: 3,
                                ),
                              ),

                              SizedBox(height: 20),
                              //Cast
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10, bottom: 10),
                                child: Text(
                                  "Cast",
                                  style: text.headline5,
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  if (cast != null)
                                    for (var i in cast)
                                      if (i.urlSmallImage != null)
                                        MyCircleAvatar(i.name, i.urlSmallImage),
                                ],
                              ),
                              SizedBox(height: 20),

                              //Download Title
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 10),
                                child: Text("Download", style: text.headline5),
                              ),

                              //Torrents Item
                              Container(
                                width: double.infinity,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 5,
                                ),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: torrents.length,
                                  padding: const EdgeInsets.all(0),
                                  itemBuilder: (ctx, index) {
                                    return Container(
                                      margin: const EdgeInsets.only(bottom: 5),
                                      child: TorrentItem(
                                        torrents[index],
                                        _movieDetails.titleLong,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
