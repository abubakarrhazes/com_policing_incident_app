// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:com_policing_incident_app/widgets/my_input_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

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
      var files = await FilePicker.platform
          .pickFiles(type: FileType.image, allowMultiple: true);

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

  Future<List<File>> pickUpAudio() async {
    List<File> images = [];
    try {
      var files = await FilePicker.platform
          .pickFiles(type: FileType.audio, allowMultiple: true);
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
        closeIconColor: Colors.red,
        content: Text(
          message,
          style: TextStyle(color: Colors.red, fontSize: 12),
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
}
