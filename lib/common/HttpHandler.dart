import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/common/Constants.dart';
import 'package:movie_app/model/Media.dart';
import 'package:movie_app/common/MediaProvider.dart';

class HttpHandler{
    static final _httpHandler = HttpHandler();
    final String _baseUrl = "api.themoviedb.org";
    final String _lenguaje = "es-ES";

    static HttpHandler get(){
      return _httpHandler;
    }

    Future<dynamic> getJson(Uri uri,) async{
      http.Response response = await http.get(uri);
      return json.decode(response.body);
    }

    Future<List<Media>> fetchMovies({String category : "popular"}) async{ 
      var uri = Uri.http(_baseUrl,"3/movie/$category",{
        'api_key' : API_KEY,
        'page' : "1",
        'language' : _lenguaje
      });

      return getJson(uri).then(((data) => 
        data['results'].map<Media>((item) => Media(item, MediaType.movie)).toList()
      ));
    }


    Future<List<Media>> fetchShow({String category : "popular"}) async{
      var uri = Uri.http(_baseUrl,"3/tv/$category",{
        'api_key' : API_KEY,
        'page' : "1",
        'language' : _lenguaje
      });

      return getJson(uri).then(((data) => 
        data['results'].map<Media>((item) => Media(item, MediaType.show)).toList()
      ));
    }
}