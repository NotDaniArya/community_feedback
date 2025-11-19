import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  Future<void> saveCurrentUserData({
    required String token,
    required String name,
    required String email,
  });

  Future<String?> getUserToken();

  Future<String?> getUserName();
  
  Future<String?> getUserEmail();

  Future<void> deleteCurrentUserData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;
  final FlutterSecureStorage secureStorage;

  const AuthLocalDataSourceImpl(this.sharedPreferences, this.secureStorage);

  @override
  Future<String?> getUserToken() async {
    return await secureStorage.read(key: 'user_token');
  }

  @override
  Future<void> saveCurrentUserData({
    required String token,
    required String name,
    required String email,
  }) async {
    await sharedPreferences.setString('user_name', name);
    await sharedPreferences.setString('user_email', email);
    await secureStorage.write(key: 'user_token', value: token);
  }

  @override
  Future<void> deleteCurrentUserData() async {
    await sharedPreferences.remove('user_name');
    await sharedPreferences.remove('user_email');
    await secureStorage.delete(key: 'user_token');
  }
  
  @override
  Future<String?> getUserEmail() async {
    return sharedPreferences.getString('user_email');
  }
  
  @override
  Future<String?> getUserName() async {
    return sharedPreferences.getString('user_name');
  }
}
