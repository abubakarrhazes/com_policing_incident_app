import 'dart:convert';

import 'package:com_policing_incident_app/utilities/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final Utils utils = Utils();

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess,
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      utils.viewShowDialog(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      utils.viewShowDialog(context, jsonDecode(response.body)['error']);
      break;
    default:
      utils.viewShowDialog(context, response.body);
  }
}
