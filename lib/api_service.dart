import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String apiKey = "9430f0f4"; // Ganti dengan API Key Anda
  static const String baseUrl = "http://www.omdbapi.com/";

  // Fungsi untuk mengambil daftar film berdasarkan query pencarian
  static Future<List<dynamic>> fetchMovies(String query) async {
    final url = "$baseUrl?s=$query&apikey=$apiKey";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Memeriksa apakah response 'Search' ada
        if (data['Search'] != null) {
          return data['Search']; // Mengembalikan daftar film yang ditemukan
        } else {
          return []; // Mengembalikan list kosong jika tidak ada film yang ditemukan
        }
      } else {
        throw Exception("Gagal mengambil daftar film: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Terjadi kesalahan saat memuat data: $e");
    }
  }

  // Fungsi untuk mengambil detail film berdasarkan ID
  static Future<Map<String, dynamic>> fetchMovieDetail(String id) async {
    final url = "$baseUrl?i=$id&apikey=$apiKey";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Memeriksa apakah response kosong atau ada error dalam data
        if (data['Response'] == 'True') {
          return data; // Mengembalikan data detail film
        } else {
          throw Exception("Film tidak ditemukan");
        }
      } else {
        throw Exception("Gagal mengambil detail film: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Terjadi kesalahan saat memuat detail film: $e");
    }
  }
}
