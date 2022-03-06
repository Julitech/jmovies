import 'package:flutter/material.dart';
import 'package:jmovies/helpers/values.dart';
import 'package:jmovies/widget/widgets.dart';
import 'package:android_intent/android_intent.dart';

class HelpScreen extends StatelessWidget {
  static const routeName = "/help";

  @override
  Widget build(BuildContext context) {
    TextStyle ansTextStyle = TextStyle(color: Colors.black, height: 1.6);
    TextStyle quesTextStyle = TextStyle(
        color: MyValues.mainBlue,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic);

    TextStyle linksTextStyle = TextStyle(
        height: 1.6,
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 15);

    return Scaffold(
      backgroundColor: MyValues.mainWhite,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            elevation: 0,
            expandedHeight: 150,
            titleSpacing: 0,
            automaticallyImplyLeading: false,
            leading: MyBackButton(),
            backgroundColor: MyValues.mainWhite,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "FAQs & Help",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: MyValues.mainBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Image.asset(
                "assets/images/faq.jpeg",
                fit: BoxFit.fill,
                color: MyValues.mainWhite.withOpacity(0.5),
                colorBlendMode: BlendMode.srcOver,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              MyExpansionTile(
                question: "What is JMovies?",
                answer:
                    "Answer. JMovies is a Mobile App for Downloading High Quality Movies."
                    " It can be installed on all android phones for users to enjoy",
              ),
              MyExpansionTile(
                question: "Is JMovies free?",
                answer:
                    "Answer: JMovies is an entirely free movie downloading app with no subscriptions or fees."
                    " So sit back and enjoy.",
              ),
              MyExpansionTile(
                question: "How to Download a Movie",
                answer: "Answer. Select a particular movie you like.\n"
                    "Select your preferred quality from the download options.\n"
                    "Download the movie torrent file.\n"
                    "Then go to any torrent downloading app of your choice to download the movie.",
              ),
              MyExpansionTile(
                question: "How to Download from a torrent",
                answer:
                    "Answer. With the help of torrent files you can download high quality movies much faster than normal download process."
                    "\nMovies can be downloaded from torrent files using torrents downloading apps available on all devices. ",
              ),
              Container(
                margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
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
                          "Torrent downloading apps",
                          maxLines: 3,
                          style: quesTextStyle,
                        ),
                      )
                    ],
                  ),
                  children: <Widget>[
                    Container(
                        padding: const EdgeInsets.only(
                            left: 5, right: 5, top: 0, bottom: 10),
                        margin: const EdgeInsets.only(left: 15, right: 10),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Torrents downloading Apps and software are available for you to download movies from torrent files."
                              "Click to download app"
                              "\n\nAndroid apps..\n",
                              textAlign: TextAlign.justify,
                              style: linksTextStyle,
                            ),
                            FlatButton(
                              onPressed: () {
                                AndroidIntent intent = AndroidIntent(
                                  action: "action_view",
                                  data: Uri.encodeFull(
                                      "market://details?id=com.delphicoder.flud"),
                                );
                                intent.launch();
                              },
                              textColor: MyValues.mainBlue,
                              padding: const EdgeInsets.all(0),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              child: Text(" 1. Flud Torrent Downloader"),
                            ),
                            FlatButton(
                              onPressed: () {
                                AndroidIntent intent = AndroidIntent(
                                  action: "action_view",
                                  data: Uri.encodeFull(
                                      "market://details?id=com.bittorrent.client"),
                                );
                                intent.launch();
                              },
                              textColor: MyValues.mainBlue,
                              padding: const EdgeInsets.all(0),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              child: Text("2. Bittorrent"),
                            ),
                            FlatButton(
                              onPressed: () {
                                AndroidIntent intent = AndroidIntent(
                                  action: "action_view",
                                  data: Uri.encodeFull(
                                      "market://details?id=com.utorrent.client"),
                                );
                                intent.launch();
                              },
                              textColor: MyValues.mainBlue,
                              padding: const EdgeInsets.all(0),
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              child: Text("3. UTorrent"),
                            ),
                            Text(
                              "PC\n"
                              "1. Utorrent\n"
                              "2. Bittorrent",
                              style: ansTextStyle,
                            )
                          ],
                        )),
                  ],
                ),
              ),
              MyExpansionTile(
                question: "Troubleshooting",
                answer:
                    "If you're having connection problems. Please switch to a fast Mobile Netwok or WIFI",
              ),
              SizedBox(
                height: 20,
              ),
            ]),
          )
        ],
      ),
    );
  }
}
