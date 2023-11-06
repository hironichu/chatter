import 'package:chatter_application/model/profil_model.dart';
import 'package:chatter_application/repository/profile_database_repository.dart';
import 'package:chatter_application/table/supabase_table.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseDatabaseRepository implements ProfileDatabaseRepository {
  final Supabase _supabase;
  final ProfileSupabaseTable _userSupabaseTable;

  const SupabaseDatabaseRepository(this._supabase, this._userSupabaseTable);

  @override
  Future<ProfileModel> getUserInformation(String userId) async {
    final response = await _supabase.client
        .from(_userSupabaseTable.tableName)
        .select()
        .eq(_userSupabaseTable.idColumn, userId)
        .single();

    final userModel = ProfileModel.fromJson(response as Map<String, dynamic>);
    return userModel;
  }

  @override
  Future<ProfileModel> updateUserInformation(ProfileModel userModel) async {
    await _supabase.client
        .from(_userSupabaseTable.tableName)
        .update(userModel.toJson());
    return userModel;
  }
}
