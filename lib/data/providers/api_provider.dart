import 'package:dio/dio.dart';
import 'package:swifty_companion/core/constants.dart';
import 'package:swifty_companion/data/providers/auth_api_provider.dart';

class ApiProvider {
  static const _baseUrl = '$kIntra42URL/v2';
  static final _dio = Dio(
    BaseOptions(baseUrl: _baseUrl, responseType: ResponseType.json, headers: {
      'Authorization': 'Bearer ${AuthApiProvider.credentials.accessToken}'
    }),
  );
  static refresh() {
    _dio.options.headers['Authorization'] =
        'Bearer ${AuthApiProvider.credentials.accessToken}';
  }

  static Future<Response> getCurrentUser() async {
    return _dio.get('/me');
  }

  static Future<Response> getProfileInfo(String login) async {
    return _dio.get('/users/$login');
  }

  static Future<Response> getCoalitions(String login) async {
    return _dio.get('/users/$login/coalitions');
  }

  static Future<Response> getProjects(String login) async {
    return _dio.get('/users/$login/projects_users');
  }

  static Future<Response> getAchievements(String login) async {
    return _dio.get('/users/$login/achievements');
  }

  static Future<Response> getSkills(String login) async {
    return _dio.get('/users/$login/skills');
  }

  static Future<Response> getCampus(String login) async {
    return _dio.get('/users/$login/campus_users');
  }

  static Future<Response> getLocations(String login) async {
    return _dio.get('/users/$login/locations');
  }

  static Future<Response> getTitles(String login) async {
    return _dio.get('/users/$login/titles');
  }

  static Future<Response> getExpertises(String login) async {
    return _dio.get('/users/$login/expertises');
  }
}
