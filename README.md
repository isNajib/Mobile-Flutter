# CineWorld Using Flutter

  CineWorld adalah aplikasi penemuan film yang sederhana dan mudah digunakan, memungkinkan pengguna untuk menjelajahi berbagai jenis film, mulai dari blockbuster terbaru hingga film-film tersembunyi. Aplikasi ini menawarkan pengalaman yang dipersonalisasi dengan data film terkini, termasuk rating, tahun rilis, dan poster, sehingga memudahkan pengguna untuk menemukan film favorit berikutnya. Baik Anda mencari berdasarkan kategori, menemukan film populer, atau mempelajari informasi detail tentang film, CineWorld menyediakan platform yang imersif untuk para pecinta film.

![image](https://github.com/user-attachments/assets/35b93abe-a2ba-4c9d-bcaa-82f1e07fbd47)

# all_movies_screen.dart
File ini berisi tampilan untuk menampilkan daftar film berdasarkan kategori tertentu, seperti aksi, komedi, drama, dan lainnya. Pengguna dapat melihat film-film dalam kategori yang dipilih, dan setiap film dapat dipilih untuk melihat detail lebih lanjut.

![image](https://github.com/user-attachments/assets/b796a065-d218-4223-92dc-7de768bd7561)


# api_service.dart
File ini bertanggung jawab untuk berkomunikasi dengan API untuk mengambil data film. Biasanya berisi fungsi untuk mendapatkan daftar film berdasarkan kategori atau pencarian pengguna, seperti fetchMovies() yang digunakan di banyak layar lainnya.

# home_screen.dart
Ini adalah tampilan utama aplikasi. Pengguna dapat melihat berbagai film populer, film terbaru, dan melakukan pencarian berdasarkan kategori. Halaman ini memberikan antarmuka yang ramah pengguna untuk menjelajahi aplikasi, termasuk fitur pencarian, kategori, dan film unggulan.

![image](https://github.com/user-attachments/assets/859b2bc6-d7bd-4f3f-937b-a6f364ee1e99)


# main.dart
File utama yang menginisialisasi dan menjalankan aplikasi. Biasanya berisi kode untuk menjalankan aplikasi dan menyiapkan rute navigasi antar layar. Di sini, Anda mengonfigurasi halaman awal dan pengaturan aplikasi.

# movie_detail_screen.dart
File ini digunakan untuk menampilkan detail dari sebuah film, seperti judul, deskripsi, rating, dan informasi lainnya. Halaman ini muncul ketika pengguna memilih film tertentu untuk melihat lebih lanjut.

![image](https://github.com/user-attachments/assets/1d221c25-2dae-4e62-a0e9-c7621165df97)


# search_results_screen.dart
File ini menampilkan hasil pencarian film berdasarkan kata kunci yang dimasukkan pengguna. Ini memungkinkan pengguna untuk mencari film tertentu dan melihat detailnya.

![image](https://github.com/user-attachments/assets/1e4a3fb4-b02a-48e8-bdc5-35472d72da53)

# 

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
