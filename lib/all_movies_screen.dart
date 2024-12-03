import 'package:flutter/material.dart';
import 'api_service.dart';
import 'movie_detail_screen.dart';

class AllMoviesScreen extends StatefulWidget {
  final String category;

  AllMoviesScreen({required this.category});

  @override
  _AllMoviesScreenState createState() => _AllMoviesScreenState();
}

class _AllMoviesScreenState extends State<AllMoviesScreen> {
  List<dynamic> movies = [];

  @override
  void initState() {
    super.initState();
    fetchMoviesByCategory(widget.category);
  }

  Future<void> fetchMoviesByCategory(String category) async {
    final result = await ApiService.fetchMovies(category);
    setState(() {
      movies = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background to black
      appBar: AppBar(
        title: Text(
          "Kategori: ${widget.category}",
          style: TextStyle(
              color: Colors.white), // Change app bar text color to white
        ),
        backgroundColor: const Color.fromARGB(
            255, 0, 0, 0), // Set header background color to green
      ),
      body: movies.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  leading: Image.network(movie['Poster']),
                  title: Text(
                    movie['Title'],
                    style: TextStyle(
                        color:
                            Colors.white), // Change title text color to white
                  ),
                  subtitle: Text(
                    "Tahun: ${movie['Year']}",
                    style: TextStyle(
                        color: Colors.grey[300]), // Subtitle in light gray
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
