import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:super_manager/model/store.dart';
import 'package:super_manager/model/store_product.dart';

class StoreRepository {
  final String _baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:8080';
  bool get _useApi => dotenv.env['USE_API'] == 'true';

  //店舗一覧取得
  Future<List<Store>> fetchStores() async {
    if (!_useApi) {
      await Future.delayed(const Duration(milliseconds: 300));
      return [
        Store(
          id: 1,
          name: 'テスト',
          kanaName: 'てすと',
          location: '大阪市',
          description: '大阪の店',
          latitude: 111.11,
          longitude: 122.11,
          isCheap: true,
        ),
        Store(
          id: 2,
          name: 'テスト2',
          kanaName: 'てすとに',
          location: '大阪市',
          description: '大阪の店',
          latitude: 112.11,
          longitude: 122.11,
          isCheap: true,
        ),
      ];
    }
    final res = await http.get(Uri.parse('$_baseUrl/stores'));
    if (res.statusCode != 200) {
      throw Exception('エラー：${res.statusCode}');
    }
    final list = jsonDecode(utf8.decode(res.bodyBytes)) as List;
    return list.map((e) => Store.fromJson(e as Map<String, dynamic>)).toList();
  }

  //店舗情報作成
  Future<void> createStore(Store store) async {
    if (!_useApi) {
      return;
    }
    final res = await http.post(
      Uri.parse('$_baseUrl/stores'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(store),
    );
    if (res.statusCode != 201 && res.statusCode != 200) {
      throw Exception('エラー：${res.statusCode}');
    }
    return;
  }

  //店舗削除
  Future<void> deleteStore(int id) async {
    if (!_useApi) {
      return;
    }
    final res = await http.delete(Uri.parse('$_baseUrl/stores/$id'));
    if (res.statusCode != 200 && res.statusCode != 204) {
      throw Exception('エラー：${res.statusCode}');
    }
    return;
  }

  //店舗更新
  Future<void> updateStore(Store store) async {
    if (!_useApi) {
      return;
    }
    final res = await http.patch(
      Uri.parse('$_baseUrl/stores'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(store),
    );
    if (res.statusCode != 200 && res.statusCode != 204) {
      throw Exception('エラー：${res.statusCode}');
    }
    return;
  }
}
