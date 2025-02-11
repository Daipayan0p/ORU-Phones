import 'package:dio/dio.dart';
import 'package:oru_phones/src/model/Listing.dart';
import 'package:oru_phones/src/model/SearchFilters.dart';

class Api {
  static const String baseUrl = "http://40.90.224.241:5000";
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  static Future<List<Listing>> fetchListings() async {
    try {
      final response = await _dio.post('/filter', data: {"filter": {}});

      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data['data']; // This is a map
        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data')) {
          final listings = responseData['data']; // Extract the actual list
          // print(listings);
          if (listings is List) {
            return listings.map((json) => Listing.fromJson(json)).toList();
          } else {
            throw Exception("Listings data is not a list");
          }
        } else {
          throw Exception("Unexpected response format: Missing 'data' key");
        }
      } else {
        throw Exception("Failed to load listings: ${response.statusCode}");
      }
    } on DioException catch (e) {
      print('Dio error: ${e.response?.statusCode} - ${e.message}');
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  static Future<SearchFilters> showSearchFilters() async {
    try {
      final response = await _dio.get('/showSearchFilters');

      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data['dataObject'];
        return SearchFilters.fromJson(responseData);
      } else {
        throw Exception(
            "Failed to load search filters: ${response.statusCode}");
      }
    } on DioException catch (e) {
      print('Dio error: ${e.response?.statusCode} - ${e.message}');
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  static Future<List<dynamic>> getFaq() async {
    try {
      final response = await _dio.get('/faq');

      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data['FAQs'];
        return responseData;
      } else {
        throw Exception(
            "Failed to load search filters: ${response.statusCode}");
      }
    } on DioException catch (e) {
      print('Dio error: ${e.response?.statusCode} - ${e.message}');
      rethrow;
    } catch (e) {
      print('Unexpected error: $e');
      rethrow;
    }
  }

  static createOtp(int number) async {
    try {
      final response = await _dio.post('$baseUrl/login/otpCreate',
          data: {"countryCode": 91, "mobileNumber": number});

      if (response.statusCode == 200 && response.data != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static validateOtp(int number, int otp) async {
    try {
      final response = await _dio.post(
        '$baseUrl/login/otpValidate',
        data: {
          "countryCode": 91,
          "mobileNumber": number,
          "otp": otp,
        },
      );

      if (response.statusCode == 200 && response.data != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
