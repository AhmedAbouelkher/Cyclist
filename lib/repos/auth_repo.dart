//! DISABLED
class AuthRepo {
  // Future<String> sendSmsWithCode({String phoneNo}) async {
  //   try {
  //     String langCode = await LangRepo().getLocaleCode();
  //     String _path = "${Keys.websiteUrl}/$langCode/api/auth/LoginOrRegister";
  //     Response _response = await Dio().post(
  //       _path,
  //       options: Options(
  //         headers: {"Accept": 'application/json'},
  //       ),
  //       data: {
  //         "phone": phoneNo,
  //       },
  //     );
  //     bool _isOk = _response.statusCode == 200;
  //     if (_isOk) {
  //       // the msg has been sent
  //       return _response.data['user']['code'];
  //     } else {
  //       // err ocurerd
  //       return Future.error(_response.data['message']);
  //     }
  //   } catch (e) {
  //     print('err in sendSmsWithCode with $e');

  //     return Future.error('err');
  //   }
  // }

  // Future<ConfirmCodeResponse> checkCode({String phoneNo, String code}) async {
  //   try {
  //     String langCode = await LangRepo().getLocaleCode();
  //     String _path = "${Keys.websiteUrl}/$langCode/api/auth/CheckCode";
  //     Response _response = await Dio().post(
  //       _path,
  //       options: Options(
  //         headers: {
  //           "Accept": 'application/json',
  //         },
  //       ),
  //       data: {
  //         "phone": phoneNo,
  //         "code": code,
  //       },
  //     );
  //     if (_response.statusCode == 200) {
  //       // the code is Correct
  //       ConfirmCodeResponse codeResponse = ConfirmCodeResponse.fromJson(_response.data);
  //       if (codeResponse.message.contains("Successfully") && codeResponse.user.name != null) {
  //         await _saveUserToPrefs(response: codeResponse);
  //       }
  //       await _saveToken(token: codeResponse.accessToken);
  //       return codeResponse;
  //     } else if (_response.statusCode == 404) {
  //       return Future.error(_response.data['message'].toString());
  //     } else {
  //       // err ocurerd
  //       return Future.error(_response.data['message']);
  //     }
  //   } catch (e) {
  //     print('err in checkCode with $e');

  //     return Future.error(e);
  //   }
  // }

  // Future<void> _saveUserToPrefs({ConfirmCodeResponse response}) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   await preferences.setString(Keys.userDataKey, jsonEncode(response.user.toJson()));
  // }

  // Future<void> _saveToken({String token}) async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   await preferences.setString(Keys.tokenKey, token);
  // }

  // Future<String> getToken() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   final String token = preferences.getString(Keys.tokenKey);
  //   return token ?? '';
  // }

  // Future<bool> toggleNotifications() async {
  //   try {
  //     bool currentStatus = await getNotificationStatus();
  //     String notiToken;
  //     if (currentStatus) {
  //       notiToken = 'user set send notification to false';
  //     } else {
  //       // notiToken = await PushNotificationService().getToken();
  //     }
  //     final User user = await getCurrentUser();
  //     await updateUser(
  //       address: user.address,
  //       email: user.email,
  //       gender: user.gender,
  //       name: user.name,
  //       phone: user.phone,
  //       notiToken: notiToken,
  //     );
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     await preferences.setBool(Keys.notificationKey, !currentStatus);
  //     return !currentStatus;
  //   } catch (e) {
  //     print('catch in toggleNotifications() with $e');
  //     return Future.error(e);
  //   }
  // }

  // Future<bool> getNotificationStatus() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   return preferences.getBool(Keys.notificationKey);
  // }

  // Future<bool> updateUser({
  //   File photo,
  //   String name,
  //   String email,
  //   String phone,
  //   String address,
  //   String gender,
  //   String notiToken,
  // }) async {
  //   try {
  //     final String langCode = await LangRepo().getLocaleCode();
  //     final String _path = "${Keys.websiteUrl}/$langCode/api/auth/UpdateUser";
  //     // final String mobileToken = await PushNotificationService().getToken();
  //     final String authToken = await getToken();
  //     List<int> imageBytes = photo.readAsBytesSync();
  //     String base64Image = base64Encode(imageBytes);
  //     Map<String, String> body = {
  //       'name': name,
  //       'phone': phone,
  //       'gender': gender,
  //       'address': address,
  //       'mobile_token': notiToken ?? "mobileToken",
  //       'image': base64Image,
  //     };

  //     // email is optional
  //     if (email != null && email.trim().length != 0) {
  //       body['email'] = email;
  //     }

  //     Response _response = await Dio().post(
  //       _path,
  //       options: Options(
  //         followRedirects: false,
  //         validateStatus: (status) {
  //           return status < 500;
  //         },
  //         headers: {
  //           "Accept": 'application/json',
  //           "Authorization": "Bearer $authToken",
  //         },
  //       ),
  //       data: body,
  //     );
  //     print(_response.data);

  //     if (_response.statusCode == 200) {
  //       ConfirmCodeResponse r = ConfirmCodeResponse();
  //       r.user = User.fromJson(_response.data['user']);
  //       await _saveUserToPrefs(response: r);
  //       return true;
  //     } else {
  //       return Future.error(_response.data['message']);
  //     }
  //   } catch (e) {
  //     print('err in updateUser with $e');
  //     return Future.error(e);
  //   }
  // }

  // Future updateUserPhoto({File file}) async {
  //   try {
  //     User user = await getCurrentUser();
  //     return updateUser(
  //       photo: file,
  //       address: user.address,
  //       email: user.email,
  //       gender: user.gender,
  //       name: user.name,
  //       phone: user.phone,
  //     );
  //   } catch (e) {
  //     return Future.error(e);
  //   }
  // }

  // Future<User> getCurrentUser() async {
  //   try {
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     String userString = preferences.getString(Keys.userDataKey);
  //     final User user = User.fromJson(jsonDecode(userString));
  //     return user;
  //   } catch (e) {
  //     return null;
  //   }
  // }

  // Future<bool> isLoggedIn() async {
  //   // if there is token then the user is logged In
  //   final prf = await SharedPreferences.getInstance();
  //   String token = prf.getString(Keys.userDataKey);
  //   return token != null;
  // }

  // Future<void> signOut() async {
  //   // this function will clear the shared preferencess
  //   final prf = await SharedPreferences.getInstance();
  //   await prf.clear();
  // }
}
