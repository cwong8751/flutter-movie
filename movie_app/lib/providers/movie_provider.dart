import 'package:flutter/material.dart';

class MovieProvider extends ChangeNotifier{
  final _movieList = <String>[
    "The Shawshank Redemption",
    "The Godfather",
    "The Dark Knight",
    "The Godfather: Part II",
    "The Lord of the Rings: The Return of the King",
    "Pulp Fiction",
    "Schindler's List"
  ];

  List<String> get movieList => _movieList;

  List<String> loadMovies(){
    return _movieList;
  }

  
}