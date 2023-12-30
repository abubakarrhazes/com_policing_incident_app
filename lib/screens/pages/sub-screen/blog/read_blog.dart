// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
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
            ],
          ),
        ),
      ),
    );
  }
}
