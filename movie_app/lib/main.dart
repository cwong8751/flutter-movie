import 'package:flutter/material.dart';
import 'package:movie_app/components/movie_card.dart';
import 'package:movie_app/pages/movie_details.dart';
import 'package:movie_app/providers/movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/models/movie.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => MovieProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieProvider>(context, listen: false).loadMovies(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final movies = Provider.of<MovieProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: movies.movieList.length,
          itemBuilder: (context, index) {
            final movie = movies.movieList[index];
            return MovieCard(movie: movie);
          },
        ),
      ),
    );
  }
}