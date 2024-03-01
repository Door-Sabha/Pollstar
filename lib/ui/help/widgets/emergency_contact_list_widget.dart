import 'package:flutter/material.dart';
import 'package:pollstar/ui/help/widgets/emergency_contact_cell.dart';
import 'package:pollstar/utils/extensions.dart';

class EmergencyContactListWidget extends StatelessWidget {
  final String? emergencyNumbers;
  const EmergencyContactListWidget({super.key, required this.emergencyNumbers});

  @override
  Widget build(BuildContext context) {
    late List<String> numbers;
    if (emergencyNumbers.isNullOrEmpty()) {
      numbers = ["-"];
    } else {
      numbers = emergencyNumbers!.split('\n');
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: numbers.length,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) =>
            EmergencyContactCellWidget(phone: numbers[index].trim()),
      ),
    );
  }
}
