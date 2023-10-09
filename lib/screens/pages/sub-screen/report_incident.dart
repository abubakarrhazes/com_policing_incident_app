// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/widgets/button_widget.dart';
import 'package:com_policing_incident_app/widgets/media_selection.dart';
import 'package:com_policing_incident_app/widgets/my_input_field.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Center(
            child: Text(
              'Report an incident',
              style: TextStyle(
                color: KprimaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Crime Category',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  MyInputField(
                    hintText: 'Select Crime Category',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Details',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  MyInputField(
                    hintText: 'Briefly Decribe about the crime',
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Attach Media (Optional)',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MediaSelection(
                        text: 'Add Image',
                        icon: Icon(
                          Icons.add_a_photo_outlined,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      MediaSelection(
                        text: 'Add Image',
                        icon: Icon(
                          Icons.video_file,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      MediaSelection(
                        text: 'Add Image',
                        icon: Icon(
                          Icons.audio_file_outlined,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      MediaSelection(
                        text: 'Add Image',
                        icon: Icon(
                          Icons.file_upload_rounded,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Text('Location'),
                  SizedBox(
                    height: 20,
                  ),
                  ButtonWidget(text: 'Send Report', onPress: () {})
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
