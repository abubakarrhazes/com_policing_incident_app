import 'package:com_policing_incident_app/screens/onboard_screen/model/onboard_model.dart';

class OnboardController {
  List<OnboardModel> screens = [
    OnboardModel(
        'assets/images/com_1.png',
        'Report Crime and Incident On The Go ',
        'Report Crime Within Your Location and serve as an Eye Witness'),
    OnboardModel('assets/images/com_2.png', 'Send an SOS for an Emergency',
        'Send an SOS for Emergency To alert the police units and Emergency Contacts'),
    OnboardModel(
        'assets/images/com_3.png',
        'Have Access To Limited Security Features',
        'Locate The nearest police in your community if you feel unsafe'),
  ];
}
