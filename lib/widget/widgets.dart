import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jmovies/helpers/custom_route.dart';
import 'package:jmovies/helpers/values.dart';
import 'package:jmovies/screens/category_screen.dart';
import 'package:jmovies/screens/search_screen.dart';
import 'package:jmovies/widget/home.dart';

//My App Logo
class MainLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      margin: const EdgeInsets.only(top: 8, left: 10, bottom: 10),
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              color: Colors.black54,
              blurRadius: 3, //blurring the shadow
              offset: Offset(2, 2), //spreading or extending the shadow
              spreadRadius: 0.2)
        ],
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      child: Image.asset(
        "assets/images/logos/logo.png",
        fit: BoxFit.fill,
//        height: 50,
      ),
    );
  }
}

//Back Button
class MyBackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 3, bottom: 3),
      padding: const EdgeInsets.all(0),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black54,
              blurRadius: 3, //blurring the shadow
              offset: Offset(2, 2), //spreading or extending the shadow
              spreadRadius: 0.2)
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: MyValues.mainBlue,
        ),
      ),
    );
  }
}

//Action Bar Button
class MyActionButton extends StatelessWidget {
  final Function function;
  final IconData icon;

  MyActionButton(this.function, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, top: 3, bottom: 3),
      padding: const EdgeInsets.all(0),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: Colors.black54,
              blurRadius: 3, //blurring the shadow
              offset: Offset(2, 2), //spreading or extending the shadow
              spreadRadius: 0.2)
        ],
      ),
      child: IconButton(
        onPressed: function,
        icon: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

//Caption for movie genres
class Caption extends StatelessWidget {
  final String genre;

  Caption({@required this.genre});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          CategoryScreen.routeName,
          arguments: genre,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        margin: const EdgeInsets.only(top: 0, right: 8),
        color: MyValues.mainBlue,
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
            child: Text(
              genre,
              style: Theme.of(context).copyWith().textTheme.caption,
            )),
      ),
    );
  }
}

//Search Bar
class MySearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                      offset: Offset(2, 2),
                      spreadRadius: 0.2)
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                showCursor: false,
                readOnly: true,
                onTap: () {
                  Navigator.of(context).push(
                    CustomRoute(
                      previous: Home(),
                      builder: (context) => SearchScreen(),
                    ),
                  );
                },
                decoration: InputDecoration(
                  hintText: "Looking for a Movie?...",
                  hintStyle: TextStyle(color: MyValues.mainBlue, fontSize: 16),
                  prefixIcon: Material(
                    elevation: 0.0,
                    borderRadius: BorderRadius.circular(15),
                    child: Icon(
                      Icons.search,
                      color: Theme.of(context).primaryColor,
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
    );
  }
}

//Search Dropdown Container
class DropDownContainer extends StatelessWidget {
  final Widget child;

  DropDownContainer({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black54,
              blurRadius: 3,
              offset: Offset(2, 2),
              spreadRadius: 0.2)
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 0,
      ),
      height: 40,
      width: 160,
      child: child,
    );
  }
}

class MyExpansionTile extends StatelessWidget {
  final String question;
  final String answer;

  MyExpansionTile({this.question, this.answer});

  @override
  Widget build(BuildContext context) {
    TextStyle quesTextStyle = TextStyle(
        color: MyValues.mainBlue,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);

    TextStyle linksTextStyle = TextStyle(
        height: 1.6,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 15);

    return Container(
      margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MyValues.mainBlue, width: 2),
      ),
      child: ExpansionTile(
        title: Row(
          children: <Widget>[
            Container(
              child: Icon(
                Icons.live_help,
                color: Colors.white,
              ),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(20),
              ),
              width: 40,
              height: 40,
            ),
            Expanded(
              child: Text(
                question,
                maxLines: 2,
                style: quesTextStyle,
              ),
            )
          ],
        ),
        children: <Widget>[
          Container(
              padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
              margin: const EdgeInsets.only(left: 15, right: 10),
              alignment: Alignment.centerLeft,
              child: Text(
                answer,
                textAlign: TextAlign.justify,
                style: linksTextStyle,
              )),
        ],
      ),
    );
  }
}

