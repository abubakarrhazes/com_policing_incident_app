// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, avoid_unnecessary_containers, empty_catches

import 'dart:convert';
import 'dart:io';

import 'package:com_policing_incident_app/models/police_station.dart';
import 'package:com_policing_incident_app/models/report_crime_model.dart';
import 'package:com_policing_incident_app/providers/features-providers/report_crime_provider.dart';
import 'package:com_policing_incident_app/providers/persistance_data/preferences.dart';
import 'package:com_policing_incident_app/providers/persistance_data/user_adapter.dart';
import 'package:com_policing_incident_app/services/config.dart';
import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/utilities/http_error_handling.dart';
import 'package:com_policing_incident_app/widgets/avatar.dart';
import 'package:com_policing_incident_app/widgets/button_widget.dart';
import 'package:com_policing_incident_app/widgets/media_selection.dart';
import 'package:com_policing_incident_app/widgets/my_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ReportCrime extends StatefulWidget {
  ReportCrime({super.key});

  @override
  State<ReportCrime> createState() => _ReportCrimeState();
}

class _ReportCrimeState extends State<ReportCrime> {
  final TextEditingController _detailsController = TextEditingController();
  final ReportCrimeProvider reportCrimeProvider = ReportCrimeProvider();
  final requestBaseUrl = Config.AuthBaseUrl;
  double latitude = 0.0;
  double logitude = 0.0;
  String address = '';
  String categories = 'Homocide';
  String? path;

  List<String> imagesPath = [];
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

  String? selectedStation;
  List<PoliceStation> policeStations = [];

  @override
  void initState() {
    super.initState();
    // Fetch data when the widget is first created
    fetchData();
  }

  Future<List<PoliceStation>?> fetchData() async {
    final preferences = await Preferences.getInstance();
    final token = preferences.getAccessToken();

    print('JWT Token $token');

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    try {
      String url = '$requestBaseUrl/station';
      final response = await http.get(Uri.parse(url), headers: requestHeaders);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        print(data);
        //return data.map((json) => PoliceStation.fromJson(json)).toList();
        setState(() {
          policeStations =
              data.map((json) => PoliceStation.fromJson(json)).toList();
        });
      } else {
        final errorMessage = json.decode(response.body)['message'];
        throw Exception(
            'Failed to load police stations  ${response.statusCode} error ${errorMessage}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return null;

    // ignore: dead_code
  }

  void selectImages() async {
    final pathFolder = await utils.pickImage(ImageSource.gallery);

    setState(() {
      path = pathFolder;
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

  //Get User Location

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

  //APi Connecting To The Model Fromtend and Backend

  void reportCrime() {
    reportCrimeProvider.reportCrime(
        ReportCrimeModel(
          category: categories,
          details: _detailsController.text,
          file: [imagesPath, audio, video, address],
          policeUnit: selectedStation!,
          location: UserLocationData(latitude: latitude, logitude: logitude),
        ),
        context);

    print(selectedStation);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
          SingleChildScrollView(
            child: Container(
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
                          onPressed: selectImages,
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
                      child: path != null
                          ? Container(
                              height: 200,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: FileImage(File(path!)),
                                ),
                              ),
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
                                Text('Location'),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Location : $address')
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
                    SingleChildScrollView(
                      child: SizedBox(
                        child: Column(
                          children: [
                            DropdownButton(
                              value: selectedStation,
                              items:
                                  policeStations.map((PoliceStation station) {
                                return DropdownMenuItem(
                                  value: station.id,
                                  child: Text(station.name),
                                );
                              }).toList(),
                              onChanged: (String? newval) {
                                setState(() {
                                  selectedStation = newval;
                                });
                              },
                              hint: Text('Select a Police Station'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ButtonWidget(
                        text: 'Send Report',
                        onPress: () {
                          reportCrime();
                        })
                  ],
                ),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
