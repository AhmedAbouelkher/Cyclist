import 'package:cyclist/Controllers/repositories/UserToken/api_client.dart';
import 'package:cyclist/utils/shared_perfs_provider.dart';
import 'package:dio/dio.dart';

class HomeRepo {
  PreferenceUtils _prefs;
  Dio _dio;
  HomeApiClient _apiClient;

  HomeRepo() {
    _prefs = PreferenceUtils.getInstance();
    _dio = Dio();
    _apiClient = HomeApiClient(dio: _dio, prefs: _prefs);
  }
}
