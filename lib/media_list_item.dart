import 'package:flutter/material.dart';

import 'package:movie_app/model/Media.dart';

class MediaListItem extends StatelessWidget {
  final Media media;
  
  MediaListItem(this.media);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(children: <Widget>[
        Container(
          child: Stack(
            children: <Widget>[
                FadeInImage.assetNetwork(
          placeholder: "asset/placeholder.jpg",
          image: media.getBackDropUrl(),
          fit: BoxFit.cover,
          height: 200.0,
          width: double.infinity,
          fadeInDuration: Duration(milliseconds: 40),
        ),
            Positioned(left: 0.0,
            bottom: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration( color: Colors.grey[900].withOpacity(0.5)),
              constraints: BoxConstraints.expand(height: 55.0),
            ),
            ),
            Positioned(left: 10.0,
            bottom: 10.0,
            child: 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(child: 
              Text(media.title, style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,),)),
              Container(
                width: 250.0,
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(media.getGenres(),
                style: TextStyle(color: Colors.white),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                ),
                )
            ],)
            ,),
            Positioned(
              right: 5.0,
              bottom: 10.0,
              child: Column(children: <Widget>[
                Row(children: <Widget>[
                  Text(media.voteAverage.toString()),
                  Container(width: 4.0,),
                  Icon(Icons.star,color: Colors.white,size: 16.0, )

                ],),
                Container(height: 4.0,),
                Row(children: <Widget>[
                    Text(media.getReleaseYear().toString()),
                    Container(width: 4.0,),
                    Icon(Icons.date_range,color: Colors.white,size: 16.0, )
                ],)
              ],),
            )
            ],
          ) 
          
        )
        
      ],),
    );
  }
}