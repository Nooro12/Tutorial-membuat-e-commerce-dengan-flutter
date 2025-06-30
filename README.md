Proyek E-commerce Flutter
Sebuah aplikasi e-commerce seluler prototipe yang dibangun dengan Flutter. Aplikasi ini memungkinkan pengguna untuk menjelajahi produk, memfilternya, mencari, dan mengelola keranjang belanja setelah melakukan login.

📝 Deskripsi
Aplikasi ini adalah contoh implementasi aplikasi e-commerce sederhana yang mengambil data dari API publik dummyjson.com. Ini mencakup alur dasar mulai dari autentikasi pengguna hingga penambahan produk ke keranjang belanja. Proyek ini bertujuan untuk mendemonstrasikan penggunaan Flutter dalam membangun aplikasi yang dinamis dan terhubung dengan API.

✨ Fitur
Autentikasi Pengguna: Halaman login untuk verifikasi pengguna.

Galeri Produk: Menampilkan produk dalam format grid yang responsif.

Pencarian Produk: Fungsi untuk mencari produk berdasarkan nama.

Filter Kategori: Pengguna dapat memfilter produk berdasarkan kategori yang tersedia.

Detail Produk: Halaman khusus untuk menampilkan informasi lengkap setiap produk dengan animasi transisi gambar.

Manajemen Keranjang: Menambah, melihat, dan menghapus item dari keranjang belanja.

State Management: Menggunakan Provider untuk manajemen state keranjang yang efisien.

Tarik untuk Segarkan: Kemampuan untuk menyegarkan data produk dengan menarik layar ke bawah.

🛠️ Teknologi & Paket yang Digunakan
Framework: Flutter

Bahasa: Dart

Manajemen State: provider

Permintaan HTTP: http

Font Kustom: google_fonts

API: DummyJSON untuk data produk dan autentikasi.

📂 Struktur Proyek
Struktur folder diatur untuk memisahkan antara logika, tampilan (UI), model data, dan layanan jaringan.

lib/
├── data/
│   └── fetch_data.dart       # Logika untuk mengambil data produk & kategori dari API
├── main.dart                 # Titik masuk utama aplikasi & konfigurasi tema
├── models/
│   ├── cart_item.dart        # Model untuk item di dalam keranjang
│   └── product_model.dart    # Model untuk data produk
├── network/
│   └── api.dart              # Logika untuk autentikasi login
├── pages/
│   ├── cart_page.dart        # UI untuk halaman keranjang belanja
│   ├── detail_page.dart      # UI untuk halaman detail produk
│   ├── home.dart             # UI untuk halaman utama (daftar produk)
│   └── login.dart            # UI untuk halaman login
└── provider/
    └── cart_provider.dart    # State management untuk keranjang belanja

🚀 Memulai Proyek
Ikuti langkah-langkah berikut untuk menjalankan proyek ini di lingkungan lokal Anda.

Prasyarat
Pastikan Anda telah menginstal:

Flutter SDK (versi 3.x.x atau lebih baru)

Android Studio / VS Code (dengan ekstensi Flutter & Dart)

Emulator Android / iOS Simulator atau perangkat fisik

Instalasi & Menjalankan
Clone repository ini:

git clone https://github.com/nama-user-anda/nama-repo-anda.git

Pindah ke direktori proyek:

cd nama-repo-anda

Install semua dependensi:

flutter pub get

Jalankan aplikasi:

flutter run

Penggunaan
Aplikasi akan dimulai pada halaman Login.

Gunakan kredensial dari DummyJSON Users untuk masuk. Contoh:

Username: emilys

Password: emilyspass

Setelah berhasil login, Anda akan diarahkan ke halaman Home di mana Anda dapat mulai menjelajahi produk.

🔮 Potensi Pengembangan
Proyek ini memiliki banyak ruang untuk pengembangan lebih lanjut, antara lain:

Alur Checkout: Mengimplementasikan proses checkout, termasuk pemilihan alamat dan integrasi pembayaran.

Penyimpanan Lokal: Menyimpan token sesi dan data keranjang secara persisten menggunakan shared_preferences atau database lokal.

Fitur Pengguna: Menambahkan halaman profil pengguna, riwayat pesanan, dan fitur registrasi.

Peningkatan UI/UX: Menambahkan shimmer effect saat loading, animasi yang lebih kaya, dan tema gelap/terang.
