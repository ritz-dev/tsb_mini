import 'package:shared_preferences/shared_preferences.dart';
import 'package:tsb_mini/utils/storage/storage_interface.dart';

class WebAuthStorage extends StorageInterface{

  @override
  Future<void> saveToken(String token) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token',token);
  }

  @override
  Future<String?> getToken() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  @override
  Future<void> deleteToken() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
  }

  @override
  Future<void> saveUserSlug(String userSlug) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_slug',userSlug);
  }

  @override
  Future<String?> getUserSlug() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_slug');
  }

  @override
  Future<void> deleteUserSlug() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user_slug');
  }
}