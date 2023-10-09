class ProfileModel {
  final String id;
  final String? username;

  const ProfileModel({
    required this.id,
    this.username,
  });

  static ProfileModel fromJson(Map<String, dynamic> json) => ProfileModel(
        id: json['id'] as String,
        username: json['username'] as String?,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'username': username,
      };
}
