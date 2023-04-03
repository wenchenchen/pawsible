abstract class UserRepository {

  Future<void> saveUserData(String userData);
  Future<String?> getUserData();
  Future<void> clear();
  Future<String?> getToken();


}