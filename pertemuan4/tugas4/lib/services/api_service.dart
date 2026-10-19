import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post.dart';
import '../models/komentar.dart';

class ApiService {
  static const _base = 'https://jsonplaceholder.typicode.com';

  static Future<List<Post>> ambilPostingan() async {
    final uri = Uri.parse('$_base/posts');
    final response = await http.get(uri).timeout(const Duration(seconds: 10));
    if (response.statusCode != 200) {
      throw Exception('Gagal memuat postingan (kode ${response.statusCode})');
    }
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((e) => Post.fromJson(e as Map<String, dynamic>)).toList();
  }

  static Future<List<Komentar>> ambilKomentar(int postId) async {
    final uri = Uri.parse('$_base/posts/$postId/comments');
    final response = await http.get(uri).timeout(const Duration(seconds: 10));
    if (response.statusCode != 200) {
      throw Exception('Gagal memuat komentar (kode ${response.statusCode})');
    }
    final List<dynamic> data = jsonDecode(response.body);
    return data
        .map((e) => Komentar.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
