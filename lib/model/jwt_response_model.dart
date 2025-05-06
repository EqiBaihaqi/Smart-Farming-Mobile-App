class JwtTokenResponse {
  User? user;
  int? iat;
  int? exp;

  JwtTokenResponse({this.user, this.iat, this.exp});

  JwtTokenResponse.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    iat = json['iat'];
    exp = json['exp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['iat'] = iat;
    data['exp'] = exp;
    return data;
  }
}

class User {
  String? id;
  String? uroleId;
  String? username;
  String? email;
  String? googleId;
  String? fullname;
  Null avatar;
  bool? isBan;
  String? createdAt;
  String? updatedAt;
  Null deletedAt;
  Role? role;

  User(
      {this.id,
      this.uroleId,
      this.username,
      this.email,
      this.googleId,
      this.fullname,
      this.avatar,
      this.isBan,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    uroleId = json['urole_id'];
    username = json['username'];
    email = json['email'];
    googleId = json['google_id'];
    fullname = json['fullname'];
    avatar = json['avatar'];
    isBan = json['is_ban'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['urole_id'] = uroleId;
    data['username'] = username;
    data['email'] = email;
    data['google_id'] = googleId;
    data['fullname'] = fullname;
    data['avatar'] = avatar;
    data['is_ban'] = isBan;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (role != null) {
      data['role'] = role!.toJson();
    }
    return data;
  }
}

class Role {
  String? id;
  String? code;
  String? name;
  String? createdAt;
  String? updatedAt;

  Role({this.id, this.code, this.name, this.createdAt, this.updatedAt});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['code'] = code;
    data['name'] = name;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
