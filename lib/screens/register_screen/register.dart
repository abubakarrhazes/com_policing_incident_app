// ignore_for_file: prefer_const_constructors, unused_field, curly_braces_in_flow_control_structures, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sort_child_properties_last, non_constant_identifier_names

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:com_policing_incident_app/models/user.dart';
import 'package:com_policing_incident_app/providers/auth_provider.dart';
import 'package:com_policing_incident_app/screens/onboard_screen/onboard.dart';
import 'package:com_policing_incident_app/screens/register_screen/models/register_model.dart';

import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/utilities/http_error_handling.dart';
import 'package:com_policing_incident_app/widgets/avatar.dart';
import 'package:com_policing_incident_app/widgets/button_widget.dart';
import 'package:com_policing_incident_app/widgets/my_input_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const MaterialColor black = MaterialColor(
  0xFF000000,
  <int, Color>{
    50: Color(0xFFEEEEEE),
    100: Color(0xFFBBBBBB),
    200: Color(0xFF999999),
    300: Color(0xFF555555),
    400: Color(0xFF333333),
    500: Color(0xFF000000),
    600: Color(0xFF000000),
    700: Color(0xFF000000),
    800: Color(0xFF000000),
    900: Color(0xFF000000),
  },
);

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _registerformKey = GlobalKey<FormState>();
  bool _isLoading = false;
  final formResult = {};
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _otherNameController = TextEditingController();
  final TextEditingController _emailNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();

  final TextEditingController _dateOfBithController = TextEditingController();

  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthProvider authProvider = AuthProvider();
  DateTime selectedDate = DateTime.now();

  String? imagePath;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      _dateOfBithController.text =
          selectedDate.toLocal().toString().split(' ')[0];
    }
  }

  void selectImages() async {
    final path = await utils.pickImage(ImageSource.gallery);

    setState(() {
      imagePath = path;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _otherNameController.dispose();
    _emailNameController.dispose();
    _phoneNumberController.dispose();
    _dateOfBithController.dispose();
    _stateController.dispose();
    _occupationController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  registerUser() {
    authProvider.registerUser(
        RegisterModel(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            otherName: _otherNameController.text,
            email: _emailNameController.text,
            profilePicture: imagePath ?? '',
            phoneNumber: _phoneNumberController.text,
            DOB: _dateOfBithController.text,
            state: _stateController.text,
            occupation: _occupationController.text,
            address: _addressController.text,
            password: _passwordController.text),
        context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F3F3),
      body: SafeArea(
          child: ListView(
        children: [
          Card(
            margin: const EdgeInsets.only(left: 22, right: 22),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            child: Theme(
              data: ThemeData(primarySwatch: black),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    const Text(
                      'Create an Account',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w800,
                          color: KprimaryColor),
                    ),
                    const SizedBox(height: 8),
                    Form(
                        key: _registerformKey,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                imagePath != null
                                    ? Avatar.large(
                                        img: FileImage(File(imagePath!)))
                                    : Avatar.large(
                                        img: NetworkImage(
                                            'https://img.freepik.com/free-vector/illustration-businessman_53876-5856.jpg?w=826&t=st=1700222239~exp=1700222839~hmac=5ce3ad75c38b8cbd3d394d9f4ed41b0481a6494c824a24c9e98cdb8f41071f44')),
                                Positioned(
                                  child: IconButton(
                                    onPressed: selectImages,
                                    icon: Icon(
                                      Icons.add_a_photo,
                                      color: KprimaryColor,
                                    ),
                                  ),
                                  bottom: -13,
                                  left: 70,
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            MyInputField(
                              hintText: 'Firsname',
                              controller: _firstNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'FirstName Required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            MyInputField(
                              hintText: 'Lastname',
                              controller: _lastNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'LastName Required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            MyInputField(
                              hintText: 'Othername',
                              controller: _otherNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'OtherName Required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            MyInputField(
                                hintText: 'Email',
                                keyboardType: TextInputType.emailAddress,
                                controller: _emailNameController,
                                validator: (value) {
                                  RegExp emailRegExp = RegExp(
                                      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");

                                  if (value == null || value.isEmpty) {
                                    return 'Email can\'t be empty';
                                  } else if (!emailRegExp.hasMatch(value)) {
                                    return 'Enter a correct email';
                                  }
                                  return null;
                                }),
                            const SizedBox(height: 15),
                            MyInputField(
                              hintText: 'Phone',
                              keyboardType: TextInputType.phone,
                              controller: _phoneNumberController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Phone Required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            MyInputField(
                                hintText: 'Date Of Birth',
                                keyboardType: TextInputType.datetime,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Date Of Birth Required';
                                  }
                                  return null;
                                },
                                onTap: () {
                                  _selectDate(context).toString();
                                },
                                controller: _dateOfBithController),
                            const SizedBox(height: 15),
                            MyInputField(
                              hintText: 'State',
                              keyboardType: TextInputType.text,
                              controller: _stateController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'State Required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            MyInputField(
                              hintText: 'Occupation',
                              keyboardType: TextInputType.text,
                              controller: _occupationController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Occupation Required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            MyInputField(
                              hintText: 'Address',
                              keyboardType: TextInputType.text,
                              controller: _addressController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Address Required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 15),
                            MyInputField(
                              hintText: 'Password',
                              isPassword: true,
                              keyboardType: TextInputType.visiblePassword,
                              controller: _passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password Required';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 20),
                            ButtonWidget(
                              onPress: () async {
                                // Registration Function Call Here
                                if (_registerformKey.currentState!.validate()) {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  registerUser();
                                  // Set loading back to false when registration is complete
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              },
                              text: 'Create Account',
                            ),

                            // Display a loading indicator while `_isLoading` is true
                            if (_isLoading)
                              CircularProgressIndicator(
                                color: KprimaryColor,
                              ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding:
                const EdgeInsets.only(top: 24, bottom: 16, left: 8, right: 8),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(' Already  have an account? '),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, routes.login);
                      },
                      child: Text(
                        'Login Here',
                        style: TextStyle(
                            color: KprimaryColor, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      )),
    );
  }
}
