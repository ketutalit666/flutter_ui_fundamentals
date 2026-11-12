# Course Explorer

## Identitas Mahasiswa
- Nama: I Ketut Alit Junaedi Wardana
- NIM: [ISI NIM]

## Deskripsi Aplikasi

Course Explorer merupakan aplikasi berbasis Flutter untuk mengelola dan menampilkan data mata kuliah. Aplikasi ini menyediakan fitur melihat daftar mata kuliah, melihat detail, menambahkan data, mengedit, menghapus, dan menyimpan mata kuliah ke daftar favorit.

Aplikasi menggunakan desain responsif agar dapat digunakan pada berbagai ukuran layar.

## Fitur Utama

- Menampilkan daftar mata kuliah.
- Menambahkan mata kuliah.
- Mengedit data mata kuliah.
- Menghapus mata kuliah.
- Menambahkan dan menghapus favorit.
- Menampilkan detail mata kuliah.
- Menampilkan loading, error, dan empty state.
- Navigasi responsif menggunakan NavigationBar dan NavigationRail.

## Teknologi yang Digunakan

- Flutter dan Dart.
- Provider untuk state management.
- Supabase sebagai backend dan database.
- Git dan GitHub untuk version control.

## Cara Menjalankan Aplikasi

1. Pastikan Flutter SDK sudah terpasang.
2. Clone repository:

   `git clone https://github.com/ketutalit666/flutter_ui_fundamentals.git`

3. Masuk ke folder project:

   `cd flutter_ui_fundamentals`

4. Instal dependency:

   `flutter pub get`

5. Pastikan konfigurasi Supabase sudah tersedia.
6. Jalankan aplikasi:

   `flutter run -d chrome`

## Arsitektur Aplikasi

Aplikasi menggunakan pemisahan tanggung jawab agar kode lebih terstruktur.

- **Models:** mendefinisikan struktur data mata kuliah.
- **Services:** menangani komunikasi dengan backend Supabase.
- **Data Source:** mendefinisikan kontrak sumber data.
- **Repositories:** menjadi perantara antara data source dan Provider.
- **Providers:** mengelola state, data, loading, error, dan favorit.
- **Screens:** menampilkan halaman aplikasi.
- **Widgets:** menyediakan komponen antarmuka yang dapat digunakan kembali.

## Backend

Backend yang digunakan adalah Supabase dengan tabel `courses` untuk menyimpan data mata kuliah.

Operasi database yang digunakan meliputi:
- SELECT untuk mengambil data.
- INSERT untuk menambahkan data.
- UPDATE untuk memperbarui data.
- DELETE untuk menghapus data.

## Repository

GitHub:
https://github.com/ketutalit666/flutter_ui_fundamentals