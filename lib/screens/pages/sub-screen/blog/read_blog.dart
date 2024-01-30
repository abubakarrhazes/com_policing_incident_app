// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously, must_be_immutable
import 'dart:convert';
import 'dart:io';

import 'package:com_policing_incident_app/models/get-models/police.dart';
import 'package:com_policing_incident_app/providers/persistance_data/preferences.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/blog/models/comment_model.dart';
import 'package:com_policing_incident_app/services/config.dart';
import 'package:com_policing_incident_app/utilities/http_error_handling.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:com_policing_incident_app/screens/pages/sub-screen/blog/models/blog_post.dart';

class ReadBlog extends StatefulWidget {
  DataPost dataPost;
  ReadBlog({
    Key? key,
    required this.dataPost,
  }) : super(key: key);

  @override
  State<ReadBlog> createState() => _ReadBlogState();
}

class _ReadBlogState extends State<ReadBlog> {
  final commentController = TextEditingController();
  final commentFormKey = GlobalKey<FormState>();
  final requestBaseUrl = Config.AuthBaseUrl;
  bool _isLoading = false;
  String _resMessage = '';

//Getters
  bool get isLoading => _isLoading;
  String get resMessage => _resMessage;

  Future<void> comment(CommentData commentData, BuildContext context) async {
    String url = '$requestBaseUrl/blog/comment';

    final preferences = await Preferences.getInstance();
    String? token = await preferences.getAccessToken();
    print("Report JWT $token");

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    final body = jsonEncode(commentData.toJson());

    try {
      http.Response response =
          await http.post(Uri.parse(url), headers: requestHeaders, body: body);
      if (response.statusCode == 200) {
        _handleSuccessResponse(response, context);
      } else {
        _handleErrorResponse(response, context);
      }
    } on SocketException catch (_) {
      _handleError(context, "Internet Connection is not available");
    } catch (e) {
      _handleError(context, "Please Try again");
    }
  }

//Handle Success Response

  void _handleSuccessResponse(
      http.Response response, BuildContext context) async {
    _isLoading = false;

    try {
      final responseData = await _parseResponse(response);
      _resMessage = responseData["message"];
      utils.successShowToast(context, _resMessage);

      print(_resMessage);
    } catch (e) {
      print('Error handling success response: $e');
      utils.showToast(context, 'Error handling success response');
    }
  }

//Handle Error Response
  void _handleErrorResponse(
      http.Response response, BuildContext context) async {
    try {
      final res = await _parseResponse(response);
      _resMessage = res['message'];
      utils.showToast(context, _resMessage);

      _isLoading = false;
    } catch (e) {
      print('Error handling error response: $e');
      utils.showToast(context, 'Error handling error response');
    }
  }

//Json Decode Convert

  Future<dynamic> _parseResponse(http.Response response) async {
    final responseBody = response.body;
    final dynamic decodedResponse = await json.decode(responseBody);
    return decodedResponse;
  }

//Handle Error
  void _handleError(BuildContext context, String errorMessage) {
    _isLoading = false;
    _resMessage = errorMessage;
    utils.showToast(context, _resMessage);
  }

  void commentPost(BuildContext context) {
    comment(
        CommentData(
          post: '${widget.dataPost.id}',
          content: commentController.text,
        ),
        context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  '${widget.dataPost.title}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Image.network('${widget.dataPost.image}'),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '${widget.dataPost.description}',
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Form(
                          key: commentFormKey,
                          child: TextFormField(
                            controller: commentController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Description is  Required';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Add a comment...',
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8.0),
                      ElevatedButton(
                        onPressed: () {
                          // Implement comment submission logic here
                          // You may want to send the comment to your API
                          commentPost(context);
                        },
                        child: Text('Comment'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
