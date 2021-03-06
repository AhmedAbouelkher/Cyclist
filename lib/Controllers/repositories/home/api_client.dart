import 'dart:async';
import 'package:cyclist/models/Rides/ride_post_request.dart';
import 'package:cyclist/utils/images.dart';
import 'package:cyclist/utils/shared_perfs_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

@deprecated
enum PostType { tips_before_buying, tool_kit }

class HomeApiClient {
  final PreferenceUtils prefs;
  final Dio dio;

  HomeApiClient({
    @required this.prefs,
    @required this.dio,
  })  : assert(dio != null),
        assert(prefs != null);

  Future homeData() async {
    final String _path = Constants.homeApi;
    try {
      Response resp = await dio.get(
        _path,
        options: Options(
          followRedirects: false,
          headers: {"Accept": 'application/json'},
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );

      if (resp.statusCode == 200) {
        return resp.data;
      } else {
        print("[Get Home] status message: #${resp.statusMessage}, status code: #${resp.statusCode}");
        return Future.error(resp.data);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
      return Future.error("error");
    }
  }

  Future sendMobileToken({@required String mobileToken}) async {
    final String _path = Constants.mobileTokenApi;
    try {
      Response resp = await dio.post(_path,
          options: Options(
            followRedirects: false,
            headers: {"Accept": 'application/json'},
            validateStatus: (status) {
              return status < 500;
            },
          ),
          data: {
            "token": mobileToken,
          });

      if (resp.statusCode == 200) {
        return resp.data;
      } else {
        print("[Post Mobile Token] status message: #${resp.statusMessage}, status code: #${resp.statusCode}");
        return Future.error(resp.data);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
      return Future.error("error");
    }
  }

  Future getPosts({@required int categoryId, String nextPageUrl}) async {
    final String _path = nextPageUrl ?? Constants.categoriesApi + "$categoryId/show";
    try {
      Response resp = await dio.get(
        _path,
        options: Options(
          followRedirects: false,
          headers: {"Accept": 'application/json'},
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );

      if (resp.statusCode == 200) {
        return resp.data;
      } else {
        print("[Get Posts] status message: #${resp.statusMessage}, status code: #${resp.statusCode}");
        return Future.error(resp.data);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
      return Future.error("error");
    }
  }

  Future getCategories({String nextPageUrl}) async {
    final String _path = nextPageUrl ?? Constants.categoriesApi;
    try {
      Response resp = await dio.get(
        _path,
        options: Options(
          followRedirects: false,
          headers: {"Accept": 'application/json'},
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );

      if (resp.statusCode == 200) {
        return resp.data;
      } else {
        print("[Get Categories] status message: #${resp.statusMessage}, status code: #${resp.statusCode}");
        return Future.error(resp.data);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
      return Future.error("error");
    }
  }

  Future getComments({@required int rideId, String nextPageUrl}) async {
    final String _path = nextPageUrl ?? Constants.ridesApi + "$rideId/show";
    try {
      Response resp = await dio.get(
        _path,
        options: Options(
          followRedirects: false,
          headers: {"Accept": 'application/json'},
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );

      if (resp.statusCode == 200) {
        return resp.data;
      } else {
        print("[Get Comments] status message: #${resp.statusMessage}, status code: #${resp.statusCode}");
        return Future.error(resp.data);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
      return Future.error("error");
    }
  }

  Future makeComment({@required int rideId, @required String comment}) async {
    final String _path = Constants.commentsApi;
    try {
      Response resp = await dio.post(_path,
          options: Options(
            followRedirects: false,
            headers: {"Accept": 'application/json'},
            validateStatus: (status) {
              return status < 500;
            },
          ),
          data: {
            "comment": comment,
            "ride_id": rideId,
          });

      if (resp.statusCode == 200) {
        return resp.data;
      } else {
        print("[Make Comments] status message: #${resp.statusMessage}, status code: #${resp.statusCode}");
        return Future.error(resp.data);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
      return Future.error("error");
    }
  }

  Future getRides({String nextPageUrl}) async {
    final String _path = nextPageUrl ?? Constants.ridesApi;
    try {
      Response resp = await dio.get(
        _path,
        options: Options(
          followRedirects: false,
          headers: {"Accept": 'application/json'},
          validateStatus: (status) {
            return status < 500;
          },
        ),
      );

      if (resp.statusCode == 200) {
        return resp.data;
      } else {
        print("[Get Rides] status message: #${resp.statusMessage}, status code: #${resp.statusCode}");
        return Future.error(resp.data);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
      return Future.error("error");
    }
  }

  Future storeRide({@required RidePost ridePost}) async {
    final String _path = Constants.ridesApi;
    try {
      Response resp = await dio.post(
        _path,
        options: Options(
          followRedirects: false,
          headers: {"Accept": 'application/json'},
          validateStatus: (status) {
            return status < 500;
          },
        ),
        data: ridePost.toJson(),
      );

      if (resp.statusCode == 200) {
        return resp.data;
      } else {
        print("[Post Ride] status message: #${resp.statusMessage}, status code: #${resp.statusCode}");
        return Future.error(resp.data);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        print(e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        print(e.request);
        print(e.message);
      }
      return Future.error("error");
    }
  }
}
