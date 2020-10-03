import 'package:cyclist/models/coupon_model.dart';
import 'package:cyclist/models/responses/Checkout/order_post_request.dart';
import 'package:cyclist/models/responses/Checkout/order_post_response.dart';
import 'package:cyclist/utils/keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'lang_repo.dart';

class OrdersRepo {
  Future<OrderResponse> orderCart({
    @required PostOrder order,
  }) async {
    try {
      String langCode = await LangRepo().getLocaleCode();
      String _path = "${Keys.websiteUrl}/$langCode/api/client/orders";
      Response _response = await Dio().post(
        _path,
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          },
          headers: {"Accept": 'application/json'},
        ),
        data: order.toJson(),
      );
      if (_response.statusCode == 200) {
        print("ORDER CREATED, hasUrl: #${(_response.data['url'] as String).isNotEmpty}");
        // try {
        final data = OrderResponse.fromJson(_response.data);

        return data;
        // } catch (e) {
        //   await _cartRepo.clearCart();
        //   print("ERROR #${e.toString()}");
        //   return null;
        // }
      } else {
        // err ocurerd
        return Future.error(_response.data['message']);
      }
    } catch (e) {
      print('ERROR in orderCart() with $e');

      return Future.error(e);
    }
  }

  Future<Coupon> checkCoupon(String couponText) async {
    try {
      String langCode = await LangRepo().getLocaleCode();
      String _path = "${Keys.websiteUrl}/$langCode/api/client/coupon";
      Response _response = await Dio().post(_path,
          options: Options(
            headers: {"Accept": 'application/json'},
          ),
          data: {
            "coupon": couponText,
          });
      if (_response.statusCode == 200) {
        if (_response.data['coupon'] == null) {
          String errMsg = langCode == 'ar' ? "الكوبون غير صالح" : "copon is not vaild";
          return Future.error(errMsg);
        }
        // the msg has been sent
        print(_response.data);
        return CouponResponse.fromJson(_response.data).coupon;
      } else {
        // err ocurerd
        return Future.error(_response.data['message']);
      }
    } catch (e) {
      print('err in sendSmsWithCode with $e');
      return Future.error(e);
    }
  }
}
