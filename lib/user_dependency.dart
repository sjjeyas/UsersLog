
import 'package:hw_78/user_model.dart';

abstract class UserDependency{
  UserDependency();
  Future<User?> getUser(int id);
}