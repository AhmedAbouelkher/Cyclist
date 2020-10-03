import 'package:cyclist/models/responses/cats_response.dart';
import 'package:cyclist/models/responses/home_response.dart';
import 'package:cyclist/models/responses/search_in_products_response.dart';
import 'package:cyclist/models/responses/show_cat_products.dart';
import 'package:cyclist/repos/lang_repo.dart';
import 'package:cyclist/utils/keys.dart';
import 'package:dio/dio.dart';

class HomeRepo {
  Future<HomeResponse> getSlides({String phoneNo}) async {
    try {
      String langCode = await LangRepo().getLocaleCode();
      String _path = "${Keys.websiteUrl}/$langCode/api/client/";
      Response _response = await Dio().get(
        _path,
        options: Options(
          headers: {"Accept": 'application/json'},
        ),
      );
      bool _isOk = _response.statusCode == 200;
      if (_isOk) {
        // you got slides
        return HomeResponse.fromJson(_response.data);
      } else {
        // err ocurerd
        return Future.error(_response.data['message']);
      }
    } catch (e) {
      print('err in getSlides with $e');

      return Future.error('err');
    }
  }

  Future<List<City>> getCities() async {
    try {
      String langCode = await LangRepo().getLocaleCode();
      String _path = "${Keys.websiteUrl}/$langCode/api/client/";
      Response _response = await Dio().get(
        _path,
        options: Options(
          headers: {"Accept": 'application/json'},
        ),
      );
      bool _isOk = _response.statusCode == 200;
      if (_isOk) {
        return HomeResponse.fromJson(_response.data).cities;
      } else {
        return Future.error(_response.data['message']);
      }
    } catch (e) {
      print('err in getCities with $e');

      return Future.error('err');
    }
  }

  Future<CatsResponse> getCategories() async {
    try {
      String langCode = await LangRepo().getLocaleCode();
      //https://mazajasly.com/ar/api/client/categories
      String _path = "${Keys.websiteUrl}/$langCode/api/client/categories";

      Response _response = await Dio().get(
        _path,
        options: Options(
          headers: {
            "Accept": 'application/json',
          },
        ),
      );

      if (_response.statusCode == 200) {
        // you got slides
        return CatsResponse.fromJson(_response.data);
      } else {
        // err ocurerd
        return Future.error(_response.data['message']);
      }
    } catch (e) {
      print('err in getCategories with $e');

      return Future.error('err');
    }
  }

  Future<SerachProductsResponse> searchInProducts({String keyword, String nexPageUrl}) async {
    try {
      String langCode = await LangRepo().getLocaleCode();
      String _path = nexPageUrl ?? "${Keys.websiteUrl}/$langCode/api/client/products";
      Response _response = await Dio().get(
        _path,
        options: Options(
          headers: {
            "Accept": 'application/json',
          },
        ),
        queryParameters: {"search": keyword},
      );
      if (_response.statusCode == 200) {
        // done
        return SerachProductsResponse.fromJson(_response.data);
      } else {
        // err ocurerd
        return Future.error(_response.data['message']);
      }
    } catch (e) {
      print('err in searchInProducts with $e');
      return Future.error('err');
    }
  }

  Future<ShowCatProducts> showCatProducts({int catId}) async {
    try {
      String langCode = await LangRepo().getLocaleCode();
      String _path = "${Keys.websiteUrl}/$langCode/api/client/categories/$catId/show";

      Response _response = await Dio().get(
        _path,
        options: Options(
          headers: {
            "Accept": 'application/json',
          },
        ),
      );
      bool _isOk = _response.statusCode == 200;
      if (_isOk) {
        // you got slides
        return ShowCatProducts.fromJson(_response.data);
      } else {
        // err ocurerd
        return Future.error(_response.data['message']);
      }
    } catch (e) {
      print('err in showCatProducts with $e');

      return Future.error('err');
    }
  }

//! DISABLED
  // Future<NotificationsResponse> getNotifications() async {
  //   try {
  //     String langCode = await LangRepo().getLocaleCode();
  //     String _path = "${Keys.websiteUrl}/$langCode/api/notifications";
  //     Response _response = await Dio().get(
  //       _path,
  //       options: Options(
  //         headers: {
  //           "Accept": 'application/json',
  //         },
  //       ),
  //     );
  //     bool _isOk = _response.statusCode == 200;
  //     if (_isOk) {
  //       // you got slides
  //       return NotificationsResponse.fromJson(_response.data);
  //     } else {
  //       // err ocurerd
  //       return Future.error(_response.data['message']);
  //     }
  //   } catch (e) {
  //     print('err in getNotifications with $e');

  //     return Future.error('err');
  //   }
  // }

//! DISABLED
  // Future<bool> storeOrDestoryFav({int prodId}) async {
  //   try {
  //     String langCode = await LangRepo().getLocaleCode();
  //     String _path = "${Keys.websiteUrl}/$langCode/api/favorite";
  //     Response _response = await Dio().post(_path,
  //         options: Options(
  //           headers: {
  //             "Accept": 'application/json',
  //           },
  //         ),
  //         data: {"product_id": prodId});
  //     bool _isOk = _response.statusCode == 200;
  //     if (_isOk) {
  //       // done
  //       print("ok");
  //       return true;
  //     } else {
  //       // err ocurerd
  //       return Future.error(_response.data['message']);
  //     }
  //   } catch (e) {
  //     print('err in storeOrDestoryFav with $e');

  //     return Future.error('err');
  //   }
  // }

  //! DISABLED
  // Future<FavoritesResponse> getAllFav() async {
  //   try {
  //     String langCode = await LangRepo().getLocaleCode();
  //     String _path = "${Keys.websiteUrl}/$langCode/api/favorite";
  //     final String token = await AuthRepo().getToken();
  //     Response _response = await Dio().get(
  //       _path,
  //       options: Options(
  //         headers: {"Accept": 'application/json', 'Authorization': "Bearer " + token},
  //       ),
  //     );
  //     //      print(_response.data);
  //     if (_response.statusCode == 200) {
  //       // done
  //       return FavoritesResponse.fromJson(_response.data);
  //     } else {
  //       // err ocurerd
  //       return Future.error(_response.data['message']);
  //     }
  //   } catch (e) {
  //     print('err in getAllFav with $e');

  //     return Future.error('err');
  //   }
  // }
}
