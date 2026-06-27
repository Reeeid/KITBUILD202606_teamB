import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:super_manager/model/store.dart';

class StoreRepository {
  final String _baseUrl = dotenv.env['API_BASE_URL'] ?? 'http://localhost:8080';
  bool get _useApi => dotenv.env['USE_API'] == 'true';

  Future<List<Store>> fetchStores() async {
    if (!_useApi) {
      await Future.delayed(const Duration(milliseconds: 300));
      return [];
    }
    final res = await http.get(Uri.parse('$_baseUrl/stores'));
    if (res.statusCode != 200) {
      throw Exception('エラー：${res.statusCode}');
    }
    final list = jsonDecode(utf8.decode(res.bodyBytes)) as List;
    return list.map((e) => Store.fromJson(e as Map<String, dynamic>)).toList();
  }
  Future<void> createStore(Store store) async
}
