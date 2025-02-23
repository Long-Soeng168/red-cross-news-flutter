import 'dart:convert';
import 'package:red_cross_news_app/config/env.dart';
import 'package:red_cross_news_app/models/brand.dart';
import 'package:http/http.dart' as http;

class BrandService {
  static Future<List<Brand>> fetchBrands() async {
    const url = '${Env.baseApiUrl}brands?';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Brand> categories = data.map((item) {
        return Brand(
          id: item['id'],
          name: item['name'] ?? '',
          nameKh: item['name_kh'] ?? '',
          imageUrl: '${Env.baseImageUrl}brands/${item['image']}',
        );
      }).toList();

      return categories;
    } else {
      throw Exception('Failed to load Brands');
    }
  }
}
