# Course Explorer v2

Aplikasi Flutter untuk menampilkan materi pembelajaran dengan Provider dan arsitektur yang terstruktur.

## Identitas Mahasiswa

- Nama: I Ketut Alit Junaedi Wardana
- NIM: 2415051050

## Struktur dan Tanggung Jawab Folder

- **models/**: Mendefinisikan struktur data, seperti `Course`, serta parsing JSON.
- **services/**: Mengambil dan membaca data dari sumber data, termasuk file JSON.
- **repositories/**: Menjadi perantara antara Provider dan Service untuk mengakses data.
- **providers/**: Mengelola state aplikasi, seperti daftar course, loading, error, dan favorite.
- **screens/**: Menyusun halaman aplikasi, seperti Home, Courses, Favorites, Detail, dan Feedback.
- **widgets/**: Menyediakan komponen UI yang dapat digunakan kembali.
- **main.dart**: Menyiapkan aplikasi, dependency, Provider, dan konfigurasi tema.
- **student_info.dart**: Menyimpan konstanta identitas mahasiswa.

## Arah Dependency

Alur pengambilan data mengikuti:

Screens/Widgets → Provider → Repository → Service/Data Source.

UI tidak membaca JSON secara langsung. Provider menerima Repository sebagai dependency, sedangkan Repository menggunakan Service untuk mendapatkan data.

## State Management

Provider mengelola state daftar course dan favorite. Perubahan state diberitahukan melalui `notifyListeners()`, sehingga widget yang mendengarkan perubahan dapat diperbarui.

## Penanganan Data

Course dimuat secara asynchronous dari file JSON. Aplikasi menangani kondisi loading, error, dan data berhasil dimuat.

## Pertemuan 7 - REST API

### Informasi REST API

- **Base URL:** https://course-api-pearl.vercel.app
- **Endpoint:** /courses
- **HTTP Method:** GET
- **Resource:** Courses
- **Status Code:** 200 OK
- **Fungsi:** Mengambil seluruh data mata kuliah dari server.

### Struktur JSON Course

| Field | Tipe Data | Keterangan |
|---|---|---|
| id | Integer | ID unik mata kuliah |
| code | String | Kode mata kuliah |
| title | String | Nama mata kuliah |
| credits | Integer | Jumlah SKS |
| status | String | Status mata kuliah |

### Tujuan Pengujian

Pengujian dilakukan menggunakan Google Chrome untuk mengakses REST API. Request GET digunakan untuk mengambil data mata kuliah dari server. Respons yang diterima berbentuk JSON dan akan digunakan sebagai dasar pembuatan model Dart pada tahap selanjutnya.