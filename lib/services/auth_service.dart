import '../models/user_model.dart';
import '../database/db_helper.dart';

class AuthService {
  final DBHelper _dbHelper = DBHelper();

  Future<User?> login(String email, String password) async {
    return await _dbHelper.getUser(email, password);
  }

  Future<bool> signup(User user) async {
    // Vérifier si l’email existe déjà
    final existingUser = await _dbHelper.getUserByEmail(user.email);
    if (existingUser != null) {
      return false; // Email déjà utilisé
    }

    try {
      await _dbHelper.insertUser(user);
      return true;
    } catch (e) {
      print('Erreur lors de l’inscription : $e');
      return false;
    }
  }
}
