// ignore_for_file: prefer_const_constructors, unused_field, curly_braces_in_flow_control_structures

import 'package:com_policing_incident_app/models/user.dart';
import 'package:com_policing_incident_app/providers/auth_provider.dart';
import 'package:com_policing_incident_app/screens/onboard_screen/onboard.dart';
import 'package:com_policing_incident_app/screens/register_screen/models/register_model.dart';

import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/widgets/button_widget.dart';
import 'package:com_policing_incident_app/widgets/my_input_field.dart';
import 'package:flutter/material.dart';

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
  final bool isLoading = false;
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

  void registerUser() {
    authProvider.registerUser(
        RegisterModel(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            otherName: _otherNameController.text,
            email: _emailNameController.text,
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
          SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height / 4,
            child: Image.asset('assets/images/login.png'),
          ),
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
                            MyInputField(
                              hintText: 'Firsname',
                              controller: _firstNameController,
                            ),
                            const SizedBox(height: 15),
                            MyInputField(
                              hintText: 'Lastname',
                              controller: _lastNameController,
                            ),
                            const SizedBox(height: 15),
                            MyInputField(
                              hintText: 'Othername',
                              controller: _otherNameController,
                            ),
                            const SizedBox(height: 15),
                            MyInputField(
                              hintText: 'Email',
                              keyboardType: TextInputType.emailAddress,
                              controller: _emailNameController,
                            ),
                            const SizedBox(height: 15),
                            MyInputField(
                              hintText: 'Phone',
                              keyboardType: TextInputType.phone,
                              controller: _phoneNumberController,
                            ),
                            const SizedBox(height: 15),
                            MyInputField(
                                hintText: 'Date Of Birth',
                                keyboardType: TextInputType.datetime,
                                onTap: () {
                                  _selectDate(context).toString();
                                },
                                controller: _dateOfBithController),
                            const SizedBox(height: 15),
                            MyInputField(
                              hintText: 'State',
                              keyboardType: TextInputType.text,
                              controller: _stateController,
                            ),
                            const SizedBox(height: 15),
                            MyInputField(
                              hintText: 'Occupation',
                              keyboardType: TextInputType.text,
                              controller: _occupationController,
                            ),
                            const SizedBox(height: 15),
                            MyInputField(
                              hintText: 'Address',
                              keyboardType: TextInputType.text,
                              controller: _addressController,
                            ),
                            const SizedBox(height: 15),
                            MyInputField(
                              hintText: 'Password',
                              isPassword: true,
                              keyboardType: TextInputType.visiblePassword,
                              controller: _passwordController,
                            ),
                            const SizedBox(height: 20),
                            ButtonWidget(
                              onPress: () {
                                //Registration Function Call Here
                                if (_registerformKey.currentState!.validate()) {
                                  registerUser();
                                }
                              },
                              text: 'Create Account',
                            )
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
