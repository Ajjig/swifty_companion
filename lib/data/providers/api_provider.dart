import 'package:flutter/material.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:swifty_companion/core/constants.dart';

// example of login https://api.intra.42.fr/oauth/authorize?client_id=${INTRA_UID}&redirect_uri=swiftycompanion%3A%2F%2Fauth%2Fcallback&response_type=code

class ApiProvider {
  final FlutterAppAuth appAuth = FlutterAppAuth();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  Future<bool> login() async {
    debugPrint('Login function called');
    final AuthorizationTokenResponse? result =
        await appAuth.authorizeAndExchangeCode(
      AuthorizationTokenRequest(
        dotenv.env['INTRA_UID'].toString(),
        kIntraRedirectURL,
        clientSecret: dotenv.env['INTRA_SECRET'].toString(),
        scopes: <String>['public'],
        issuer: kIntra42URL,
        responseMode: 'query',
        serviceConfiguration: AuthorizationServiceConfiguration(
          authorizationEndpoint: kIntraAuthorizeURL,
          tokenEndpoint: kIntraTokenURL,
        ),
      ),
    );
    if (result != null) {
      debugPrint('Login successful !');
      debugPrint('---> ${result}');
      return true;
    } else {
      debugPrint('Login failed !');
      debugPrint('xxx> ${result}');
      return false;
    }
  }
}
