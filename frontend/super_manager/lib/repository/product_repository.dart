import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:super_manager/model/product.dart';
import 'package:super_manager/model/store_product.dart';

class ProductRepository {
  final String _baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:8080';
  bool get _useApi => dotenv.env['USE_API'] == 'true';
  //カテゴリIDで商品一覧
  //GET /product?category=val
  Future<List<Product>> fetchProducts(int categoryId) async {
    if (!_useApi) {
      await Future.delayed(const Duration(milliseconds: 300));
      return [
        Product(id: 1, name: 'とまと', categoryId: categoryId),
        Product(id: 2, name: 'パプリカ色素', categoryId: categoryId),
      ];
    }
    final res = await http.get(
      Uri.parse('$_baseUrl/products/?category=$categoryId/category'),
    );
    if (res.statusCode != 200) {
      throw Exception('エラー：${res.statusCode}');
    }
    final list = jsonDecode(utf8.decode(res.bodyBytes)) as List;
    return list
        .map((e) => Product.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  //商品登録
  Future<List<StoreProduct>> fetchStoreProducts(int productId) async {
    if (!_useApi) {
      await Future.delayed(const Duration(milliseconds: 300));
      return [
        StoreProduct(
          id: 1,
          storeName: 'とまと店',
          productName: 'トマト',
          location: '東京都',
          price: 1000,
          weight: 2000,
        ),
        StoreProduct(
          id: 2,
          storeName: 'パプリカ色素店',
          productName: 'パプリカ',
          location: '大阪府',
          price: 2000,
          weight: 2000,
        ),
      ];
    }
    final res = await http.get(
      Uri.parse('$_baseUrl/products?product=$productId/stores'),
    );
    if (res.statusCode != 200) {
      throw Exception('エラー：${res.statusCode}');
    }
    final list = jsonDecode(utf8.decode(res.bodyBytes)) as List;
    return list
        .map((e) => StoreProduct.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> createProduct(
    int categoryId,
    String productName,
    int price,
    int weight,
  ) async {
    if (_useApi) {
      return;
    }
    final res = await http.post(Uri.parse('$_baseUrl/products'));
    if (res.statusCode != 201) {
      throw Exception('エラー：${res.statusCode}');
    }
    return;
  }

  //Delete
  Future<void> deleteProduct(int id) async {
    if (_useApi) {
      return;
    }
    final res = await http.delete(Uri.parse('$_baseUrl/products/$id'));
    if (res.statusCode != 200 && res.statusCode != 204) {
      throw Exception('エラー：${res.statusCode}');
    }
    return;
  }

  //Update
  Future<void> updateProduct(Product product) async {
    if (_useApi) {
      return;
    }
    final res = await http.patch(
      Uri.parse('$_baseUrl/products'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product),
    );
    if (res.statusCode != 200 && res.statusCode != 204) {
      throw Exception('エラー：${res.statusCode}');
    }
    return;
  }
}
