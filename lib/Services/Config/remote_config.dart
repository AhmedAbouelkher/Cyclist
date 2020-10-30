import 'package:firebase_remote_config/firebase_remote_config.dart';

const String trialPeroidKey = "app_trial_control";
const String googleMapsApiKey = "api_key";

class RemoteConfigService {
  final RemoteConfig _remoteConfig;
  final defaults = <String, dynamic>{trialPeroidKey: false, googleMapsApiKey: "AIzaSyCj-aYdR58h0wlh2NCHZAMfU8E52LIWAlI"};

  static RemoteConfigService _instance;
  static Future<RemoteConfigService> getInstance() async {
    if (_instance == null) {
      _instance = RemoteConfigService(
        remoteConfig: await RemoteConfig.instance,
      );
    }
    return _instance;
  }

  RemoteConfigService({RemoteConfig remoteConfig}) : _remoteConfig = remoteConfig;

  bool get isInTrielPeroid => _remoteConfig.getBool(trialPeroidKey);
  String get apiKey => _remoteConfig.getString(googleMapsApiKey);

  Future<bool> initialise() async {
    try {
      await _remoteConfig.setDefaults(defaults);
      return await _fetchAndActivate();
    } on FetchThrottledException catch (e) {
      print('Remote config fetch throttled: $e');
      return null;
    } catch (e) {
      print('Unable to fetch remote config. Cached or default values will be used');
      return null;
    }
  }

  Future<bool> _fetchAndActivate() async {
    await _remoteConfig.fetch(expiration: const Duration(seconds: 0));
    return await _remoteConfig.activateFetched();
  }
}
