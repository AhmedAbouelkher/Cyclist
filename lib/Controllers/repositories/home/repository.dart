import 'package:cyclist/Controllers/repositories/home/api_client.dart';
import 'package:cyclist/models/Categories/categories_response.dart';
import 'package:cyclist/models/Rides/ride_data.dart';
import 'package:cyclist/models/Rides/ride_post_request.dart';
import 'package:cyclist/models/Rides/ride_response.dart';
import 'package:cyclist/models/Rides/rides_response.dart';
import 'package:cyclist/models/posts/posts_response.dart';
import 'package:cyclist/models/token_request_resonse.dart';
import 'package:cyclist/utils/shared_perfs_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class HomeRepo {
  PreferenceUtils _prefs;
  Dio _dio;
  HomeApiClient _apiClient;

  HomeRepo() {
    _prefs = PreferenceUtils.getInstance();
    _dio = Dio();
    _apiClient = HomeApiClient(dio: _dio, prefs: _prefs);
  }

  Future<Posts> getPosts({@required int categoryId, String nextPageUrl}) async {
    try {
      final dataResp = await _apiClient.getPosts(categoryId: categoryId, nextPageUrl: nextPageUrl);
      return PostsResponse.fromJson(dataResp).posts;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<Token> sendMobileToken({@required String mobileToken}) async {
    try {
      final value = _prefs.getValueWithKey("mobile_token");
      if (value == null) {
        final dataResp = await _apiClient.sendMobileToken(mobileToken: mobileToken);
        final _resp = TokenResponse.fromJson(dataResp).token;
        await _prefs.saveValueWithKey<String>("mobile_token", _resp.token);
        return _resp;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<Rides> getRides({String nextPageUrl}) async {
    try {
      final dataResp = await _apiClient.getRides();
      return RidesResponse.fromJson(dataResp).rides;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<Categories> getCategories({String nextPageUrl}) async {
    try {
      final dataResp = await _apiClient.getCategories(nextPageUrl: nextPageUrl);
      return CategoriesResponse.fromJson(dataResp).categories;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<Comments> getComments({@required int rideId, String nextPageUrl}) async {
    try {
      final dataResp = await _apiClient.getComments(nextPageUrl: nextPageUrl, rideId: rideId);
      return SpacificRide.fromJson(dataResp).comments;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<bool> makeComment({@required int rideId, @required String comment}) async {
    try {
      // ignore: unused_local_variable
      final dataResp = (await _apiClient.makeComment(rideId: rideId, comment: comment))["message"];
      return true;
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }

  Future<RideResponse> storeRide({@required RidePost ridePost}) async {
    try {
      final dataResp = await _apiClient.storeRide(ridePost: ridePost);
      return RideResponse.fromJson(dataResp);
    } catch (e) {
      print(e);
      return Future.error(e);
    }
  }
}
