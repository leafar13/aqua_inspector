class UserInfo {
  int id;
  String username;
  String fullName;
  String email;
  int organizationId;
  String organizationName;
  int roleId;
  String roleName;

  UserInfo({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    required this.organizationId,
    required this.organizationName,
    required this.roleId,
    required this.roleName,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["id"],
    username: json["username"],
    fullName: json["fullName"],
    email: json["email"],
    organizationId: json["organizationId"],
    organizationName: json["organizationName"],
    roleId: json["roleId"],
    roleName: json["roleName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "username": username,
    "fullName": fullName,
    "email": email,
    "organizationId": organizationId,
    "organizationName": organizationName,
    "roleId": roleId,
    "roleName": roleName,
  };
}
