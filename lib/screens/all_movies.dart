import 'package:flutter/material.dart';
import 'package:jmovies/helpers/values.dart';
import 'package:jmovies/items/grid_item.dart';
import 'package:jmovies/models/movieList.dart';
import 'package:jmovies/providers/movie_list_provider.dart';
import 'package:jmovies/widget/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';

class AllMovies extends StatefulWidget {
  AllMovies({Key key}) : super(key: key);

  static const routeName = "/all";

  @override
  _AllMoviesState createState() => _AllMoviesState();
}

class _AllMoviesState extends State<AllMovies> {
  Movie _movie;
  List<int> id = [];
  List<String> title = [];
  List<String> imgUrl = [];
  List<double> rating = [];

  int page = 1;

  String sortBy = "Date_added";

  List<PopupMenuItem<String>> sortByDropdown = MyValues.sortBy
      .map(
        (value) => PopupMenuItem<String>(
          child: Text(
            value,
            style: TextStyle(
              color: MyValues.mainBlue,
            ),
          ),
          value: value,
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(),
        title: AutoSizeText(
          "Browse All Movies",
          maxLines: 1,
          style: TextStyle(
            color: MyValues.mainBlue,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (ctx) {
              return sortByDropdown;
            },
            onSelected: (sort) {
              showToast("Sort By $sort");
              setState(() {
                sortBy = sort;
                _movie = null;
                id.clear();
                title.clear();
                imgUrl.clear();
                rating.clear();
              });
            },
            initialValue: sortBy,
            tooltip: "Sort By",
            offset: Offset(0, 100),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: MyValues.mainBlue, width: 2),
            ),
            child: MyActionButton(null, Icons.sort),
          )
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: FutureBuilder(
          future: MovieListProvider()
              .loadMoviesList(sortBy: sortBy.toLowerCase(), pageCount: page),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: MyLoadingSpinner());
            } else if (snapshot.connectionState == ConnectionState.done &&
                !snapshot.hasError) {
              for (var i = 0; i <= snapshot.data.length - 1; i++) {
                _movie = Movie.fromJson(snapshot.data[i]);

                id.add(_movie.id);
                title.add(_movie.titleLong);
                rating.add(_movie.rating);
                imgUrl.add(_movie.mediumCoverImage);
              }
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          MyFlatButton(
                            Icons.skip_previous,
                            "Previous",
                            () {
                              if (page > 1) {
                                showToast("Previous Page");
                                page = page - 1;
                                _movie = null;
                                id.clear();
                                title.clear();
                                imgUrl.clear();
                                rating.clear();
                                setState(() {});
                              } else {
                                showToast("This is the First Page");
                              }
                            },
                          ),
                          Text(
                            "PAGE $page",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          MyRightFlatButton(
                            Icons.skip_next,
                            "Next",
                            () {
                              showToast("Next Page");
                              page = page + 1;
                              _movie = null;
                              id.clear();
                              title.clear();
                              imgUrl.clear();
                              rating.clear();
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        padding: EdgeInsets.all(0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: (0.75),
                          mainAxisSpacing: 0,
                        ),
                        itemBuilder: (ctx, index) {
                          return GridItem(
                            id[index],
                            title[index],
                            imgUrl[index],
                            rating[index],
                          );
                        },
                        itemCount: 20,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          MyFlatButton(
                            Icons.skip_previous,
                            "Previous",
                            () {
                              if (page > 1) {
                                showToast("Previous Page");
                                page = page - 1;
                                _movie = null;
                                id.clear();
                                title.clear();
                                imgUrl.clear();
                                rating.clear();
                                setState(() {});
                              } else {
                                showToast("This is the First Page");
                              }
                            },
                          ),
                          MyRightFlatButton(
                            Icons.skip_next,
                            "Next",
                            () {
                              showToast("Next Page");
                              page = page + 1;
                              _movie = null;
                              id.clear();
                              title.clear();
                              imgUrl.clear();
                              rating.clear();
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              );
            } else if (snapshot.hasError &&
                snapshot.error == "Internet Error") {
              return NoInternet(this);
            } else {
              return Container();
            }
          }),
    );
  }
}
