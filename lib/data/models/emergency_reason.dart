// ignore_for_file: empty_constructor_bodies

import 'package:pollstar/ui/widgets/dropdowns.dart';

class EmergencyReason implements MyDropDownButtonItem {
  String reason;
  String type;
  EmergencyReason({required this.reason, required this.type});

  @override
  String getDisplayName() {
    return reason;
  }

  @override
  String getType() {
    return type;
  }
}
