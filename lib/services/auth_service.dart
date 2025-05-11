import '../models/user_model.dart';

class AuthService {
  // Fake login pour simuler l'auth
  Future<User?> login(String email, String password) async {
    // tu peux mettre une vraie logique plus tard
    if (email == "trainer@test.com") {
      return User(email: email, password: password, role: 'trainer');
    } else if (email == "learner@test.com") {
      return User(email: email, password: password, role: 'learner');
    }
    return null;
  }
}
