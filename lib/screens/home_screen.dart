import 'package:flutter/material.dart';
import '../api/service.dart';
import '../models/movies.dart';
import '../widgets/movie_titles.dart';
import 'search_screen.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    _loadMovies();
  }

  void _loadMovies() async {
    final data = await ApiService.fetchMovies('all');
    setState(() {
      movies = data.map((json) => Movie.fromJson(json)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return MovieTitle(movie: movies[index], onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute( builder: (context) => DetailsScreen(movies[index], movie: movies[index])),
            );
          });
        },
      ),
    );
  }
}
