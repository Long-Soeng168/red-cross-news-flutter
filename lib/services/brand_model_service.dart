import 'dart:convert';
import 'package:red_cross_news_app/config/env.dart';
import 'package:red_cross_news_app/models/brand_model.dart';
import 'package:http/http.dart' as http;

class BrandModelService {
  static Future<List<BrandModel>> fetchBrandModels({int? brandId}) async {
    String url = '${Env.baseApiUrl}models';

    List<String> queryParams = [];
    if (brandId != null) {
      queryParams.add('brandId=$brandId');
    }
    if (queryParams.isNotEmpty) {
      url += '?${queryParams.join('&')}';
    }
    print(url);

    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<BrandModel> brandModels = data.map((item) {
        return BrandModel(
          id: item['id'],
          brandId: item['brand_id'],
          name: item['name'] ?? '',
          nameKh: item['name_kh'] ?? '',
          imageUrl: '${Env.baseImageUrl}models/${item['image']}',
        );
      }).toList();

      return brandModels;
    } else {
      throw Exception('Failed to load Brands');
    }
  }
}
