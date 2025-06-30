import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';

class FetchData {
  final String _baseUrl = "https://dummyjson.com";

  // Mengambil semua produk (bisa digunakan untuk fallback)
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse("$_baseUrl/products?limit=100"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['products'];
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Gagal memuat produk");
    }
  }

  // FUNGSI YANG DIPERBAIKI: Mengambil semua kategori produk
  // Sekarang mengembalikan List dari Map untuk menampung slug dan nama
  Future<List<Map<String, String>>> fetchCategories() async {
    final response = await http.get(Uri.parse("$_baseUrl/products/categories"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      // API mengembalikan List<Map<String, dynamic>>, kita konversi ke tipe yang lebih spesifik.
      return data.map((item) {
        return {
          'slug': item['slug'].toString(),
          'name': item['name'].toString(),
        };
      }).toList();
    } else {
      throw Exception("Gagal memuat kategori");
    }
  }

  // Mengambil produk berdasarkan kategori
  Future<List<Product>> fetchProductsByCategory(String category) async {
    final response = await http.get(Uri.parse("$_baseUrl/products/category/$category"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['products'];
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Gagal memuat produk dari kategori: $category");
    }
  }
  
  // Mencari produk
  Future<List<Product>> searchProducts(String query) async {
    final response = await http.get(Uri.parse("$_baseUrl/products/search?q=$query"));
     if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['products'];
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception("Gagal mencari produk: $query");
    }
  }
}