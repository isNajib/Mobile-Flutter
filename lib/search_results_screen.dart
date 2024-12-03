// search_results_screen.dart
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'movie_detail_screen.dart';

class SearchResultsScreen extends StatefulWidget {
  final String query;

  SearchResultsScreen({required this.query});

  @override
  _SearchResultsScreenState createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  List<dynamic> searchResults = [];

  @override
  void initState() {
    super.initState();
    fetchSearchResults(widget.query);
  }

  Future<void> fetchSearchResults(String query) async {
    final movies = await ApiService.fetchMovies(query);
    setState(() {
      searchResults = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to black
      appBar: AppBar(
        title: Text('Search Results for "${widget.query}"'),
        backgroundColor: Colors.black, // Keep appBar background black
        foregroundColor: Colors.white, // Set the appBar text color to white
      ),
      body: searchResults.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                final movie = searchResults[index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      movie['Poster'],
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    movie['Title'],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  subtitle: Text(
                    "Year: ${movie['Year']}",
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MovieDetailScreen(id: movie['imdbID']),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
