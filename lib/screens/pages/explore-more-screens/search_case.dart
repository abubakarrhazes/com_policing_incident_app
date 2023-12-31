// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:com_policing_incident_app/models/get-models/crime_report.dart';
import 'package:com_policing_incident_app/providers/persistance_data/preferences.dart';
import 'package:com_policing_incident_app/screens/pages/explore-more-screens/search_model.dart';
import 'package:com_policing_incident_app/screens/pages/sub-screen/report_crime/crime_detail_page.dart';
import 'package:com_policing_incident_app/services/config.dart';
import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/widgets/my_input_field.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SearchCase extends StatefulWidget {
  const SearchCase({Key? key}) : super(key: key);

  @override
  State<SearchCase> createState() => _SearchCaseState();
}

class _SearchCaseState extends State<SearchCase> {
  final searchController = TextEditingController();
  final _searchFormKey = GlobalKey<FormState>();
  bool _isLoading = false;
  Future<SearchModel>? _searchResult;
  SearchModel? crime;

  Future<SearchModel> searchReportReference() async {
    final requestBaseUrl = Config.AuthBaseUrl;
    final preferences = await Preferences.getInstance();
    String? token = await preferences.getAccessToken();
    String? userId = await preferences.getUserId();

    final requestHeaders = {
      'Accept': 'application/vnd.api+json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    try {
      String url =
          '$requestBaseUrl/user/$userId/reports/${searchController.text}';
      print('Url $url');
      final response = await http.get(Uri.parse(url), headers: requestHeaders);

      if (response.statusCode == 200) {
        return SearchModel.fromJson(json.decode(response.body));
      } else {
        final errorMessage = json.decode(response.body)['message'];
        throw Exception(
            'Failed to load police ${response.statusCode} error $errorMessage');
      }
    } on SocketException catch (_) {
      throw Exception('No internet connection');
    } on TimeoutException catch (_) {
      throw Exception('Request timed out');
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Form(
              key: _searchFormKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Enter Reference Number Here'),
                    MyInputField(
                      controller: searchController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Reference is Required';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),
                    Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: KprimaryColor, // Set the desired color
                        borderRadius: BorderRadius.circular(
                            8), // Optional: Add borderRadius for rounded corners
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (!_isLoading &&
                              _searchFormKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                              _searchResult = searchReportReference();
                            });

                            _searchResult!.then((result) {
                              setState(() {
                                _isLoading = false;
                              });
                            }).catchError((error) {
                              print('Error: $error');
                              setState(() {
                                _isLoading = false;
                              });
                            });
                          }
                        },
                        child: Text(
                          _isLoading ? 'Searching, Please Wait...' : 'Search',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .transparent, // Make the button background transparent
                          elevation: 0, // Remove the button elevation
                          textStyle: TextStyle(
                              color: Colors.white), // Set text color to white
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: _searchResult != null
                  ? FutureBuilder<SearchModel>(
                      future: _searchResult!,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: KprimaryColor,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(10),
                                  topLeft: Radius.circular(10)),
                            ),
                            child: ListTile(
                              onTap: () {},
                              title: Text(
                                'Category: ${snapshot.data!.data.category} ',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                              subtitle: Text(
                                'Reference Number: ${snapshot.data!.data.ref}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          );
                        }
                      },
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}

class CrimeListItem extends StatelessWidget {
  final CrimeData data;

  const CrimeListItem({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Container(
        decoration: BoxDecoration(
          color: KprimaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CrimeDetailPage(crimeData: data),
              ),
            );
          },
          title: Text(
            'Category: ${data.category} ',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
          subtitle: Text(
            'Reference Number: ${data.ref}',
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
