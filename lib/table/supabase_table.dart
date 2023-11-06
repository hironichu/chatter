abstract class SupabaseTable {
  const SupabaseTable();
  String get tableName;
}

class ProfileSupabaseTable implements SupabaseTable {
  const ProfileSupabaseTable();

  @override
  String get tableName => "profiles";

  String get idColumn => "id";
  String get idUsername => "first_name";
}
