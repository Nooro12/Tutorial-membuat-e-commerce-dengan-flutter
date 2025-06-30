import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:api/provider/cart_provider.dart'; // Sesuaikan path jika berbeda
import 'package:api/data/fetch_data.dart'; // Sesuaikan path jika berbeda
import 'package:api/models/product_model.dart'; // Sesuaikan path jika berbeda
import 'package:api/pages/detail_page.dart'; // Sesuaikan path jika berbeda
import 'package:api/pages/cart_page.dart'; // Sesuaikan path jika berbeda

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // State untuk menyimpan data yang akan ditampilkan
  late Future<List<Product>> _productsFuture;
  late Future<List<Map<String, String>>> _categoriesFuture;
  final FetchData _fetchData = FetchData();
  String _selectedCategorySlug = 'all'; // Menyimpan slug kategori yang dipilih

  @override
  void initState() {
    super.initState();
    // Memuat data saat halaman pertama kali dibuka
    _productsFuture = _fetchData.fetchProducts();
    _categoriesFuture = _fetchData.fetchCategories();
  }

  // Fungsi untuk memuat ulang data, baik untuk filter maupun search
  void _loadProducts({String? category, String? query}) {
    setState(() {
      if (query != null && query.isNotEmpty) {
        _productsFuture = _fetchData.searchProducts(query);
      } else if (category != null && category != 'all') {
        _productsFuture = _fetchData.fetchProductsByCategory(category);
        _selectedCategorySlug = category;
      } else {
        _productsFuture = _fetchData.fetchProducts();
        _selectedCategorySlug = 'all';
      }
    });
  }

  // Fungsi untuk pull-to-refresh
  Future<void> _refresh() async {
    setState(() {
      _productsFuture = _fetchData.fetchProducts();
      _selectedCategorySlug = 'all';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Toko Iqbal"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Consumer<CartProvider>(
              builder: (_, cart, ch) => Badge(
                label: Text(cart.itemCount.toString()),
                isLabelVisible: cart.itemCount > 0,
                child: ch,
              ),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart_outlined),
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage())),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Column(
          children: [
            // --- WIDGET PENCARIAN ---
            _buildSearchBar(),
            // --- WIDGET KATEGORI ---
            _buildCategoryList(),
            const SizedBox(height: 8),
            // --- WIDGET GRID PRODUK ---
            Expanded(
              child: FutureBuilder<List<Product>>(
                future: _productsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text("Gagal memuat data: ${snapshot.error}"));
                  }
                  if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                    final products = snapshot.data!;
                    return GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.65, // Rasio disesuaikan
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: products[index]);
                      },
                    );
                  }
                  return const Center(child: Text("Produk tidak ditemukan."));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan search bar
  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        onSubmitted: (value) => _loadProducts(query: value),
        decoration: InputDecoration(
          hintText: 'Cari produk...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
      ),
    );
  }

  // Widget untuk menampilkan daftar kategori secara horizontal
  Widget _buildCategoryList() {
    return FutureBuilder<List<Map<String, String>>>(
      future: _categoriesFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(height: 50); // Placeholder saat loading
        }
        final categories = [{'slug': 'all', 'name': 'All'}, ...snapshot.data!];
        return SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              final categorySlug = category['slug']!;
              final categoryName = category['name']!;
              
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: ChoiceChip(
                  label: Text(
                    categoryName, // Menampilkan nama yang ramah pengguna
                    style: TextStyle(color: _selectedCategorySlug == categorySlug ? Colors.white : Colors.black87),
                  ),
                  selected: _selectedCategorySlug == categorySlug,
                  onSelected: (selected) {
                    if (selected) {
                      _loadProducts(category: categorySlug); // Menggunakan slug untuk filter
                    }
                  },
                  backgroundColor: Colors.grey[200],
                  selectedColor: Theme.of(context).primaryColor,
                  showCheckmark: false,
                ),
              );
            },
          ),
        );
      },
    );
  }
}


// --- WIDGET KARTU PRODUK YANG DIPERBARUI ---
class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    // Menghitung harga setelah diskon
    final discountedPrice = product.price * (1 - product.discountPercentage / 100);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailPage(product: product)),
        );
      },
      child: Card(
        elevation: 3,
        shadowColor: Colors.black.withOpacity(0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar produk dengan label diskon
            Stack(
              children: [
                Hero(
                  tag: 'product-image-${product.id}', // Tag unik untuk animasi
                  child: AspectRatio(
                    aspectRatio: 1, // membuat gambar menjadi persegi
                    child: Image.network(
                      product.thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (c, o, s) => const Icon(Icons.error),
                    ),
                  ),
                ),
                if (product.discountPercentage > 0)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.redAccent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${product.discountPercentage.toStringAsFixed(0)}% OFF',
                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
            // Detail produk
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      product.title,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // Widget untuk menampilkan rating bintang
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          product.rating.toString(),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    // Harga
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (product.discountPercentage > 0)
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.grey,
                                ),
                          ),
                        Text(
                          '\$${discountedPrice.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
