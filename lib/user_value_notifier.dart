


import 'package:flutter/material.dart';
import 'package:hw_78/http_user_dependency.dart';

import 'package:hw_78/user_state.dart';

class UserValueNotifier extends ValueNotifier<UserState>{
  UserValueNotifier({required this.id, required this.dependency}): super(UserStateLoading(id: id));
  
  final int id;
  final HttpUserDependency dependency;
  //late UserState value = UserStateLoading(id: id);

  Future<UserState> load() async{
    if (value is UserStateLoaded){
      return value;
    }
    final userId = value.id;

    final user = await dependency.getUser(userId);
    if (user == null){
      value = UserStateError(id: userId);
      return value;
    }
    value = UserStateLoaded(
      id: user.id,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      avatar: user.avatar,
    );
    return value;
  }
}