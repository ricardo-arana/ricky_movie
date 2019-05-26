import 'package:flutter/material.dart';
import 'package:movie_app/common/HttpHandler.dart';
import 'package:movie_app/model/Media.dart';
import 'package:movie_app/media_list_item.dart';
import 'package:movie_app/common/MediaProvider.dart';

class MediaList extends StatefulWidget {
  final MediaProvider provider;
    String category;
   MediaList(this.provider, this.category);
  _MediaListState createState() => _MediaListState();
}

class _MediaListState extends State<MediaList> {
  List<Media> _media = List();

  @override
  void initState() {
    super.initState();
    loadMovies();
  }

  @override
  void didUpdateWidget(MediaList oldWidget) {
    if(oldWidget.provider.runtimeType != widget.provider.runtimeType){
      _media = List();
      loadMovies();
    }
    super.didUpdateWidget(oldWidget);

  }

  void loadMovies() async{
      var media = await widget.provider.fetchMedia(widget.category);
      setState(() {
        _media.addAll(media);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: ListView.builder(
         itemCount: _media.length,
         itemBuilder: (BuildContext context, int index){
           return MediaListItem(_media[index]);
         },
       ),
    );
  }
}