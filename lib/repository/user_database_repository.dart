abstract class UserDatabaseRepository {
  Future<UserModel> getUserInformation(String userId);
  Future<UserModel> updateUserInformation(UserModel userModel);
}
