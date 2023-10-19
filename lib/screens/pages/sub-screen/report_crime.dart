// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field

import 'dart:io';

import 'package:com_policing_incident_app/services/auth_services.dart';
import 'package:com_policing_incident_app/models/report_crime_model.dart';
import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/utilities/http_error_handling.dart';
import 'package:com_policing_incident_app/widgets/button_widget.dart';
import 'package:com_policing_incident_app/widgets/media_selection.dart';
import 'package:com_policing_incident_app/widgets/my_input_field.dart';
import 'package:flutter/material.dart';

class ReportCrime extends StatefulWidget {
  ReportCrime({super.key});

  @override
  State<ReportCrime> createState() => _ReportCrimeState();
}

class _ReportCrimeState extends State<ReportCrime> {
  final TextEditingController _detailsController = TextEditingController();
  String categories = 'Homocide';
  String stations = 'Unguwar Rogo Police Division,Sokoto';

  List<File> images = [];
  List<File> audio = [];
  List<File> video = [];
  List<File> media = [];

  List<String> crimeCategories = [
    'Homocide',
    'Robbery',
    'Sexual Assault and Rape',
    'Domestic Violence',
    'Kidnapping',
    'Reckless Driving',
    'Online Fraud',
    'Motor Vehicle Theft',
    'Arson',
    'Ritual Killings',
    'Drug Trafficking / Possession',
    'Cultism',
  ];

  List<String> policeStations = [
    'Unguwar Rogo Police Division,Sokoto',
    'Dan Marina Police Division,Sokoto',
    'Dadin Kowa Police Division,Sokoto',
  ];

  void selectImages() async {
    var imageResponse = await utils.pickUpImage();
    setState(() {
      images = imageResponse;
    });
  }

  void selectAudio() async {
    var audioResponse = await utils.pickUpAudio();
    setState(() {
      audio = audioResponse;
    });
  }

  void selectVideo() async {
    var videoResponse = await utils.pickUpVideo();
    setState(() {
      video = videoResponse;
    });
  }

  void selectMedia() async {
    var mediaResponse = await utils.pickUpMedia();
    setState(() {
      media = mediaResponse;
    });
  }

  void reportCrime() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(children: [
          Center(
            child: Text(
              'Report Crime',
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
                  SizedBox(
                    child: Column(
                      children: [
                        DropdownButton(
                          value: categories,
                          items: crimeCategories.map((String item) {
                            return DropdownMenuItem(
                                value: item, child: Text(item));
                          }).toList(),
                          onChanged: (String? newval) {
                            setState(() {
                              categories = newval!;
                            });
                          },
                        ),
                      ],
                    ),
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
                    min: 1,
                    max: 200,
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
                        onPressed: () {
                          selectImages();
                        },
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
                        onPressed: () {
                          selectVideo();
                        },
                        text: 'Add Video',
                        icon: Icon(
                          Icons.video_file,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      MediaSelection(
                        onPressed: () {
                          selectAudio();
                        },
                        text: 'Add Audio',
                        icon: Icon(
                          Icons.audio_file_outlined,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      MediaSelection(
                        onPressed: () {
                          selectMedia();
                        },
                        text: 'Add File',
                        icon: Icon(
                          Icons.file_upload_rounded,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Location',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Select Police Station',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    child: Column(
                      children: [
                        DropdownButton(
                          value: stations,
                          items: policeStations.map((String item) {
                            return DropdownMenuItem(
                                value: item, child: Text(item));
                          }).toList(),
                          onChanged: (String? newval) {
                            setState(() {
                              stations = newval!;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
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
