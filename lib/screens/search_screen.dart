import 'package:flutter/material.dart';
import '../api/service.dart';
import '../models/movies.dart';
import '../widgets/movie_titles.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Movie> searchResults = [];
  bool isLoading = false;

  void _searchMovies(String query) async {
    if (query.isEmpty) {
      setState(() {
        searchResults = [];
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final data = await ApiService.fetchMovies(query);
      setState(() {
        searchResults = data.map((json) => Movie.fromJson(json)).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movies'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: _searchMovies,
              decoration: const InputDecoration(
                hintText: 'Search for movies...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          isLoading
              ? const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final movie = searchResults[index];
                      return MovieTitle(
                        movie: movie,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/details',
                            arguments: movie,
                          );
                        },
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
