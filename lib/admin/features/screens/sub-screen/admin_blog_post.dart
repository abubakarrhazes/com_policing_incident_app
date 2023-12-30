// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_field

import 'dart:io';

import 'package:com_policing_incident_app/providers/admin-providers/admin_provider.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/blog/models/blog_post.dart';
import 'package:com_policing_incident_app/utilities/http_error_handling.dart';
import 'package:com_policing_incident_app/widgets/avatar.dart';
import 'package:com_policing_incident_app/widgets/button_widget.dart';
import 'package:com_policing_incident_app/widgets/media_selection.dart';
import 'package:com_policing_incident_app/widgets/my_input_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AdminBlogPost extends StatefulWidget {
  const AdminBlogPost({super.key});

  @override
  State<AdminBlogPost> createState() => _AdminBlogPostState();
}

class _AdminBlogPostState extends State<AdminBlogPost> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _adminBlogPostformKey = GlobalKey<FormState>();
  final AdminProvider adminProvider = AdminProvider();
  String? imagePath;
  bool _isLoading = false;

  void selectImages() async {
    final path = await utils.pickImage(ImageSource.gallery);

    setState(() {
      imagePath = path;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
  // Post Blog By Admin

  void adminBlogPost() {
    adminProvider.postBlogByAdmin(
        DataPost(
          title: _titleController.text,
          description: _descriptionController.text,
          image: imagePath,
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
                Image.network(
                    'https://www.blogtyrant.com/wp-content/uploads/2017/02/how-to-write-a-good-blog-post.png'),
                Form(
                    key: _adminBlogPostformKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Blog Title'),
                        MyInputField(
                          hintText: 'Blog Title Here',
                          keyboardType: TextInputType.text,
                          controller: _titleController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ' Required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Description'),
                        MyInputField(
                          hintText: 'Decription Here',
                          min: 1,
                          max: 10000,
                          keyboardType: TextInputType.text,
                          controller: _descriptionController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return ' Required';
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        MediaSelection(
                          onPressed: selectImages,
                          text: 'Image',
                          icon: Icon(
                            Icons.add_a_photo_outlined,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          child: imagePath != null
                              ? Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(File(imagePath!))),
                                  ),
                                )
                              // Avatar.large(img: FileImage(File(imagePath!)))
                              : Center(
                                  child: Container(
                                    height: 200,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              'https://cytonus.com/wp-content/themes/native/assets/images/no_image_resized_675-450.jpg')),
                                    ),
                                  ),
                                ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ButtonWidget(
                          text: _isLoading
                              ? 'Creating Please Wait ...'
                              : 'Create Station',
                          onPress: () {
                            if (!_isLoading &&
                                _adminBlogPostformKey.currentState!
                                    .validate()) {
                              setState(() {
                                _isLoading = true; // Set loading state to true
                              });

                              // Call the function to reset the password
                              adminBlogPost();

                              // You may remove the Future.delayed block if forgotUserPassword is synchronous.
                              // This block is here to simulate an asynchronous operation.
                              Future.delayed(Duration(seconds: 15), () {
                                // After the simulated operation is complete, reset the loading state
                                setState(() {
                                  _isLoading = false;
                                });
                              });
                            }
                          },
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
