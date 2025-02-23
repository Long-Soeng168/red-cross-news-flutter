import 'dart:convert';

import 'package:red_cross_news_app/config/env.dart';
import 'package:red_cross_news_app/models/shop.dart';
import 'package:red_cross_news_app/pages/shops/shop_admin/admin_shop_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class ShopService {
  static Future<List<Shop>> fetchShops({int? page}) async {
    String url = '${Env.baseApiUrl}shops';

    List<String> queryParams = [];

    if (page != null) {
      queryParams.add('page=$page');
    }

    if (queryParams.isNotEmpty) {
      url += '?${queryParams.join('&')}';
    }

    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      Map<String, dynamic> result = jsonDecode(response.body);
      List<dynamic> data = result['data'];
      return data.map((item) {
        return Shop(
          id: item['id'],
          name: item['name'] ?? '',
          description: item['description'] ?? '',
          address: item['address'] ?? '',
          phone: item['phone'] ?? '',
          logoUrl: '${Env.baseImageUrl}shops/logo/thumb/${item['logo']}',
          bannerUrl: '${Env.baseImageUrl}shops/banner/thumb/${item['banner']}',
        );
      }).toList();
    } else {
      throw Exception('Failed to load Shops');
    }
  }

  static Future<Shop> fetchShopById({required int id}) async {
    String url = '${Env.baseApiUrl}shops/$id';
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    final Map<String, dynamic> data = jsonDecode(response.body);

    return Shop(
      id: data['id'],
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      address: data['address'] ?? '',
      phone: data['phone'] ?? '',
      logoUrl: '${Env.baseImageUrl}shops/logo/thumb/${data['logo']}',
      bannerUrl: '${Env.baseImageUrl}shops/banner/thumb/${data['banner']}',
    );
  }

  final String _baseUrl = Env.baseApiUrl;
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<Map<String, dynamic>> createShop({
    context,
    required String name,
    required String description,
    required String address,
    required String phone,
    required XFile logoImage,
    required XFile bannerImage,
  }) async {
    final token = await _storage.read(key: 'auth_token');

    try {
      var uri = Uri.parse('${_baseUrl}shops'); // API URL for creating a shop
      var request = http.MultipartRequest('POST', uri);

      // Add the fields
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      });
      request.fields['name'] = name;
      request.fields['description'] = description;
      request.fields['address'] = address;
      request.fields['phone'] = phone;

      // Add the logo image
      request.files.add(await http.MultipartFile.fromPath(
        'logo',
        logoImage.path,
        contentType: MediaType('image', 'jpeg'),
      ));

      // Add the banner image
      request.files.add(await http.MultipartFile.fromPath(
        'banner',
        bannerImage.path,
        contentType: MediaType('image', 'jpeg'),
      ));

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final data = jsonDecode(responseData);
        final createdShop = data['shop'];
        final newShop = Shop(
          id: createdShop['id'],
          name: createdShop['name'] ?? '',
          description: createdShop['description'] ?? '',
          address: createdShop['address'] ?? '',
          phone: createdShop['phone'] ?? '',
          logoUrl: '${Env.baseImageUrl}shops/logo/thumb/${createdShop['logo']}',
          bannerUrl:
              '${Env.baseImageUrl}shops/banner/thumb/${createdShop['banner']}',
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AdminShopPage(
                    shop: newShop,
                  )),
        );
        return {'success': true, 'message': responseData};
      } else {
        final responseData = await response.stream.bytesToString();
        return {
          'success': false,
          'message': 'Failed to create shop: $responseData'
        };
      }
    } catch (e) {
      print(e);
      return {'success': false, 'message': 'Fail to Create Shop'};
    }
  }

  Future<Map<String, dynamic>> updateShop({
    context,
    shop,
    required String name,
    required String description,
    required String address,
    required String phone,
    required XFile? logoImage,
    required XFile? bannerImage,
  }) async {
    final token = await _storage.read(key: 'auth_token');

    try {
      var uri = Uri.parse(
          '${_baseUrl}shops/${shop.id}'); // API URL for creating a shop
      var request = http.MultipartRequest('POST', uri);

      // Add the fields
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
        'Authorization': 'Bearer $token',
      });
      request.fields['name'] = name;
      request.fields['description'] = description;
      request.fields['address'] = address;
      request.fields['phone'] = phone;

      // Add the logo image
      if (logoImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'logo',
          logoImage.path,
          contentType: MediaType('image', 'jpeg'),
        ));
      }

      // Add the banner image
      if (bannerImage != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'banner',
          bannerImage.path,
          contentType: MediaType('image', 'jpeg'),
        ));
      }

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final data = jsonDecode(responseData);
        final updatedShop = data['shop'];
        final newShop = Shop(
          id: updatedShop['id'],
          name: updatedShop['name'] ?? '',
          description: updatedShop['description'] ?? '',
          address: updatedShop['address'] ?? '',
          phone: updatedShop['phone'] ?? '',
          logoUrl: '${Env.baseImageUrl}shops/logo/thumb/${updatedShop['logo']}',
          bannerUrl:
              '${Env.baseImageUrl}shops/banner/thumb/${updatedShop['banner']}',
        );
        Navigator.pop(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AdminShopPage(
                    shop: newShop,
                  )),
        );

        return {'success': true, 'message': responseData};
      } else {
        final responseData = await response.stream.bytesToString();
        return {
          'success': false,
          'message': 'Failed to Update shop: $responseData'
        };
      }
    } catch (e) {
      print(e);
      return {'success': false, 'message': 'Fail to Update Shop'};
    }
  }
}
