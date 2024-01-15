// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_field, avoid_unnecessary_containers, empty_catches, use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:com_policing_incident_app/models/get-models/crime_report.dart';
import 'package:com_policing_incident_app/models/police_station.dart';

import 'package:com_policing_incident_app/models/report_incident_model.dart';
import 'package:com_policing_incident_app/providers/features-providers/report_crime_provider.dart';
import 'package:com_policing_incident_app/providers/persistance_data/preferences.dart';
import 'package:com_policing_incident_app/providers/persistance_data/user_adapter.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/blog/models/blog_post.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/report_crime/model/report_crime_model.dart';
import 'package:com_policing_incident_app/services/config.dart';
import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/utilities/http_error_handling.dart';
import 'package:com_policing_incident_app/widgets/avatar.dart';
import 'package:com_policing_incident_app/widgets/button_widget.dart';
import 'package:com_policing_incident_app/widgets/media_selection.dart';
import 'package:com_policing_incident_app/widgets/my_input_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class ReportCrime extends StatefulWidget {
  ReportCrime({super.key});

  @override
  State<ReportCrime> createState() => _ReportCrimeState();
}

class _ReportCrimeState extends State<ReportCrime> {
  final TextEditingController _detailsController = TextEditingController();
  final ReportCrimeProvider reportCrimeProvider = ReportCrimeProvider();
  final _reportformKey = GlobalKey<FormState>();
  final requestBaseUrl = Config.AuthBaseUrl;
  bool _isLoading = false;
  double latitude = 0.0;
  double logitude = 0.0;
  String address = '';
  String categories = 'Homocide';
  bool isLoading = false;

  String? imagePath;
  String? audioPath;
  String? videoPath;
  String? filePath;

  VideoPlayerController? _videoController;
  String? _imageFile;
  bool isImageSelected = false;

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
    String? token = await preferences.getAccessToken();

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
      print(error);
    }
    return null;

    // ignore: dead_code
  }

  void selectImages() async {
    final path = await utils.pickImage(ImageSource.gallery);

    setState(() {
      imagePath = path;
    });
  }

  void selectAudio(var audioSelect) async {
    await utils.pickUpAudio();
    setState(() {
      audioPath = audioSelect;
    });
  }

  void selectVideo(var videoResponse) async {
    await utils.pickUpVideo();
    setState(() {
      videoPath = videoResponse;
    });
  }

  void selectMedia(var mediaResponse) async {
    await utils.pickUpMedia();
    setState(() {
      filePath = mediaResponse;
    });
  }

  //Get User Location

  /*

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
  */
  void _getCurrentLocation() async {
    try {
      // Set loading to true when starting the location retrieval process
      setState(() {
        isLoading = true;
      });

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Update the state with the retrieved latitude and longitude
      setState(() {
        latitude = position.latitude;
        logitude = position.longitude;
      });

      // Getting the actual Address Of The Longitude and Latitude
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, logitude);
      Placemark place = placemarks[0];

      // Update the state with the retrieved address
      setState(() {
        address = "${place.street}, ${place.locality}  ${place.country}";
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
    } finally {
      // Set loading to false when the location retrieval process is complete
      setState(() {
        isLoading = false;
      });
    }
  }

  //APi Connecting To The Model Fromtend and Backend

  void reportCrime() {
    if (selectedStation != null) {
      reportCrimeProvider.reportCrimeWithFiles(
        CrimeData(
          category: categories,
          details: _detailsController.text,
          image: imagePath,
          audio: audioPath,
          video: videoPath,
          file: filePath,
          location: UserLocation(
              latitude: latitude.toString(), logitude: latitude.toString()),
          address: address,
          policeUnit: selectedStation!,
        ),
        context,
      );
      print(selectedStation);
      print(latitude);
      print(logitude);
      print(address);
      print(imagePath);
    } else {
      // Handle the case where selectedStation is null
      print('selectedStation is null');
    }
  }

  /*

  void reportCrime() {
    reportCrimeProvider.reportCrimeWithFiles(
        CrimeData(
          category: categories,
          details: _detailsController.text,
          photo: imagesPath,
          video: videoPath,
          audio: audioPath,
          file: filePath,
          policeUnit: selectedStation!,
          location: UserLocation(
              latitude: latitude.toString(), // replace with actual latitude
              logitude: logitude.toString() // replace with actual longitude
              ),
        ),
        context);

    print(selectedStation);
  }
  */

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
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
                  key: _reportformKey,
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
                              Icons.ac_unit,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          MediaSelection(
                            onPressed: () {
                              selectVideo(videoPath);
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
                              selectAudio(audioPath);
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
                              selectMedia(filePath);
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
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: KprimaryColor),
                        ),
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
                            : Center(
                                child: Container(
                                  height: 200,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            'https://cytonus.com/wp-content/themes/native/assets/images/no_image_resized_675-450.jpg')),
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
                                  Icon(Icons.location_on,
                                      size: 25,
                                      color:
                                          KprimaryColor // Replace with your desired color
                                      ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    isLoading
                                        ? 'Fetching Location ....'
                                        : 'Location',
                                    style: TextStyle(fontSize: 15),
                                  ),
                                  if (isLoading)
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: KprimaryColor,
                                        ),
                                      ), // Loading indicator
                                    ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                            child: Text('Location : $address'),
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
                        text: _isLoading
                            ? 'Reporting Please Wait ...'
                            : 'Report Crime',
                        onPress: () {
                          if (!_isLoading &&
                              _reportformKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true; // Set loading state to true
                            });

                            reportCrime(); // Call the function to reset the password

                            // You may remove the Future.delayed block if forgotUserPassword is synchronous.
                            // This block is here to simulate an asynchronous operation.
                            Future.delayed(Duration(seconds: 10), () {
                              // After the simulated operation is complete, reset the loading state
                              setState(() {
                                _isLoading = false;
                              });
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
