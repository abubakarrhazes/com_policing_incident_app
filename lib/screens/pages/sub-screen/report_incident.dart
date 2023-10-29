// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/utilities/http_error_handling.dart';
import 'package:com_policing_incident_app/widgets/button_widget.dart';
import 'package:com_policing_incident_app/widgets/media_selection.dart';
import 'package:com_policing_incident_app/widgets/my_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final TextEditingController _detailsController = TextEditingController();
  double latitude = 0.0;
  double logitude = 0.0;
  String address = '';
  String categories = 'Homocide';
  String stations = 'zaria police station';

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
    'zaria police station',
    'Dan Marina Police Division,Sokoto',
    'Dadin Kowa Police Division,Sokoto',
  ];

  void selectImages(var imageResponse) async {
    await utils.pickUpImage();
    setState(() {
      images = imageResponse;
    });
  }

  void selectAudio(var audioSelect) async {
    await utils.pickUpAudio();
    setState(() {
      audio = audioSelect;
    });
  }

  void selectVideo(var videoResponse) async {
    await utils.pickUpVideo();
    setState(() {
      video = videoResponse;
    });
  }

  void selectMedia(var mediaResponse) async {
    await utils.pickUpMedia();
    setState(() {
      media = mediaResponse;
    });
  }

  //Getting User Location Data

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        latitude = position.latitude;
        logitude = position.longitude;
        //_currentLocation = 'Latitude: $latitude, Longitude: $longitude';
      });
      // Getting the actual Address Of The Longitude and Latitude
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, logitude);
      Placemark place = placemarks[0];

      setState(() {
        address = " ${place.street}, ${place.locality}  ${place.country}";
      });
    } on PlatformException catch (e) {
      if (e.code == 'IO_ERROR') {
        print('Network error occurred: ${e.message}');
        // Handle the network error appropriately
      } else {
        // Handle other platform exceptions
      }
    } catch (e) {
      print('An error occurred: $e');
      // Handle other errors
    }
  }

  //API CONNECTING TO THE MODEL FRONTEND AND BACKEND

  void reportCrime() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                    'Select Incident Category',
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
                    height: 5,
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
                    controller: _detailsController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Description is  Required';
                      }
                      return null;
                    },
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
                          selectImages(images);
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
                          selectVideo(video);
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
                          selectAudio(audio);
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
                          selectMedia(media);
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
                  Container(
                    width: 200,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: KprimaryColor),
                    ),
                    child: images.isNotEmpty
                        ? ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: images.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.all(5),
                                child: Image.file(
                                  images[index],
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              'No Media Selected',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text('Location'),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => _getCurrentLocation(),
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 25,
                                color: KprimaryColor,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text('Location : $address')
                            ],
                          ),
                        ),
                      ),
                    ],
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
