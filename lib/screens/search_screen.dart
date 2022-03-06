import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jmovies/helpers/values.dart';
import 'package:jmovies/items/grid_item.dart';
import 'package:jmovies/models/movieList.dart';
import 'package:jmovies/providers/movie_list_provider.dart';
import 'package:jmovies/widget/widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/search";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<DropdownMenuItem<String>> qualityDropdown = MyValues.quality
      .map(
        (value) => DropdownMenuItem(
          child: Text(value),
          value: value,
        ),
      )
      .toList();
  List<DropdownMenuItem<int>> ratingsDropdown = MyValues.ratings
      .map(
        (val) => DropdownMenuItem<int>(
          child: Text(val.toString() + "+"),
          value: val,
        ),
      )
      .toList();
  List<DropdownMenuItem<String>> genresDropdown = MyValues.genres
      .map(
        (value) => DropdownMenuItem<String>(
          child: AutoSizeText(value, maxLines: 1),
          value: value,
        ),
      )
      .toList();

  List<DropdownMenuItem<String>> sortByDropdown = MyValues.sortBy
      .map(
        (value) => DropdownMenuItem<String>(
          child: AutoSizeText(value, maxLines: 1),
          value: value,
        ),
      )
      .toList();

  int ratingSelected;
  String genresSelected;
  String qualitySelected;
  String sortBySelected;
  String searchText;
  String searchUrl;
  TextEditingController controller = new TextEditingController();

  Movie _movie;
  List<int> id = [];
  List<String> title = [];
  List<String> imgUrl = [];
  List<double> rating = [];
  Stream<List<dynamic>> data;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle dropdownStyle = TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 18,
        fontFamily: 'Bellota');

    double deviceHeight = MediaQuery.of(context).size.height - kToolbarHeight;

    return Scaffold(
      backgroundColor: MyValues.mainWhite,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        leading: MyBackButton(),
        automaticallyImplyLeading: false,
        backgroundColor: MyValues.mainWhite,
        actions: <Widget>[
          Container(
            width: 250,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 8, top: 3),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 3, //blurring the shadow
                            offset: Offset(
                                2, 2), //spreading or extending the shadow
                            spreadRadius: 0.2)
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: TextField(
                      autofocus: true,
                      controller: controller,
                      cursorColor: MyValues.mainBlue,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.none,
                      onChanged: (val) {
                        searchText = val;
                      },
                      style: TextStyle(
                        color: MyValues.mainBlue,
                        fontSize: 18,
                      ),
                      decoration: InputDecoration(
                        hintText: "Enter the Movie Title...",
                        hintStyle:
                            TextStyle(color: MyValues.mainBlue, fontSize: 18),
                        prefixIcon: Material(
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(15),
                          child: Icon(
                            Icons.search,
                            color: MyValues.mainBlue,
                          ),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.only(top: 13, bottom: 13, right: 12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 150,
            width: double.infinity,
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            decoration: BoxDecoration(
              color: MyValues.mainWhite,
            ),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    DropDownContainer(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          style: dropdownStyle,
                          value: qualitySelected,
                          underline: null,
                          hint: Text(
                            "Quality:",
                            style: dropdownStyle,
                          ),
                          items: this.qualityDropdown,
                          onChanged: (String newValue) {
                            setState(() {
                              qualitySelected = newValue;
                              FocusScope.of(context).requestFocus(FocusNode());
                            });
                          },
                        ),
                      ),
                    ),
                    DropDownContainer(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          style: dropdownStyle,
                          value: ratingSelected,
                          isExpanded: true,
                          underline: null,
                          hint: Text(
                            "Rating:",
                            style: dropdownStyle,
                          ),
                          items: this.ratingsDropdown,
                          onChanged: (int newValue) {
                            setState(() {
                              ratingSelected = newValue;
                              FocusScope.of(context).requestFocus(FocusNode());
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    DropDownContainer(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          isExpanded: true,
                          style: dropdownStyle,
                          value: genresSelected,
                          underline: null,
                          hint: Text(
                            "Genres:",
                            style: dropdownStyle,
                          ),
                          items: this.genresDropdown,
                          onChanged: (String newValue) {
                            setState(() {
                              genresSelected = newValue;
                              FocusScope.of(context).requestFocus(FocusNode());
                            });
                          },
                        ),
                      ),
                    ),
                    DropDownContainer(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          style: dropdownStyle,
                          value: sortBySelected,
                          isExpanded: true,
                          underline: null,
                          hint: Text(
                            "Sort By:",
                            style: dropdownStyle,
                          ),
                          items: this.sortByDropdown,
                          onChanged: (String newValue) {
                            setState(() {
                              sortBySelected = newValue;
                              FocusScope.of(context).requestFocus(FocusNode());
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: RaisedButton(
                    onPressed: () {
                      //Hide Soft Keyboard
                      SystemChannels.textInput.invokeMethod("TextInput.hide");

                      if (searchText != null && searchText.isNotEmpty) {
                        searchUrl = "https://yts.mx/api/v2/list_movies.json?"
                            "limit=40&query_term=$searchText";

                        //Set empty default space to prevent error
                        searchUrl = searchUrl +
                            "&quality=${(qualitySelected ?? "")}"
                                "&genre=${(genresSelected ?? "")}"
                                "&sort_by=${(sortBySelected ?? "").toLowerCase()}"
                                "&minimum_rating=${(ratingSelected ?? 1)}";
                      }
                      data = MovieListProvider().searchMoviesList(searchUrl);
                      setState(() {
                        //CLear old search data
                        id.clear();
                        title.clear();
                        imgUrl.clear();
                        rating.clear();
                      });
                    },
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(
                          width: 2,
                          color: Colors.orange,
                        )),
                    child: Text(
                      "Search Movie",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: StreamBuilder(
                stream: data,
                builder: (ctx, snapshot) {
                  //When the search screen is opened
                  if (snapshot.connectionState == ConnectionState.none) {
                    return Container(
                      height: deviceHeight / 1.5,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Search Movies",
                            style: TextStyle(
                              fontSize: 25,
                              color: MyValues.mainBlue,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Enter a movie title to search.",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                  //Show loading spinner when loading data
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      height: deviceHeight / 1.5,
                      color: MyValues.mainWhite,
                      child: Center(child: MyLoadingSpinner()),
                      alignment: Alignment.center,
                    );
                  }
                  if (snapshot.data == null) {
                    return Center(
                      child: Container(
                        height: deviceHeight / 1.5,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ClipRRect(
                              child: Image.asset(
                                "assets/images/search_error.jpeg",
                                fit: BoxFit.fill,
                                height: 100,
                                width: 100,
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            Text(
                              "Ooops!!! No Movie found.",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Try again with a correct movie title.",
                              style: TextStyle(
                                fontSize: 17,
                                color: Colors.black,
                                height: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    );
                  }

                  if (!snapshot.hasData) {
                    return Container(
                      margin: const EdgeInsets.only(top: 100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            padding: const EdgeInsets.all(10),
                            child: Icon(
                              Icons.search,
                              size: 50,
                              color: MyValues.mainBlue,
                            ),
                          ),
                          Text(
                            "Enter a movie title to start searching.",
                            style:
                                TextStyle(fontSize: 17, color: Colors.blueGrey),
                          )
                        ],
                      ),
                    );
                  }

                  //Show error message when there is an error
                  if (snapshot.hasError) {
                    return Container(
                      margin: const EdgeInsets.only(top: 100),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ClipRRect(
                            child: Image.asset(
                              "assets/images/search_error.jpeg",
                              fit: BoxFit.fill,
                              height: 100,
                              width: 100,
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          Text(
                            "Ooops, we couldn't search for a movie.\n Try again with a correct movie title.",
                            style:
                                TextStyle(fontSize: 17, color: Colors.blueGrey),
                          )
                        ],
                      ),
                    );
                  }

                  //Loop through movie list and create different list info
                  //Snapshot length starts from 1 while index start from zero

                  for (var i = 0; i < snapshot.data.length; i++) {
                    var jsonData = snapshot.data[i];
                    _movie = Movie.fromJson(jsonData);
                    //Add loaded data to movie data
                    id.add(_movie.id);
                    title.add(_movie.titleLong);
                    rating.add(_movie.rating);
                    imgUrl.add(_movie.mediumCoverImage);
                  }

                  return Container(
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: (0.75),
                          mainAxisSpacing: 0),
                      itemBuilder: (ctx, index) => GridItem(
                        id[index],
                        title[index],
                        imgUrl[index],
                        rating[index],
                      ),
                      itemCount: snapshot.data.length,
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
