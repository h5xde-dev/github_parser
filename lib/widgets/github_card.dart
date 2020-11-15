import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class GithubCard extends StatelessWidget {
  GithubCard(
      {this.name = '',
      this.fullName = '',
      this.description = '',
      this.ownerAvatar,
      this.widthOfCard = 200,
      this.isPrivate = false});

  final String name;
  final String fullName;
  final String ownerAvatar;
  final String description;
  final double widthOfCard;
  final bool isPrivate;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widthOfCard,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(),
          Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  image: DecorationImage(
                      image: ResizeImage(
                          CachedNetworkImageProvider(ownerAvatar),
                          height: 100,
                          width: 100,
                          allowUpscaling: true),
                      fit: BoxFit.fill)),
              child: Center()),
          Padding(
            padding: EdgeInsets.only(left: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    width: widthOfCard - 20,
                    child: Text(fullName,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            color: (isPrivate) ? Colors.grey : Colors.green,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                            padding: EdgeInsets.all(5),
                            child: (isPrivate)
                                ? Text(
                                    'Private',
                                    style: TextStyle(fontSize: 10),
                                  )
                                : Text(
                                    'Public',
                                    style: TextStyle(fontSize: 10),
                                  ))),
                  ],
                ),
                Divider(),
                Container(
                    width: widthOfCard,
                    child: Text(
                      description,
                      style: TextStyle(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ))
              ],
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
