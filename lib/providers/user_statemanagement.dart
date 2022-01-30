import 'package:flutter/widgets.dart';
import '../models/userdata.dart';
import '../models/auth.dart';

//inheriting some function to our class from changenotifier
class UserProvider with ChangeNotifier {
  User? _user; //nullable
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}