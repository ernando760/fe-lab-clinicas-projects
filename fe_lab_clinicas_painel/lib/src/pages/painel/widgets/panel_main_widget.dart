import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';

class PanelMainWidget extends StatelessWidget {
  const PanelMainWidget(
      {super.key,
      required this.label,
      required this.password,
      required this.deskNumber,
      required this.labelColor,
      required this.buttonColor});

  final String label;
  final String password;
  final String deskNumber;

  final Color labelColor;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: LabClinicasTheme.orangeColor),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: LabClinicasTheme.titleStyle.copyWith(color: labelColor),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              password,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "Guichê",
            style: LabClinicasTheme.titleStyle.copyWith(color: labelColor),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Text(
              deskNumber,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
