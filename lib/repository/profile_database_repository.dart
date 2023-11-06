import 'package:chatter_application/model/profil_model.dart';

abstract class ProfileDatabaseRepository {
  Future<ProfileModel> getUserInformation(String userId);
  Future<ProfileModel> updateUserInformation(ProfileModel userModel);
}
