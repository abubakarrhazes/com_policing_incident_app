// ignore_for_file: prefer_const_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'dart:convert';

import 'package:com_policing_incident_app/models/user.dart';
import 'package:com_policing_incident_app/providers/features-providers/blog_post_provider.dart';
import 'package:com_policing_incident_app/providers/persistance_data/preferences.dart';
import 'package:com_policing_incident_app/providers/persistance_data/user_adapter.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/blog/models/blog_post.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/blog/read_blog.dart';
import 'package:com_policing_incident_app/services/config.dart';
import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/utilities/http_error_handling.dart';
import 'package:com_policing_incident_app/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Blogs extends StatefulWidget {
  const Blogs({super.key});

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  final BlogPostProvider blogPostProvider = BlogPostProvider();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userAdapter = Provider.of<UserAdapter>(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text('Blog and Announcement'),
      ),
      body: FutureBuilder<BlogPost>(
        future: blogPostProvider.getBlogById(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ReadBlog(dataPost: snapshot.data!.data![index]),
                      ),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Avatar.medium(
                                img: NetworkImage(
                                    '${userAdapter.user!.profilePicture}'),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                '${userAdapter.user!.firstName} ${userAdapter.user!.lastName} ${userAdapter.user!.otherName}',
                                style: TextStyle(
                                    color: KprimaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data!.data![index].title!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            snapshot.data!.data![index].description!,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        if (snapshot.data!.data![index].image != null)
                          Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              image: DecorationImage(
                                image: NetworkImage(
                                    '${snapshot.data!.data![index].image}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        SizedBox(
                          height: 15,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.date_range_rounded),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Date Posted :',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                  '${snapshot.data!.data![index].createdAt!.substring(0, 10)}',
                                  style: TextStyle(
                                      color: KprimaryColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold))
                            ],
                          ),
                        ),
                        // Custom Comment Field
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
