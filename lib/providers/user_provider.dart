import 'package:flutter/foundation.dart';
import '../models/user.dart';

class UserProvider with ChangeNotifier {
  User _user = User.mock();

  User get user => _user;

  // Update user information
  void updateUser({
    String? name,
    String? email,
    String? phoneNumber,
    String? address,
    String? avatarUrl,
  }) {
    _user = User(
      name: name ?? _user.name,
      email: email ?? _user.email,
      phoneNumber: phoneNumber ?? _user.phoneNumber,
      address: address ?? _user.address,
      avatarUrl: avatarUrl ?? _user.avatarUrl,
    );
    notifyListeners();
  }
}
