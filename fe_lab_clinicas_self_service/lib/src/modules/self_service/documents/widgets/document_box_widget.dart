import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';

class DocumentBoxWidget extends StatelessWidget {
  const DocumentBoxWidget(
      {super.key,
      required this.uploaded,
      required this.icon,
      required this.label,
      required this.totalFile,
      this.onTap});
  final bool uploaded;
  final Widget icon;
  final String label;
  final int totalFile;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final totalFilesLabel = totalFile > 0 ? "($totalFile)" : "";
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color:
                  uploaded ? LabClinicasTheme.lightOrangeColor : Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: LabClinicasTheme.orangeColor)),
          child: Column(
            children: [
              Expanded(child: icon),
              Text(
                "$label $totalFilesLabel",
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 14,
                    color: LabClinicasTheme.orangeColor,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}
