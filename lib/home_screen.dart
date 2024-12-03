import 'package:flutter/material.dart';
import 'all_movies_screen.dart';
import 'movie_detail_screen.dart';
import 'api_service.dart';
import 'search_results_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> popularMovies = [];
  List<dynamic> latestMovies = [];
  String query = ""; // Untuk menyimpan kata kunci pencarian
  final List<String> categories = [
    "Action",
    "Comedy",
    "Drama",
    "Horror",
    "Sci-Fi"
  ];

  @override
  void initState() {
    super.initState();
    fetchPopularMovies();
    fetchLatestMovies();
  }

  Future<void> fetchPopularMovies() async {
    final movies = await ApiService.fetchMovies("popular");

    // Log the first movie's data to check the structure
    print(movies[0]);

    setState(() {
      // Sort movies by their rating
      movies.sort((a, b) {
        final ratingA = double.tryParse(a['imdbRating'] ?? '0') ?? 0;
        final ratingB = double.tryParse(b['imdbRating'] ?? '0') ?? 0;
        return ratingB.compareTo(ratingA); // Sort in descending order
      });
      popularMovies = movies;
    });
  }

  Future<void> fetchLatestMovies() async {
    final movies = await ApiService.fetchMovies("2023");
    setState(() {
      latestMovies = movies;
    });
  }

  Future<void> fetchMoviesByQuery(String query) async {
    final movies = await ApiService.fetchMovies(query);
    setState(() {
      popularMovies = movies; // Update daftar dengan hasil pencarian
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Background hitam
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Add some space above the header
            const SizedBox(height: 20), // Add space here

            // Header Section
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: const BoxDecoration(
                color: Colors.black, // Header dengan warna hitam
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Welcome Text
                      const Text(
                        "Selamat Datang",
                        style: TextStyle(
                          color: Colors.white, // Teks putih
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Avatar
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                          'https://avatar.iran.liara.run/public/38', // Ganti dengan URL avatar
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Search Bar
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[800],
                      hintText: "Cari Film...",
                      hintStyle: const TextStyle(color: Colors.white),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: const Icon(Icons.search, color: Colors.white),
                    ),
                    onChanged: (value) {
                      query = value;
                    },
                    onSubmitted: (value) {
                      if (query.isNotEmpty) {
                        // Arahkan ke halaman pencarian
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SearchResultsScreen(query: query),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Categories
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Kategori",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Teks putih
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AllMoviesScreen(
                                    category: categories[index]),
                              ),
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: Colors.grey[
                                  800], // Warna latar belakang kategori gelap
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                categories[index],
                                style: const TextStyle(
                                  color: Colors.white, // Teks kategori putih
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Popular Movies
                  const Text(
                    "Popular Movies",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Teks putih
                    ),
                  ),
                  const SizedBox(height: 10),
                  popularMovies.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: popularMovies.length,
                            itemBuilder: (context, index) {
                              final movie = popularMovies[index];
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetailScreen(
                                          id: movie['imdbID']),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 140,
                                  margin: const EdgeInsets.only(right: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          movie['Poster'],
                                          height: 150,
                                          width: 140,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        movie['Title'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white, // Teks putih
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        "Year: ${movie['Year']}",
                                        style: TextStyle(
                                            color: Colors.grey[
                                                600]), // Teks tahun abu-abu
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  const SizedBox(height: 20),

                  // Latest Movies
                  const Text(
                    "Latest Movies",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Teks putih
                    ),
                  ),
                  const SizedBox(height: 10),
                  latestMovies.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: latestMovies.length,
                          itemBuilder: (context, index) {
                            final movie = latestMovies[index];
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
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white), // Teks putih
                              ),
                              subtitle: Text(
                                "Year: ${movie['Year']}",
                                style: TextStyle(
                                    color:
                                        Colors.grey[600]), // Teks tahun abu-abu
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
