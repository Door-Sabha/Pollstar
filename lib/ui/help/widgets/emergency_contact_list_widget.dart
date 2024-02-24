import 'package:flutter/material.dart';
import 'package:pollstar/ui/help/widgets/emergency_contact_cell.dart';

class EmergencyContactListWidget extends StatelessWidget {
  const EmergencyContactListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: 3,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) => const EmergencyContactCellWidget(),
      ),
    );
  }
}
