import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/models.dart';

class MoviesProvider extends ChangeNotifier{
  String _apiKey = '26760de1b0b375f8bb04b9e819d409f7';
  String _baseUrl = 'api.themoviedb.org';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];

  MoviesProvider() {
    print('MoviesProvider inicializado');

    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    var url = Uri.https( _baseUrl, '3/movie/now_playing', {
      'api_key': _apiKey,
      'language': _language,
      'page': '1'
    });

    var response = await http.get(url);

    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);

    this.onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }
}