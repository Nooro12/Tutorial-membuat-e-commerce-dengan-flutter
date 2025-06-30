class Product {
  final int id;
  final String title;
  final String description;
  final String thumbnail;
  final double price;
  final double discountPercentage; // Ditambahkan
  final double rating;             // Ditambahkan
  final String category;           // Ditambahkan

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.price,
    required this.discountPercentage,
    required this.rating,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      // API mengembalikan price sebagai integer atau double, jadi kita handle keduanya.
      price: (json['price'] as num).toDouble(),
      discountPercentage: (json['discountPercentage'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      category: json['category'],
    );
  }
}
