// ignore_for_file: empty_constructor_bodies

import 'package:pollstar/ui/home/widgets/dropdowns.dart';

class EmergencyReason implements MyDropDownButtonItem {
  String reason;
  EmergencyReason({required this.reason});

  @override
  String getDisplayName() {
    return reason;
  }
}
