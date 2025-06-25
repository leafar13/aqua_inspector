class User {
  final int id;
  final String username;
  final String fullName;
  final String email;
  final int organizationId;
  final String organizationName;
  final int roleId;
  final String roleName;

  User({
    required this.id,
    required this.username,
    required this.fullName,
    required this.email,
    required this.organizationId,
    required this.organizationName,
    required this.roleId,
    required this.roleName,
  });
}
