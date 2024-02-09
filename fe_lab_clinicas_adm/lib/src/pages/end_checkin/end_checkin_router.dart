import 'package:fe_lab_clinicas_adm/src/pages/end_checkin/end_checkin_controller.dart';
import 'package:fe_lab_clinicas_adm/src/pages/end_checkin/end_checkin_page.dart';
import 'package:fe_lab_clinicas_adm/src/services/call_next_patient/call_next_patient_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class EndCheckinRouter extends FlutterGetItPageRouter {
  const EndCheckinRouter({super.key});

  @override
  String get routeName => "/end-checkin";
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton((i) => EndCheckinController(
            callNextPatientService: i<CallNextPatientService>()))
      ];

  @override
  WidgetBuilder get view => (context) => const EndCheckinPage();
}
