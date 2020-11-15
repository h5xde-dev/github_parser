import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String description;
  final ImageProvider image;
  final int stars;
  final int watchers;
  final int forks;

  CustomDialog({
    @required this.title,
    @required this.description,
    this.forks = 0,
    this.watchers = 0,
    this.stars = 0,
    this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 66.0 + 16,
                bottom: 16,
                left: 16,
                right: 16,
              ),
              margin: EdgeInsets.only(top: 66.0),
              decoration: new BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: const Offset(0.0, 10.0),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text('Watchers'),
                                  Text('$watchers'),
                                ],
                              )),
                          Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text('Stars'),
                                  Text('$stars'),
                                ],
                              )),
                          Container(
                              padding: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Text('Forks'),
                                  Text('$forks'),
                                ],
                              ))
                        ],
                      )),
                ],
              ),
            ),
            Positioned(
              left: 16,
              right: 16,
              child: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                backgroundImage: image,
                radius: 66.0,
              ),
            ),
          ],
        ));
  }
}
