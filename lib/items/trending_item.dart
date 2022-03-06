import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jmovies/helpers/values.dart';
import 'package:jmovies/screens/movie_details.dart';
import 'package:jmovies/widget/widgets.dart';

class TrendingMovieCard extends StatefulWidget {
  final int id;
  final String title;
  final String url;
  final double rating;

  TrendingMovieCard(this.id, this.title, this.url, this.rating);

  @override
  _TrendingMovieCardState createState() => _TrendingMovieCardState();
}

class _TrendingMovieCardState extends State<TrendingMovieCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(
            MovieDetails.routeName,
            arguments: widget.id.toString(),
          );
        },
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black87,
                blurRadius: 4,
                offset: Offset(2, 2),
                spreadRadius: 0.4,
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: widget.url,
                    width: double.infinity,
                    fit: BoxFit.fill,
                    progressIndicatorBuilder: (ctx, value, progress) {
                      return Container(
                        height: 100,
                        width: double.infinity,
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
                //Overlay title
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Card(
                    margin: const EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: MyValues.mainBlue.withOpacity(0.4),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: "Bellota",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          padding: const EdgeInsets.only(bottom: 10),
                          margin: const EdgeInsets.only(left: 10, top: 0),
                          child: MyRatingBar(widget.rating),
                        ),
                      ],
                    ),
                  ),
                ),
                //Rating Tag
                MyRatingTag(widget.rating),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
