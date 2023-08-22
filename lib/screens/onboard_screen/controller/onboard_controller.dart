import 'package:com_policing_incident_app/screens/onboard_screen/model/onboard_model.dart';

class OnboardController {
  List<OnboardModel> screens = [
    OnboardModel('assets/images/image_1.png', 'Report Crime On The Go ',
        'Have Access to Full Justice Support'),
    OnboardModel(
        'assets/images/civil-right.png',
        'Send an SOS for an Emergency',
        'Send an SOS for Emergency To alert the police units and Emergency Contacts'),
    OnboardModel(
        'assets/images/image_2.png',
        'Have Access To Limited Security Features',
        'Locate The nearest police in your community if you feel unsafe'),
  ];
}
