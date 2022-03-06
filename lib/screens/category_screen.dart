import 'package:flutter/material.dart';
import 'package:jmovies/helpers/values.dart';
import 'package:jmovies/items/grid_item.dart';
import 'package:jmovies/models/movieList.dart';
import 'package:jmovies/providers/movie_list_provider.dart';
import 'package:jmovies/widget/widgets.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = "/category";

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  //List of Movies data
  Movie _movie;
  List<int> id = [];
  List<String> title = [];
  List<String> imgUrl = [];
  List<double> rating = [];
  Future<List<dynamic>> data;
  Stream<List<dynamic>> dataStream;
  String genre;
  int page = 1;
  bool _init = true;

  String sortBy = "Download_count";

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

  Stream<List<dynamic>> loadMoviesStream() async* {
    final dataStream = MovieListProvider()
        .loadGenreMoviesStream(genre, sortBy.toLowerCase(), page: page);
    yield* dataStream;
  }

  @override
  void didChangeDependencies() {
    if (_init) {
      genre = ModalRoute.of(context).settings.arguments;
    } else {}
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height - kToolbarHeight;

    return Scaffold(
      backgroundColor: MyValues.mainWhite,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            elevation: 0,
            expandedHeight: 160,
            titleSpacing: 0,
            leading: MyBackButton(),
            automaticallyImplyLeading: false,
            backgroundColor: MyValues.mainWhite,
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
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                genre,
                style: TextStyle(
                  color: MyValues.mainBlue,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Image.asset(
                MyValues.bgImages[genre.toLowerCase()],
                fit: BoxFit.fill,
                color: MyValues.mainWhite.withOpacity(0.5),
                colorBlendMode: BlendMode.srcOver,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              StreamBuilder(
                stream: loadMoviesStream(),
                builder: (context, AsyncSnapshot<List> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: deviceHeight / 1.5,
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          MyLoadingSpinner(),
                        ],
                      ),
                    );
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    if (!snapshot.hasError) {
                      for (var i = 0; i <= snapshot.data.length - 1; i++) {
                        _movie = Movie.fromJson(snapshot.data[i]);

                        id.add(_movie.id);
                        title.add(_movie.titleLong);
                        rating.add(_movie.rating);
                        imgUrl.add(_movie.mediumCoverImage);
                      }
                      return Column(
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 10,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    style:
                                        Theme.of(context).textTheme.headline5,
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
                              )),
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
                                  id[index],
                                  title[index],
                                  imgUrl[index],
                                  rating[index],
                                );
                              },
                              itemCount: snapshot.data.length,
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
                      );
                    } else if (snapshot.error == "Internet Error") {
                      return Container(
                          margin: EdgeInsets.only(top: 30),
                          child: NoInternet(this));
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 20),
                            child: Text(
                              "PAGE $page",
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                          SizedBox(height: 30),
                          Text(
                            "Ooopppssss, Sorry",
                            style: Theme.of(context).textTheme.headline5,
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: Center(
                              child: Text(
                                  "Seems We have a problem with this page\nTry Previous Page or Next Page"),
                            ),
                          ),
                          SizedBox(height: 30),
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
                                MyFlatButton(Icons.skip_next, "Next", () {
                                  showToast("Next Page");
                                  page = page + 1;
                                  _movie = null;
                                  id.clear();
                                  title.clear();
                                  imgUrl.clear();
                                  rating.clear();
                                  setState(() {});
                                }),
                              ],
                            ),
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                          ),
                        ],
                      );
                    }
                  } else {
                    return Container();
                  }
                },
              ),
            ]),
          )
        ],
      ),
    );
  }
}
