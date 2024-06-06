import 'package:flutter/material.dart';
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
            return Card(
              child: ExpansionTile(
                title: Text(movie.title),
                subtitle: Text('Director: ${movie.director}'),
                leading: CircleAvatar(
                  child: Text(movie.title[0]),
                ),
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(left: 75),
                    child: Column(
                      children: [
                        RichText(
                            text: TextSpan(
                                style: DefaultTextStyle.of(context).style,
                                children: [
                              TextSpan(
                                text: 'Released: ',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              TextSpan(text: '${movie.released} \n'),
                              TextSpan(
                                  text: 'Plot: ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(fontWeight: FontWeight.bold)),
                              TextSpan(text: '${movie.plot}'),
                            ]))
                      ],
                    ),
                  ),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetails()));
                  }, child: Text("Read More"))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
