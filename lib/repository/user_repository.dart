import 'package:flutter/foundation.dart';

class UserRepostitory {
  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    print(username);
    print(password);
    await Future.delayed(Duration(seconds: 1));
    if (username == 'admin' && password == '123456') {
      return 'token';
    }
    throw Exception('username: admin, pass: 123456');
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
