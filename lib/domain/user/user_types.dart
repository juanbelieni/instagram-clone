import 'package:instagram_clone/domain/user/user.dart';

abstract class IUserRepository {
  Future<User> getOneByUsername(String username);
}