// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'dart:io';

import 'package:com_policing_incident_app/providers/persistance_data/preferences.dart';
import 'package:com_policing_incident_app/utilities/global_variables.dart';
import 'package:com_policing_incident_app/widgets/my_input_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Utils {
  void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }

  Future<List<File>> pickUpImage() async {
    List<File> images = [];
    try {
      FilePickerResult? files = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: true,
      );

      if (files != null && files.files.isNotEmpty) {
        List<File> imagesSelected =
            files.paths.map((path) => File(path!)).toList();
        images = imagesSelected;
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return images;
  }

  Future<String> pickImage(ImageSource imageSource) async {
    try {
      final _imagePicker = ImagePicker();
      final _image = await _imagePicker.pickImage(source: imageSource);
      if (_image != null) {
        return _image?.path ?? '';
      }
      print('No Image Selected');
    } catch (e) {
      print(e);
    }
    return '';
  }

  Future<String> pickUpAudio() async {
    try {
      final _files = await FilePicker.platform.pickFiles(
        type: FileType.audio,
      );
      if (_files != null) {
        return _files.toString();
      }
      print('"No Audio Selected');
    } catch (e) {
      debugPrint(e.toString());
    }

    return '';
  }

  Future<List<File>> pickUpVideo() async {
    List<File> images = [];
    try {
      var files = await FilePicker.platform
          .pickFiles(type: FileType.any, allowMultiple: true);
      if (files != null && files.files.isNotEmpty) {
        for (int i = 0; i < files.files.length; i++) {
          images.add(File(files.files[i].path!));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return images;
  }

  Future<List<File>> pickUpMedia() async {
    List<File> images = [];
    try {
      var files = await FilePicker.platform
          .pickFiles(type: FileType.media, allowMultiple: true);
      if (files != null && files.files.isNotEmpty) {
        for (int i = 0; i < files.files.length; i++) {
          images.add(File(files.files[i].path!));
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return images;
  }

//ShowError Dialog
  void showErrorDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void showToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        closeIconColor: Colors.white,
        backgroundColor: Colors.red,
        shape: Border(top: BorderSide()),
        content: Text(
          message,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        action: SnackBarAction(
            label: 'CLOSE', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void successShowToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        closeIconColor: Colors.white,
        backgroundColor: Colors.green,
        shape: Border.all(),
        content: Text(
          message,
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
        action: SnackBarAction(
            label: 'CLOSE', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }

  void viewShowDialog(BuildContext context, String message,
      {bool isSuccess = true}) {
    Color dialogBackgroundColor = isSuccess ? Colors.green : Colors.red;
    Color titleColor = Colors.white;
    Color contentColor = Colors.black;
    Color buttonTextColor = Colors.white;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: dialogBackgroundColor,
          title: Text(
            isSuccess ? 'Success' : 'Error',
            style: TextStyle(color: titleColor),
          ),
          content: Text(
            message,
            style: TextStyle(color: contentColor),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.popAndPushNamed(context, '/login');
              },
              child: Text(
                'OK',
                style: TextStyle(color: buttonTextColor),
              ),
            ),
          ],
        );
      },
    );
  }

  void logOutDialog(
    BuildContext context,
    String message,
  ) {
    Color dialogBackgroundColor = KprimaryColor;
    Color titleColor = Colors.white;
    Color contentColor = Colors.black;
    Color buttonTextColor = Colors.white;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: dialogBackgroundColor,
          title: Text(
            'Sign Out',
            style: TextStyle(color: titleColor),
          ),
          content: Text(
            message,
            style: TextStyle(color: titleColor),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () async {},
                child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: titleColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(child: Text('Yes')))),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: titleColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(child: Text('No')))),
          ],
        );
      },
    );
  }
}
