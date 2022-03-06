import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:jmovies/helpers/values.dart';
import 'package:jmovies/screens/all_movies.dart';
import 'package:jmovies/screens/category_screen.dart';
import 'package:jmovies/screens/downloads.dart';
import 'package:jmovies/screens/help_screen.dart';
import 'package:jmovies/screens/movie_details.dart';
import 'package:jmovies/screens/search_screen.dart';
import 'package:jmovies/widget/home.dart';
import 'package:jmovies/widget/widgets.dart';
import 'package:provider/provider.dart';

import 'helpers/custom_route.dart';
import 'providers/movie_list_provider.dart';
import 'providers/movie_provider.dart';
import 'screens/more_screen.dart';

void main() {
//  Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runApp(
    FutureBuilder(
      future: Future.delayed(Duration(seconds: 3)),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/logos/logo_transparent.png",
                    fit: BoxFit.fill,
                    height: 80,
                    width: 150,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        } else {
          return MyApp();
        }
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: MyMovieProvider(),
        ),
        ChangeNotifierProvider.value(
          value: MovieListProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'JMovies',
        debugShowCheckedModeBanner: false,
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics())
        ],
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: MyValues.mainBlue,
          backgroundColor: Color(0xffEEEEEE),
          accentColor: Colors.orange,
          fontFamily: 'Bellota',
          textTheme: TextTheme(
            headline5: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
            caption: TextStyle(
                color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
            subtitle1: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
            subtitle2: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            overline: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        home: MyHomePage(),
        routes: {
          MovieDetails.routeName: (ctx) => MovieDetails(),
          SearchScreen.routeName: (ctx) => SearchScreen(),
          CategoryScreen.routeName: (ctx) => CategoryScreen(),
          AllMovies.routeName: (ctx) => AllMovies(),
          HelpScreen.routeName: (ctx) => HelpScreen()
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 1;

  List body = [
    MovieDownloads(),
    Home(),
  ];

  @override
  void initState() {
    initDynamicLinks();
    super.initState();
  }

  void initDynamicLinks() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    Uri movieLink = data?.link;

    if (movieLink != null) {
      var movieId = movieLink.queryParameters['movieid'];
      if (movieId != null) {
        Navigator.of(context).pushNamed(
          MovieDetails.routeName,
          arguments: movieId,
        );
      }
    } else {
      print("No Link Received");
    }

    FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData data) async {
        Uri deepLink = data?.link;
        if (deepLink != null) {
          var movieId = deepLink.queryParameters['movieid'];
          if (movieId != null) {
            Navigator.of(context).pushNamed(
              MovieDetails.routeName,
              arguments: movieId,
            );
          }
        } else {
          print("On Link No Link Received");
        }
      },
      onError: (OnLinkErrorException error) async {
        print("No Link Received" + error.message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: MainLogo(),
        backgroundColor: MyValues.mainWhite,
        elevation: 0,
        actions: <Widget>[MySearchBar()],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: body[index],
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        splashColor: Colors.orange,
        focusColor: Colors.orange,
        hoverColor: Colors.orange,
        elevation: 10,
        tooltip: "Home",
        onPressed: () {
          setState(() {
            index = 1;
          });
        },
        child: Icon(
          Icons.home,
          color: MyValues.mainBlue,
          size: 35,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: MyValues.mainBlue,
        clipBehavior: Clip.antiAlias,
        elevation: 0,
        shape: CircularNotchedRectangle(),
        child: Ink(
          color: Colors.transparent,
          height: 57.0,
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: BottomNavigationBar(
                    selectedItemColor: Colors.white,
                    selectedIconTheme: IconThemeData(color: Colors.white),
                    selectedLabelStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    unselectedItemColor: MyValues.mainWhite,
                    unselectedLabelStyle: TextStyle(color: Colors.white),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    currentIndex: index,
                    onTap: (int i) {
                      if (i == 2) {
                        Navigator.of(context).push(
                          CustomRoute(
                            previous: this.widget,
                            builder: (context) => MoreScreen(),
                          ),
                        );
                      } else {
                        setState(() {
                          index = i;
                        });
                      }
                    },
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.cloud_download),
                        title: Text(
                          "My Movies",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      BottomNavigationBarItem(
                        backgroundColor: Colors.transparent,
                        icon: Icon(
                          Icons.home,
                          color: Colors.transparent,
                        ),
                        title: Text(""),
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.more),
                        title: Text(
                          "More",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
