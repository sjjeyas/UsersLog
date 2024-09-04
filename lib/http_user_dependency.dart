import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:hw_78/user_dependency.dart';
import 'package:hw_78/user_model.dart';

class HttpUserDependency implements UserDependency{
  @override
  Future<User?> getUser(int id) async {
    final url = Uri.parse('https://reqres.in/api/users/$id');
    final response = await http.get(url);
    if (response.statusCode != 200){
      return null;
    }
    Map<String, dynamic> userDataAsMap = jsonDecode(response.body)['data'];
    return User(
      id: userDataAsMap['id'],
      firstName: userDataAsMap['first_name'],
      lastName: userDataAsMap['last_name'],
      email: userDataAsMap['email'],
      avatar: userDataAsMap['avatar'],
    );
  }
}