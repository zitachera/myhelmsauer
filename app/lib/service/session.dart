import 'dart:convert';

import 'package:customer_portal_app/service/portal_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Session {
  static const String _tokenKey = 'token';
  static final _storage = FlutterSecureStorage();

  static Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
  }

  static Future<LoginResult> restore() async {
    final token = await _readToken();

    if (token == null || token.isEmpty) {
      return LoginResult();
    }

    final portal = PortalService(token);
    await portal.reload();

    return LoginResult(portal: portal);
  }

  static Future<LoginResult> login(String user, String password, String gruppe) async {
    final response = await PortalService.publicPost(
      'login',
      <String, String>{
        'user': user,
        'password': password,
        'gruppe': gruppe,
      },
    );
    if (response.statusCode != 200) {
      return LoginResult(error: 'Login fehlgeschlagen');
    }
    final token = jsonDecode(response.body)["token"];
    await _writeToken(token);

    PortalService portal = PortalService(token);
    await portal.reload();
    return LoginResult(portal: portal);
  }

  static Future<String?> _readToken() => _storage.read(key: _tokenKey);

  static Future<void> _writeToken(String token) => _storage.write(key: _tokenKey, value: token);
}

class LoginResult {
  final PortalService? portal;
  final String? error;

  LoginResult({this.portal, this.error});
}
