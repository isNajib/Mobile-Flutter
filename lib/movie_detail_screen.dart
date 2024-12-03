import 'package:flutter/material.dart';
import 'api_service.dart';

class MovieDetailScreen extends StatefulWidget {
  final String id;

  MovieDetailScreen({required this.id});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  Map<String, dynamic>? movieDetail;

  @override
  void initState() {
    super.initState();
    fetchMovieDetail(widget.id);
  }

  Future<void> fetchMovieDetail(String id) async {
    final result = await ApiService.fetchMovieDetail(id);
    setState(() {
      movieDetail = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          movieDetail?['Title'] ?? "Loading...",
          style: TextStyle(
              color: Colors.white), // Mengubah warna teks menjadi putih
        ),
        backgroundColor:
            const Color.fromARGB(255, 0, 0, 0), // Warna latar belakang hitam
        foregroundColor:
            Colors.white, // Mengatur warna ikon dan teks menjadi putih
      ),
      body: movieDetail == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Movie poster
                    Center(
                      child: Image.network(movieDetail!['Poster']),
                    ),
                    const SizedBox(height: 16.0),

                    // Title and year
                    Text(
                      movieDetail!['Title'],
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "(${movieDetail!['Year']})",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8.0),

                    // Genre and Metascore
                    Row(
                      children: [
                        Chip(
                          label: Text(
                            movieDetail!['Genre'] ?? 'Unknown',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.blue,
                        ),
                        const SizedBox(width: 10),
                        Chip(
                          label: Text(
                            'Metascore: ${movieDetail!['Metascore'] ?? 'N/A'}',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.green,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),

                    // Rating section
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.yellow),
                        const SizedBox(width: 8),
                        Text(
                          movieDetail!['imdbRating'] != null
                              ? '${movieDetail!['imdbRating']} / 10'
                              : 'N/A',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),

                    // Plot section
                    Text(
                      "Sinopsis:",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      movieDetail!['Plot'] ?? 'No plot available.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Director section
                    Text(
                      "Sutradara: ${movieDetail!['Director'] ?? 'Unknown'}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8.0),

                    // Writer section
                    Text(
                      "Penulis: ${movieDetail!['Writer'] ?? 'Unknown'}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8.0),

                    // Language and country section
                    Text(
                      "Bahasa: ${movieDetail!['Language'] ?? 'Unknown'}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "Negara: ${movieDetail!['Country'] ?? 'Unknown'}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
      backgroundColor: Colors.black,
    );
  }
}
