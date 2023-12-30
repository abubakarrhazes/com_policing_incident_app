// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class HelpDesk extends StatefulWidget {
  const HelpDesk({super.key});

  @override
  State<HelpDesk> createState() => _HelpDeskState();
}

class _HelpDeskState extends State<HelpDesk> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Center(
              child: Image.network(
                'https://cdn-icons-png.flaticon.com/512/4961/4961759.png',
                height: 250,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text('npf.com.cop@gmail.com')
          ],
        ),
      ),
    );
  }
}
