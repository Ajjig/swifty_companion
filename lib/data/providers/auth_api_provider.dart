import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:swifty_companion/business_logic/cubit/user_cubit.dart';
import 'package:swifty_companion/core/constants.dart';
import 'package:oauth2/oauth2.dart' as oauth2;
import 'package:swifty_companion/data/providers/api_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class AuthApiProvider {
  static const _storage = FlutterSecureStorage();
  static oauth2.AuthorizationCodeGrant? _grant;
  static oauth2.Credentials _credentials = oauth2.Credentials('');

  static bool get isLoggedIn => _credentials.accessToken.isNotEmpty;
  static oauth2.Client get client => oauth2.Client(_credentials);
  static oauth2.Credentials get credentials => _credentials;

  static Future<void> init() async {
    final credentials = await _storage.read(key: 'credentials');
    if (credentials != null) {
      _credentials = oauth2.Credentials.fromJson(credentials);
      if (_credentials.isExpired) {
        _credentials = await _credentials.refresh(
          identifier: dotenv.env['INTRA_UID']!,
          secret: dotenv.env['INTRA_SECRET']!,
          newScopes: ['public'],
        );
        await _storage.write(
          key: 'credentials',
          value: _credentials.toJson(),
        );
        ApiProvider.refresh();
      }
      ApiProvider.refresh();
      UserCubit().getCurrentUser();
    } else {
      _credentials = oauth2.Credentials('');
      ApiProvider.refresh();
      UserCubit().logout();
    }
  }

  static void callback(Uri uri) async {
    final code = uri.queryParameters['code'];
    if (code == null || code.isEmpty) return;

    final result = await _grant!.handleAuthorizationResponse({'code': code});

    await _storage.write(
      key: 'credentials',
      value: result.credentials.toJson(),
    );

    _credentials = result.credentials;
    ApiProvider.refresh();
    UserCubit().getCurrentUser();
  }

  static Future<void> logout() async {
    await _storage.delete(key: 'credentials');
    _credentials = oauth2.Credentials('');
    ApiProvider.refresh();
  }

  static Future<void> login() async {
    final authorizationEndpoint = Uri.parse(kIntraAuthorizeURL);
    final tokenEndpoint = Uri.parse(kIntraTokenURL);
    final identifier = dotenv.env['INTRA_UID']!;
    final secret = dotenv.env['INTRA_SECRET']!;
    final redirectUrl = Uri.parse('swiftycompanion://authcallback');

    _grant = oauth2.AuthorizationCodeGrant(
      identifier,
      authorizationEndpoint,
      tokenEndpoint,
      secret: secret,
    );

    final authorizationUrl =
        _grant!.getAuthorizationUrl(redirectUrl, scopes: ['public']);

    await launchUrl(
      authorizationUrl,
      mode: LaunchMode.inAppBrowserView,
    );
  }
}
