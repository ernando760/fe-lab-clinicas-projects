import 'package:fe_lab_clinicas_adm/src/pages/home/home_controller.dart';
import 'package:fe_lab_clinicas_adm/src/pages/home/home_page.dart';
import 'package:fe_lab_clinicas_adm/src/repositories/attendant_desk_assignment/attendant_desk_assignment_repository.dart';

import 'package:fe_lab_clinicas_adm/src/services/call_next_patient/call_next_patient_service.dart';

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class HomeRouter extends FlutterGetItPageRouter {
  const HomeRouter({super.key});

  @override
  String get routeName => "/home";

  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton((i) => HomeController(
            attendantDeskAssignmentRepository:
                i<AttendantDeskAssignmentRepository>(),
            callNextPatientService: i<CallNextPatientService>()))
      ];

  @override
  WidgetBuilder get view => (context) => const HomePage();
}
