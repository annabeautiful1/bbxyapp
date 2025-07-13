import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  final String email;
  final String? username;
  final String? avatar;
  final int? balance;
  final int? traffic;
  final int? usedTraffic;
  final String? expireDate;
  final int? inviteCount;
  final bool? isAdmin;
  final String? telegramId;
  final String? createdAt;
  final String? updatedAt;

  const User({
    required this.id,
    required this.email,
    this.username,
    this.avatar,
    this.balance,
    this.traffic,
    this.usedTraffic,
    this.expireDate,
    this.inviteCount,
    this.isAdmin,
    this.telegramId,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  User copyWith({
    int? id,
    String? email,
    String? username,
    String? avatar,
    int? balance,
    int? traffic,
    int? usedTraffic,
    String? expireDate,
    int? inviteCount,
    bool? isAdmin,
    String? telegramId,
    String? createdAt,
    String? updatedAt,
  }) {
    return User(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      avatar: avatar ?? this.avatar,
      balance: balance ?? this.balance,
      traffic: traffic ?? this.traffic,
      usedTraffic: usedTraffic ?? this.usedTraffic,
      expireDate: expireDate ?? this.expireDate,
      inviteCount: inviteCount ?? this.inviteCount,
      isAdmin: isAdmin ?? this.isAdmin,
      telegramId: telegramId ?? this.telegramId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'User(id: $id, email: $email, username: $username)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}
