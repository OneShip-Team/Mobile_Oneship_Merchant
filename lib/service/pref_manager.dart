import 'package:oneship_merchant_app/presentation/data/model/user/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  String kToken = "api_key";
  String krefreshToken = "refresh_token";
  String kUserId = "userId";
  String kProvinceId = "province_id";
  String kUser = "user";
  String kUserName = "username";
  String kPassword = "password";
  PrefManager(this.preferences);

  /// Light, Dark ,System

  late SharedPreferences preferences;

  //for Bloc.Bloc.login
  set provinceId(String value) => preferences.setString(kProvinceId, value);

  set token(String? value) => preferences.setString(kToken, value ?? "");

  String? get token => preferences.getString(kToken);
  String? get refreshToken => preferences.getString(krefreshToken);
  set refreshToken(String? value) =>
      preferences.setString(krefreshToken, value ?? "");
  // String? get token => "";

  UserM? get user {
    final user = preferences.getString(kUser);
    if (user != null) {
      return UserM.fromJson(user);
    }
    // return UserM();
  }

  set user(UserM? value) {
    if (value != null) {
      preferences.setString(kUser, value.toJson());
    }
  }
  /////////
  ///

  ///
  String get userName => preferences.getString(kUserName) ?? "";
  set userName(String value) => preferences.setString(kUserName, value);
  String get password => preferences.getString(kPassword) ?? "";
  set password(String value) => preferences.setString(kPassword, value);

  void logout() {
    final user = userName;
    final pass = password;

    preferences.clear();
    userName = user;
    password = pass;
  }
}
