class Keys {
  static String _websiteUrl;
  static String get websiteUrl => _websiteUrl;
  // static String get websiteUrl => 'http://real-mode.com';
  // static const String websiteUrl = 'https://mazajasly.com';
  static const String googleApiKey = 'AIzaSyB7PAUL-qTHLWKUEZnJt5j5GqD67zdrubY';
  static const String mapsKey = '';
  static const String langKey = 'langKey';
  static const String tokenKey = 'token';
  static const String userDataKey = 'userDataKey';
  static const String notificationKey = 'notificationKey';

  void setUrl(String url) {
    if (_websiteUrl == null) {
      print(url);
      _websiteUrl = url;
    }
  }
}
