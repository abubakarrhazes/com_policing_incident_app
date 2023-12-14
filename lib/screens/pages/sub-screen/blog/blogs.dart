// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:com_policing_incident_app/providers/features-providers/blog_post_provider.dart';
import 'package:com_policing_incident_app/providers/persistance_data/preferences.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/blog/models/blog_post.dart';
import 'package:com_policing_incident_app/services/config.dart';
import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/utilities/http_error_handling.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog App'),
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
                return Expanded(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                        color: KprimaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          title: Text(
                            snapshot.data!.data![index].title!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            snapshot.data!.data![index].description!,
                          ),
                        ),
                        if (snapshot.data!.data![index].image != null)
                          Image.network('${snapshot.data!.data![index].image}'),
                        // Comment TextField and Button
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: 'Add a comment...',
                                  ),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              ElevatedButton(
                                onPressed: () {
                                  // Implement comment submission logic here
                                  // You may want to send the comment to your API
                                },
                                child: Text('Comment'),
                              ),
                            ],
                          ),
                        ),
                        // Add more UI elements as needed
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
