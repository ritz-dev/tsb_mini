abstract class StorageInterface {

  Future<void> saveToken(String token);

  Future<String?> getToken();

  Future<void> deleteToken();

  Future<void> saveUserSlug(String userSlug);

  Future<String?> getUserSlug();

  Future<void> deleteUserSlug();
}