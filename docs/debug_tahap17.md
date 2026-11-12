# Tahap 17 – Debugging dan Security Check

## 1. Tujuan

Tahap ini bertujuan untuk mengevaluasi penanganan kesalahan pada aplikasi Course Explorer yang telah terintegrasi dengan Supabase. Pemeriksaan difokuskan pada proses pengambilan data, koneksi internet, pemetaan JSON, akses database, serta validasi data.

## 2. Mekanisme Penanganan Error

Berdasarkan implementasi aplikasi, terdapat beberapa mekanisme penanganan kesalahan:

1. **Loading State**  
   Aplikasi menampilkan CircularProgressIndicator ketika sedang mengambil data dari Supabase.

2. **Error State**  
   Apabila pengambilan data gagal, aplikasi menampilkan pesan Gagal Memuat Data beserta informasi kesalahan.

3. **Retry Mechanism**  
   Tombol Coba Lagi disediakan agar pengguna dapat mengulangi proses pengambilan data setelah terjadi kegagalan.

4. **Empty State**  
   Apabila database tidak memiliki data, aplikasi menampilkan informasi Belum Ada Materi.

5. **Exception Handling**  
   SupabaseCourseService menggunakan try-catch untuk menangkap kesalahan pada operasi SELECT, INSERT, UPDATE, dan DELETE.

## 3. Identifikasi Potensi Kesalahan

| Skenario | Potensi penyebab | Penanganan |
|---|---|---|
| Data gagal dimuat | Nama tabel atau konfigurasi backend tidak sesuai | Periksa konfigurasi dan nama tabel |
| Koneksi gagal | Internet terputus atau server tidak dapat diakses | Periksa koneksi dan gunakan tombol Coba Lagi |
| Kesalahan pemetaan JSON | Struktur atau tipe data tidak sesuai model Course | Periksa Course.fromJson |
| Akses database ditolak | Pengaturan Row Level Security atau policy tidak sesuai | Periksa konfigurasi RLS dan policy |
| Data duplikat | Kode mata kuliah sudah digunakan | Periksa validasi dan constraint database |
| Data tidak valid | Input tidak memenuhi ketentuan | Gunakan validasi form sebelum mengirim data |

## 4. Pemeriksaan Keamanan

Beberapa aspek keamanan yang perlu diperhatikan:

- Menggunakan publishable key untuk koneksi aplikasi Flutter.
- Tidak menempatkan service_role key atau secret key pada aplikasi klien.
- Mengaktifkan Row Level Security (RLS) pada tabel database.
- Mengatur policy sesuai kebutuhan akses pengguna.
- Memastikan input pengguna divalidasi sebelum dikirim ke database.

## 5. Kesimpulan

Implementasi aplikasi telah menyediakan mekanisme dasar penanganan kesalahan melalui loading state, error state, empty state, retry, dan exception handling pada layanan Supabase.

Pemisahan tanggung jawab antara model, data source, service, repository, provider, dan screen juga membantu proses identifikasi serta perbaikan kesalahan. Pemeriksaan koneksi, pemetaan data, kebijakan akses database, dan validasi input menjadi bagian penting untuk menjaga aplikasi tetap berjalan dengan baik.

Catatan: Skenario kesalahan dan keamanan dalam dokumen ini merupakan daftar pemeriksaan yang perlu diuji. Hasil pengujian aktual dicatat setelah masing-masing skenario dijalankan.