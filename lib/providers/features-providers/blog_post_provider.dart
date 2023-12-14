// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'dart:io';

import 'package:com_policing_incident_app/providers/persistance_data/preferences.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/blog/models/blog_post.dart';
import 'package:com_policing_incident_app/services/config.dart';
import 'package:http/http.dart' as http;

class BlogPostProvider {
  final requestBaseUrl = Config.AuthBaseUrl;

  bool _isLoading = false;
  String _resMessage = '';

  bool _status = false;

  String _response = '';

  bool get getStatus => _status;

  String get getResponse => _response;

  //Getters
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  void adminPostBlog() async {
    _isLoading = true;
    _status = true;
    final preferences = await Preferences.getInstance();
    String? token = await preferences.getAccessToken();
    String? userId = await preferences.getUserId();

    print('JWT Token $token');
    print('User Id $userId');

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token '
    };

    try {
      String url = '$requestBaseUrl/blog/post';
    } on SocketException catch (_) {
    } catch (e) {}
  }

  Future<BlogPost> getBlogById() async {
    _isLoading = true;
    _status = true;
    final preferences = await Preferences.getInstance();
    String? token = await preferences.getAccessToken();
    String? userId = await preferences.getUserId();

    print('JWT Token $token');
    print('User Id $userId');

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token '
    };

    try {
      String url = '$requestBaseUrl/blog/post';
      final response = await http.get(Uri.parse(url), headers: requestHeaders);
      if (response.statusCode == 200) {
        final data = json.decode(response.body.toString());
        return BlogPost.fromJson(data);
      } else {
        final errorMessage = json.decode(response.body)['message'];
        throw Exception(
            'Failed to    ${response.statusCode} error ${errorMessage}');
      }
    } catch (error) {
      print(":::: $error");
    }
    throw Exception('Failed to load  error');
  }

  Future<BlogPost> updateBlogById() async {
    _isLoading = true;
    _status = true;
    final preferences = await Preferences.getInstance();
    String? token = await preferences.getAccessToken();
    String? userId = await preferences.getUserId();

    print('JWT Token $token');
    print('User Id $userId');

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token '
    };

    try {
      String url = '$requestBaseUrl/blog/post/?id=$userId';
      final response = await http.get(Uri.parse(url), headers: requestHeaders);
      if (response.statusCode == 200) {
        final data = json.decode(response.body.toString());
        return BlogPost.fromJson(data);
      } else {
        final errorMessage = json.decode(response.body)['message'];
        throw Exception(
            'Failed to    ${response.statusCode} error ${errorMessage}');
      }
    } catch (error) {
      print(":::: $error");
    }
    throw Exception('Failed to load  error');
  }
}
