# 🛒 Flutter E-Commerce App

A simple e-commerce mobile application built with Flutter. It showcases product listing, detail view, cart management, and checkout functionality using Provider for state management.

## 🚀 Features

- User login interface
- Product listing from API
- Product detail view
- Add to cart
- Cart overview with total price
- Checkout button to clear cart
- State management with `Provider`
- Modular codebase
- Responsive UI

## 🛠️ Tech Stack

- **Flutter** (UI framework)
- **Dart** (language)
- **Provider** (state management)
- **HTTP** (REST API call)
- **JSON** (data interchange format)

## 📁 Project Structure

```
/lib
├── main.dart              # App entry point
├── api.dart               # API base configuration
├── login.dart             # Login screen
├── home.dart              # Homepage with product grid
├── detail_page.dart       # Product detail page
├── cart_page.dart         # Cart screen
├── cart_item.dart         # Widget for single cart item
├── cart_provider.dart     # State management for cart
├── product_model.dart     # Data model for product
├── fetch_data.dart        # Fetch products from API
```

### 🔍 File-by-File Overview

- **main.dart**: Initializes app and sets up the root widget tree with `MultiProvider` for state.
- **api.dart**: Stores the base URL for backend API calls.
- **login.dart**: Simple login UI for navigating to the home page.
- **home.dart**: Displays list of products in a responsive grid layout using `FutureBuilder`.
- **detail_page.dart**: Provides detailed product information and add-to-cart functionality.
- **cart_provider.dart**: Manages cart state including add/remove/clear logic using `ChangeNotifier`.
- **cart_page.dart**: Shows all cart items, with total price and a checkout button.
- **cart_item.dart**: Custom widget for visualizing a product in the cart with a remove option.
- **product_model.dart**: Dart model representing a product fetched from the API.
- **fetch_data.dart**: Contains logic to fetch products from REST API using `http.get`.

## 📦 Installation

1. **Clone the repository**

```bash
git clone https://github.com/yourusername/flutter-ecommerce.git
cd flutter-ecommerce
```

2. **Install dependencies**

```bash
flutter pub get
```

3. **Run the app**

```bash
flutter run
```

## 🔌 API Configuration

Set your API endpoint in `api.dart`:

```dart
const String baseUrl = "https://yourapi.com/products";
```

Ensure your API returns JSON structured like:

```json
[
  {
    "id": 1,
    "name": "Product Name",
    "price": 10000,
    "image_url": "https://..."
  },
  ...
]
```

## 📱 UI Preview (Optional)

Add screenshots or screen recordings here:
- Home page
- Product detail
- Cart page

## 🧪 Testing Suggestions

- Test adding/removing items from the cart
- Validate total price updates correctly
- Test UI responsiveness on different screen sizes
- Simulate API delays and test loading/error states

## 🧠 Future Enhancements

- Firebase authentication
- Local storage with Hive or shared_preferences
- Payment gateway integration (Midtrans, Xendit, etc)
- Order history persistence via backend
- Pagination and search on product list

## 📄 License

MIT License © 2025 NOORO

---

Made with ❤️ in Flutter.

