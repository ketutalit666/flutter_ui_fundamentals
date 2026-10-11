# Catatan Debugging Provider dan State

1. **notifyListeners():** Dibutuhkan agar widget yang mendengarkan perubahan state diperbarui.
2. **Provider:** ChangeNotifierProvider harus membungkus widget yang membutuhkan akses ke provider.
3. **Error JSON:** Kesalahan pemuatan aset perlu ditangani agar aplikasi dapat menampilkan pesan error.
4. **Async dan mounted:** Pada StatefulWidget, pemeriksaan `mounted` diperlukan sebelum memanggil `setState()` setelah operasi asynchronous jika widget mungkin sudah tidak aktif.