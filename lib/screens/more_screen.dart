import 'package:android_intent/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:jmovies/helpers/values.dart';
import 'package:jmovies/widget/widgets.dart';
import 'package:share/share.dart';
import 'package:auto_size_text/auto_size_text.dart';

import 'help_screen.dart';

class MoreScreen extends StatefulWidget {
  static const routeName = "/more";

  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: MyBackButton(),
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 200,
                margin: const EdgeInsets.only(top: 80),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      "assets/images/logos/logo_transparent.png",
                      fit: BoxFit.fill,
                      height: 50,
                      width: 80,
                    ),
                    SizedBox(height: 5),
                    Text(
                      "JMovies",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        fontFamily: "Sans-serif",
                        color: MyValues.mainBlue,
                      ),
                    ),
                    SizedBox(height: 5),
                    AutoSizeText(
                      "A Better Way Of Downloading"
                      "\nHigh Quality Movies",
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    LargeButton(
                      () {
                        Share.share(
                          "Hey,"
                          "\n\nJMovies is an Android App for Downloading High Quality Movies for Free."
                          "\n\nGet JMovies From PlayStore now"
                          "\n${MyValues.playStoreURL}",
                        );
                      },
                      "Share JMovies",
                      "assets/images/share.png",
                    ),
                    SizedBox(height: 20),
                    LargeButton(
                      () {
                        Navigator.of(context).pushNamed(HelpScreen.routeName);
                      },
                      "FAQs & Help",
                      "assets/images/help.png",
                    ),
                    SizedBox(height: 20),
                    LargeButton(
                      () {
                        showDialog(
                            context: context,
                            builder: (ctx) => Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                        width: 2, color: Colors.orange),
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Text(
                                          "Contact JMovies",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: MyValues.mainBlue,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 10),
                                        MyFlatButton(
                                          Icons.email,
                                          "Mail Us",
                                          () {
                                            AndroidIntent intent =
                                                AndroidIntent(
                                              action: "action_view",
                                              data: Uri.encodeFull(
                                                  "mailto:${MyValues.email}"),
                                            );
                                            intent.launch();
                                          },
                                        ),
                                        SizedBox(height: 10),
                                        MyFlatButton(
                                          Icons.language,
                                          "Visit JMovies Website",
                                          () {
                                            AndroidIntent intent =
                                                AndroidIntent(
                                              action: "action_view",
                                              data: Uri.encodeFull(
                                                  "https://bit.ly/jmoviesapp"),
                                            );
                                            intent.launch();
                                          },
                                        ),
                                        SizedBox(height: 10),
                                        MyFlatButton(
                                          Icons.question_answer,
                                          "Join Us on Whatsapp",
                                          () {
                                            AndroidIntent intent =
                                                AndroidIntent(
                                              action: "action_view",
                                              data: Uri.encodeFull(
                                                "https://chat.whatsapp.com/BH8f9zLwnlvLUYYuK8F6lD",
                                              ),
                                            );
                                            intent.launch();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ));
                      },
                      "Contact Us",
                      "assets/images/support.png",
                    ),
                    SizedBox(height: 20),
                    LargeButton(
                      () {
                        showDialog(
                            context: context,
                            builder: (ctx) {
                              return Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(
                                      width: 2, color: Colors.orange),
                                ),
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              color: Colors.orange, width: 2),
                                          color: MyValues.mainWhite,
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 15),
                                        child: Image.asset(
                                          "assets/images/logos/logo_transparent.png",
                                          fit: BoxFit.fill,
                                          height: 50,
                                          width: 80,
                                        ),
                                      ),
                                      Text(
                                        "JMovies",
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: MyValues.mainBlue,
                                            fontFamily: "Sans-serif",
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "A Better Way of Downloading High Quality Movies",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            "Version:",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "2.0",
                                            style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(height: 5),
                                      InkWell(
                                        onTap: () {
                                          AndroidIntent intent = AndroidIntent(
                                            action: "action_view",
                                            data: Uri.encodeFull(
                                              "http://jmoviesapp.000webhostapp.com/privacy-policy.html",
                                            ),
                                          );
                                          intent.launch();
                                        },
                                        child: Text(
                                          "Privacy Policy",
                                          style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
                                            decorationStyle:
                                                TextDecorationStyle.solid,
                                            color: MyValues.mainBlue,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "©2020 Julitech. All rights reserved",
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      "About JMovies",
                      "assets/images/logos/logo.png",
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
