import '../../data/models/login_model.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel> login({required String username, required String password});
}