class NoInternet extends StatelessWidget {
  final State state;

  NoInternet(this.state);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyValues.mainWhite,
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Image.asset(
              "assets/images/no_internet.jpeg",
              fit: BoxFit.fill,
              width: 200,
              height: 200,
            ),
          ),
          SizedBox(
            height: 0,
          ),
          Text(
            "Ooops!!!",
            style: TextStyle(
              color: Colors.red,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 7),
          Text(
            "No Internet Connection.\n"
            "Check your connection and Try Again.",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          RaisedButton.icon(
            color: Colors.white,
            elevation: 8,
            textColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.orange, width: 2)),
            onPressed: () {
              state.setState(() {});
            },
            icon: Icon(Icons.refresh, color: MyValues.mainBlue),
            label: Text(
              "Try Again",
              style: TextStyle(
                  color: MyValues.mainBlue, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}

class MyFlatButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function function;

  MyFlatButton(this.icon, this.label, this.function);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton.icon(
        onPressed: function,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        icon: Icon(
          icon,
          color: MyValues.mainBlue,
        ),
        label: Text(
          label,
          style:
              TextStyle(color: MyValues.mainBlue, fontWeight: FontWeight.bold),
        ),
        color: Colors.white,
        elevation: 8,
        textColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.orange, width: 2),
        ),
      ),
    );
  }
}

class MyRightFlatButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function function;

  MyRightFlatButton(this.icon, this.label, this.function);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: function,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                  color: MyValues.mainBlue, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 5),
            Icon(
              icon,
              color: MyValues.mainBlue,
            ),
          ],
        ),
        color: Colors.white,
        elevation: 8,
        textColor: Colors.black,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.orange, width: 2),
        ),
      ),
    );
  }
}

class LargeButton extends StatelessWidget {
  final Function function;
  final String label;
  final String imgPath;

