
import 'package:flutter/material.dart';
import 'package:hw_78/http_user_dependency.dart';
import 'package:hw_78/user_model.dart';

import 'package:hw_78/user_state.dart';
import 'package:hw_78/user_value_notifier.dart';

class UserProfileWidget extends StatefulWidget {
  UserProfileWidget({super.key, required this.userid});
  int userid;

  @override
  State<StatefulWidget> createState() => _ProfileState(userid);
}

class _ProfileState extends State<UserProfileWidget> {
  _ProfileState(this.id){
    initState();
  }
  int id;
  late UserValueNotifier _notifier;

  @override
  void initState() {
    _notifier=  UserValueNotifier(id: id, dependency: HttpUserDependency());
    super.initState();
  }

  int getId(){
    if (_notifier.value is UserState){
      UserStateLoaded user = _notifier.value as UserStateLoaded;
      return user.id;
    }
    return 0;
  }
  String getFirstName(){
    if (_notifier.value is UserStateLoaded){
      UserStateLoaded user = _notifier.value as UserStateLoaded;
      return "Hello, ${user.firstName}";
    }else if (_notifier.value is UserStateError){
      return "An error occurred";
    }
    else{
      return "Press button to load";
    }
  }

  String getLastName(){
    if (_notifier.value is UserStateLoaded){
      UserStateLoaded user = _notifier.value as UserStateLoaded;
      return user.lastName;
    }else{
      return "";
    }
  }
  String getEmail(){
    if (_notifier.value is UserStateLoaded){
      UserStateLoaded user = _notifier.value as UserStateLoaded;
      return user.email;
    }else{
      return "";
    }
  }
  String getAvatar(){
    if (_notifier.value is UserStateLoaded){
      UserStateLoaded user = _notifier.value as UserStateLoaded;
      return user.avatar;
    }else{
      return "";
    }
  }

  void incrementID(){
    widget.userid = widget.userid +1;
    id = id+1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('User Profile #${_notifier.id}'),
      ),
      body: ValueListenableBuilder<UserState>(
          valueListenable: _notifier,
          builder: (context, value, _) {
            return Center(
              child:
                  Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      getFirstName() + " " +getLastName(),
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                    Text(
                      getEmail(),
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                    Text(
                      getAvatar(),
                      style: Theme
                          .of(context)
                          .textTheme
                          .headlineMedium,
                    ),
                  ]
              )
            );
          }
        ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            _notifier =  UserValueNotifier(id: id, dependency: HttpUserDependency());
            _notifier.load();
            UserState u = _notifier.value;
            incrementID();
           });
          },
        tooltip: 'Increment',
        child: const Icon(Icons.download),
      ),
    );
  }
}
