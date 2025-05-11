class User {
  final String email;
  final String password;
  final String role; // 'learner' ou 'trainer'

  User({required this.email, required this.password, required this.role});
}