  LargeButton(this.function, this.label, this.imgPath);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: function,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(25)),
            child: Image.asset(
              imgPath,
              height: 50,
              width: 50,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//Movie IMDB rating
class MyRatingBar extends StatelessWidget {
  final double rating;

  MyRatingBar(this.rating);

  @override
  Widget build(BuildContext context) {
    return RatingBar(
      initialRating: rating / 2,
      ignoreGestures: true,
      itemCount: 5,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemPadding: const EdgeInsets.all(0),
      itemSize: 13,
      onRatingUpdate: (rating) {},
      itemBuilder: (ctx, i) => Icon(
        Icons.star,
        color: MyValues.accentColor,
      ),
    );
  }
}

//Category
class Categories extends StatelessWidget {
  final String genre;

  Categories(this.genre);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      child: FlatButton(
        onPressed: () {
          Navigator.of(context).pushNamed(
            CategoryScreen.routeName,
            arguments: genre,
          );
        },
        splashColor: MyValues.accentColor,
        padding: const EdgeInsets.all(0),
        color: Theme.of(context).accentColor.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
          side: BorderSide(width: 1.5, color: MyValues.accentColor),
        ),
        child: Text(
          genre,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

//Circular avatars for movie cast
class MyCircleAvatar extends StatelessWidget {
  final String name;
  final String imgUrl;

  MyCircleAvatar(this.name, this.imgUrl);

  @override
  Widget build(BuildContext context) {
    var singleName = name.split(" ");
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: CachedNetworkImage(
            width: 60,
            height: 60,
            imageUrl: imgUrl,
            fit: BoxFit.cover,
            placeholder: (ctx, value) {
              return Image.asset(
                "assets/images/placeholder.jpeg",
                width: 60,
                height: 60,
              );
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 5, bottom: 0, top: 5, right: 5),
          child: Text(
            singleName.first + "\n" + singleName.last,
            style: TextStyle(
                fontSize: 13,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.bold),
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}

class MoviePhoto extends StatelessWidget {
  final List<String> imgUrl;
  final int index;

  MoviePhoto(this.imgUrl, this.index);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PageController controller = PageController(initialPage: index);
        showDialog(
            context: context,
            builder: (ctx) => Dialog(
                  elevation: 10,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: MyValues.mainWhite, width: 1),
                  ),
                  child: Container(
                    height: 200,
                    child: Stack(
                      children: <Widget>[
                        PageView(
                          scrollDirection: Axis.horizontal,
                          controller: controller,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: imgUrl[0],
                                fit: BoxFit.fill,
                                height: 200,
                                progressIndicatorBuilder:
                                    (ctx, value, progress) {
                                  return Container(
                                    color: Colors.white,
                                    height: 200,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: progress.progress,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: imgUrl[1],
                                fit: BoxFit.fill,
                                height: 200,
                                progressIndicatorBuilder:
                                    (ctx, value, progress) {
                                  return Container(
                                    color: Colors.white,
                                    height: 200,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        value: progress.progress,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                imageUrl: imgUrl[2],
                                fit: BoxFit.fill,
                                height: 200,
                                progressIndicatorBuilder:
                                    (ctx, value, progress) {
                                  return Container(
                                    color: Colors.white,
                                    height: 200,
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
                        Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Container(
//                            color: Colors.grey[800].withOpacity(0.5),
                            padding: const EdgeInsets.all(20.0),
                            child: Center(
                              child: DotsIndicator(
                                controller: controller,
                                itemCount: imgUrl.length,
                                onPageSelected: (int page) {
                                  controller.animateToPage(
                                    page,
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.ease,
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ));
      },
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: imgUrl[index],
            height: 100,
            width: 150,
            fit: BoxFit.fill,
            progressIndicatorBuilder: (ctx, value, progress) {
              return Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 2, color: MyValues.mainBlue)),
                child: Center(
                  child: CircularProgressIndicator(
                    value: progress.progress,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}

//Row Title and value
class TitleRow extends StatelessWidget {
  final String title;
  final String value;

  TitleRow(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(title, style: Theme.of(context).textTheme.subtitle2),
        ),
        Expanded(
          flex: 1,
          child: Text(value, style: Theme.of(context).textTheme.overline),
        ),
      ],
    );
  }
}

//Custom Progress Dialog
class MyLoadingSpinner extends StatefulWidget {
  @override
  _MyLoadingSpinnerState createState() => _MyLoadingSpinnerState();
}

class _MyLoadingSpinnerState extends State<MyLoadingSpinner>
    with SingleTickerProviderStateMixin {
  Animation<double> sizeAnim;
  Animation<Color> colorAnim;
  CurvedAnimation curve;

  AnimationController controller;

  @override
  void initState() {
    super.initState();
    this.controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    this.curve =
        CurvedAnimation(parent: this.controller, curve: Curves.easeInOut);
    this.sizeAnim = Tween<double>(begin: 20, end: 70).animate(this.curve);
    this.controller.addListener(() => setState(() {}));
    this.controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    this.controller.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          this.controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          this.controller.forward();
        }
      },
    );
    return Container(
      color: MyValues.mainWhite,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: SizedBox(
              child: CircularProgressIndicator(
                backgroundColor: MyValues.mainBlue,
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
              height: 100,
              width: 100,
            ),
          ),
          Center(
            child: Container(
              child: Image.asset(
                "assets/images/logos/logo_transparent.png",
                fit: BoxFit.contain,
                height: sizeAnim.value,
                width: sizeAnim.value,
              ),
            ),
          )
        ],
      ),
    );
  }
}

//Movie Rating Tag
class MyRatingTag extends StatelessWidget {
  final double rating;

  MyRatingTag(this.rating);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 18.0,
      left: 0.0,
      child: Container(
        padding: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.7),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0))),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.star,
              color: Theme.of(context).accentColor,
              size: 13.0,
            ),
            SizedBox(
              width: 2.0,
            ),
            Text(
              rating.toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

void showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      toastLength: Toast.LENGTH_LONG,
      textColor: Colors.white,
      backgroundColor: Colors.orange);
}
