import 'dart:convert';

import 'package:http/http.dart';
import 'package:movie/core/constant.dart';
import 'package:http/http.dart' as http;
import 'package:movie/models/catogry_models/ReleaseModel.dart';
import 'package:movie/models/catogry_models/movie.dart';
import 'package:movie/models/moreLikeThis.dart';
import 'package:movie/models/searchModel.dart';
import 'package:movie/models/topSide.dart';

import '../../../models/TopReated.dart';
import '../../../models/videoResults.dart';
import '../../../models/newReleases.dart';

class ApiManger {
  static Future<ReleaseModel> getCategory() async {
    final response = await http.get(
      Uri.parse(
          'https://$BASE/3/genre/movie/list?api_key=$APIHEY&adult=false&language=en-US'),
    );
    var releaseResponse = ReleaseModel.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return releaseResponse;
    } else {
      throw Exception('Failed to load the category');
    }
  }

  static Future<Movies> getMoviesByList(int genreId) async {
    var response = await http.get(
      Uri.parse("https://$BASE/3/discover/movie?api_key=$APIHEY&adult=false&language=en-US&with_genres=$genreId"),
    );
    var movieResponse = Movies.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return movieResponse;
    } else {
      throw Exception('Failed to load album');
    }
  }
  Future<SearchModel> getSearch(String query)async{
    Uri URL=Uri.https(BASE,'/3/search/movie',{
      'api_key':APIHEY,
      'query':query,
    });
    Response search=await http.get(URL);
    try{
      var json=jsonDecode(search.body);
      SearchModel searchModel=SearchModel.fromJson(json);
      return searchModel;
    }
    catch(e){
      print(e);
      throw e;
    }
  }

  Future<NewReleases> getNewRelases( ) async {
    Uri URL = Uri.https(BASE, '/3/movie/upcoming', {
      'api_key': APIHEY,
      // 'imdb_id': imdb_id,
    });
    Response release = await http.get(URL);
    try {
      var json = jsonDecode(release.body);
      NewReleases newRelease = NewReleases.fromJson(json);
      return newRelease;
    } catch (e) {
      print('erorrrr:::$e');
      throw e;
    }
  }

  Future<TopSide> getTOPside( ) async {
    Uri URL = Uri.https(BASE, '/3/movie/popular', {
      'api_key':APIHEY,
      // 'imdb_id': imdb_id,
    });
    Response top = await http.get(URL);
    try {
      var json = jsonDecode(top.body);
      TopSide topSide = TopSide.fromJson(json);
      return topSide;
    } catch (e) {
      print('erorrrr:::$e');
      throw e;
    }
  }
  Future<MoreLikeThis> getMoreLikeThise(num movie_id)async{
    Uri URL=Uri.https(BASE,'/3/movie/${movie_id.toString()}/similar',{
      'api_key':APIHEY,
      // 'movie_id':Filme_ID,
    });
    Response more=await http.get(URL);
    try{
      var json=jsonDecode(more.body);
      MoreLikeThis moreLikeThis=MoreLikeThis.fromJson(json);
      return moreLikeThis;
    }
    catch(e){
      print(e);
      throw e;
    }

  }

  ////////////////////////////////////////////////////////////


  Future<TopReated> getTopReated() async {
    Uri URL = Uri.https(BASE, '/3/movie/top_rated', {
      'api_key': APIHEY,
      // 'imdb_id': imdb_id,
    });
    Response reated = await http.get(URL);
    try {
      var json = jsonDecode(reated.body);
      TopReated topReated = TopReated.fromJson(json);
      return topReated;
    } catch (e) {
      print('erorrrr:::$e');
      throw e;
    }
  }

  Future<VideoResults> getVideoTriler(num movie_id) async {
    Uri URL=Uri.https(BASE,'/3/movie/${movie_id.toString()}/videos', {
      'api_key': APIHEY,
    });
    Response video = await http.get(URL);
    try {
      var json = jsonDecode(video.body);
      VideoResults videoResults = VideoResults.fromJson(json);
      return videoResults;
    } catch (e) {
      print('erorrrr:::$e');
      throw e;
    }
  }
}
