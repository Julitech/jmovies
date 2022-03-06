import 'package:flutter/material.dart';
import 'package:jmovies/helpers/logic.dart';
import 'package:jmovies/helpers/values.dart';
import 'package:jmovies/items/grid_item.dart';
import 'package:jmovies/items/trending_item.dart';
import 'package:jmovies/models/movieList.dart';
import 'package:jmovies/providers/movie_list_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:jmovies/screens/all_movies.dart';

import 'widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //Trending Movies
  Movie _trendingMovie; //Movie Item
  List<int> trendingId = [];
  List<String> trendingTitle = [];
  List<String> trendingImgUrl = [];
  List<double> trendingRating = [];

  //Latest Movies
  Movie _latestMovie; //Movie Item
  List<int> latestId = [];
  List<String> latestTitle = [];
  List<String> latestImgUrl = [];
  List<double> latestRating = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: MyLogic.checkInternet(),
      builder: (
        BuildContext context,
        AsyncSnapshot<bool> internetConn,
      ) {
        if (!internetConn.hasData) {
          return Center(child: MyLoadingSpinner());
        } else {
          if (internetConn.data) {
            return FutureBuilder(
                future: Future.wait([
                  MovieListProvider().loadTrendingMovies(),
                  MovieListProvider().loadMoviesList(
                    sortBy: "date_added",
                    pageCount: 1,
                  ),
                ]),
                builder: (
                  BuildContext context,
                  AsyncSnapshot<List<dynamic>> snapshot,
                ) {
                  if (!snapshot.hasData) {
                    return Center(child: MyLoadingSpinner());
                  } else {
                    List trendingMovies = snapshot.data[0];
                    List latestMovies = snapshot.data[1];

                    for (var i = 0; i < trendingMovies.length; i++) {
                      var jsonData = trendingMovies[i];

                      _trendingMovie = Movie.fromJson(jsonData);

                      //Add loaded data to movie data
                      trendingId.add(_trendingMovie.id);
                      trendingTitle.add(_trendingMovie.titleLong);
                      trendingRating.add(_trendingMovie.rating);
                      trendingImgUrl.add(_trendingMovie.mediumCoverImage);
                    }

                    //Latest Movies
                    for (var i = 0; i < latestMovies.length; i++) {
                      _latestMovie = Movie.fromJson(latestMovies[i]);

                      //Add loaded data to movie data
                      latestId.add(_latestMovie.id);
                      latestTitle.add(_latestMovie.titleLong);
                      latestRating.add(_latestMovie.rating);
                      latestImgUrl.add(_latestMovie.mediumCoverImage);
                    }

                    return SingleChildScrollView(
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(
                                  left: 10, top: 10, bottom: 10),
                              child: Text(
                                "Most Popular",
                                style: Theme.of(context)
                                    .copyWith()
                                    .textTheme
                                    .headline5,
                              ),
                            ),
                            Container(
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  scrollDirection: Axis.horizontal,
                                  aspectRatio: 1.8,
                                  autoPlay: true,
                                  reverse: false,
                                  autoPlayInterval: Duration(seconds: 6),
                                  autoPlayAnimationDuration:
                                      Duration(milliseconds: 800),
                                  autoPlayCurve: Curves.easeInOut,
                                  enlargeCenterPage: true,
                                ),
                                items: <Widget>[
                                  for (var i = 0;
                                      i < trendingMovies.length;
                                      i++)
                                    TrendingMovieCard(
                                      trendingId[i],
                                      trendingTitle[i],
                                      trendingImgUrl[i],
                                      trendingRating[i],
                                    ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            //Categories options
                            Container(
                              alignment: Alignment.centerLeft,
                              margin:
                                  const EdgeInsets.only(left: 10, bottom: 10),
                              child: Text(
                                "Genres",
                                style: Theme.of(context)
                                    .copyWith()
                                    .textTheme
                                    .headline5,
                              ),
                            ),

                            //Categories
                            Container(
                              width: double.infinity,
                              height: 35,
                              padding: EdgeInsets.only(left: 10),
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (ctx, i) =>
                                    Categories(MyValues.genres[i]),
                                itemCount: MyValues.genres.length,
                              ),
                            ),
                            SizedBox(height: 20),
                            //Categories options
                            Container(
                              alignment: Alignment.centerLeft,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Movies",
                                    style: Theme.of(context)
                                        .copyWith()
                                        .textTheme
                                        .headline5,
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed(AllMovies.routeName);
                                    },
                                    textColor: MyValues.mainBlue,
                                    padding: const EdgeInsets.all(0),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                    child: Text(
                                      "Browse Movies",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),

                            //Latest Movies
                            Container(
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                padding: EdgeInsets.all(0),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: (0.75),
                                  mainAxisSpacing: 0,
                                ),
                                itemBuilder: (ctx, index) {
                                  return GridItem(
                                    latestId[index],
                                    latestTitle[index],
                                    latestImgUrl[index],
                                    latestRating[index],
                                  );
                                },
                                itemCount: 20,
                              ),
                            ),
                            SizedBox(height: 10),
                            RaisedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(AllMovies.routeName);
                              },
                              color: Colors.white,
                              elevation: 8,
                              textColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                  color: Colors.orange,
                                  width: 2,
                                ),
                              ),
                              child: Text(
                                "Browse All Movies",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: 100),
                          ],
                        ),
                      ),
                    );
                  }
                });
          } else {
            return NoInternet(this);
          }
        }
      },
    );
  }
}
