import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Impor google_fonts
import 'package:provider/provider.dart';
import 'provider/cart_provider.dart'; // Impor CartProvider
import 'screens/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisikan tema utama untuk aplikasi
    final ThemeData theme = ThemeData(
      primarySwatch: Colors.indigo, // Warna dasar yang lebih elegan
      scaffoldBackgroundColor: Colors.grey[50],
      textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: const Color.fromARGB(255, 55, 163, 127),
        foregroundColor: Colors.white,
        elevation: 0.5,
        titleTextStyle: GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.w600),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 63, 181, 69),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        ),
      ),
    );

    return ChangeNotifierProvider(
      create: (ctx) => CartProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme, // Terapkan tema
        home: const LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}