import 'package:flutter/material.dart';
import 'package:movie_app/common/MediaProvider.dart';
import 'package:movie_app/media_list.dart';
class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final MediaProvider movieProvider = MovieProvider();
  final MediaProvider showProvider = ShowProvider();

  PageController _pageController;
  int _page = 0;
  MediaType mediaType = MediaType.movie;
  @override
  void initState() { 
    
    _pageController = PageController(initialPage: _page);
    super.initState();
  }

  @override
  void dispose() { 
    _pageController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ricky Movie"),
      actions: <Widget>[
        IconButton(icon: Icon(Icons.search,color: Colors.white,), onPressed: () {},)
      ],),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
              DrawerHeader(child: Material(),),
        ListTile(
          title: Text("Peliculas"),
          selected: mediaType == MediaType.movie,
          trailing: Icon(Icons.local_movies),
          onTap: (){
            _changeMediaTpye(MediaType.movie);
            Navigator.of(context).pop();
          },
        ),
        Divider(height: 5.0,),
        ListTile(
          title: Text("Television"),
          selected: mediaType == MediaType.show,
          trailing: Icon(Icons.live_tv),
          onTap: (){
            _changeMediaTpye(MediaType.show);
            Navigator.of(context).pop();
          },
        ),
        Divider(height: 5.0,),
        ListTile(
          title: Text("Cerrar"),
          trailing: Icon(Icons.close),
          onTap: () => Navigator.of(context).pop(),
        ),
          ],
        )
      ),
       body: PageView(children: 
             _getListMediaList(),
             controller: _pageController,
             onPageChanged: (int index){
               setState(() {
                 _page = index;
               });
             },
       ),
       bottomNavigationBar: BottomNavigationBar(
         items: _getFooterItems(),
         onTap: _navigationTapped,
         currentIndex: _page,
       ),
    );
  }

  List<BottomNavigationBarItem> _getFooterItems(){
    return mediaType == MediaType.movie ? [
      BottomNavigationBarItem(icon: Icon(Icons.thumb_up),title: Text("Populares")),
      BottomNavigationBarItem(icon: Icon(Icons.update),title: Text("Proximamente")),
      BottomNavigationBarItem(icon: Icon(Icons.star),title: Text("Mejor Valoradas"))
    ] : 
    [
      BottomNavigationBarItem(icon: Icon(Icons.thumb_up),title: Text("Populares")),
      BottomNavigationBarItem(icon: Icon(Icons.live_tv),title: Text("En emisión")),
      BottomNavigationBarItem(icon: Icon(Icons.star),title: Text("Mejor Valoradas"))
    ];
  }

  void _changeMediaTpye(MediaType type){
    if(mediaType != type){
      setState(() {
        mediaType = type;
      });
    }
  }
  List<Widget> _getListMediaList(){
    return (mediaType == MediaType.movie) ?
      <Widget>[
          MediaList(movieProvider, "popular"),
          MediaList(movieProvider, "upcoming"),
          MediaList(movieProvider, "top_rated")
      ]:
      <Widget>[
        MediaList(showProvider,"popular"),
        MediaList(showProvider,"on_the_air"),
        MediaList(showProvider,"top_rated"),  
      ];
    
  }

  void _navigationTapped(int page){
      _pageController.animateToPage(page, duration: const Duration(milliseconds: 300),curve: Curves.ease);
  }
}