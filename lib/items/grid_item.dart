import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jmovies/helpers/values.dart';
import 'package:jmovies/screens/movie_details.dart';
import 'package:jmovies/widget/widgets.dart';

class GridItem extends StatelessWidget {
  final int id;
  final String title;
  final String url;
  final double rating;

  GridItem(this.id, this.title, this.url, this.rating);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                MovieDetails.routeName,
                arguments: id,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black87,
                      blurRadius: 6, //blurring the shadow
                      offset: Offset(4, 4), //spreading or extending the shadow
                      spreadRadius: 0.7)
                ],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: GridTile(
                        child: SizedBox(
                          height: 220,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: url,
                            width: double.infinity,
                            fit: BoxFit.fill,
                            progressIndicatorBuilder: (ctx, value, progress) {
                              return Container(
                                height: 220,
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
                      ),
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
                              title,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            alignment: Alignment.centerLeft,
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            padding: const EdgeInsets.only(bottom: 10),
                            margin: const EdgeInsets.only(left: 10, top: 0),
                            child: MyRatingBar(rating),
                          ),
                        ],
                      ),
                    ),
                  ),
                  //Rating Tag
                  MyRatingTag(rating),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
