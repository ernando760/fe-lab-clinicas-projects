import 'package:fe_lab_clinicas_adm/src/models/patient_information_form_model.dart';
import 'package:fe_lab_clinicas_adm/src/pages/checkin/checkin_controller.dart';
import 'package:fe_lab_clinicas_adm/src/pages/checkin/checkin_page.dart';
import 'package:fe_lab_clinicas_adm/src/repositories/patient_information_form/patient_information_form_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class CheckinRouter extends FlutterGetItPageRouter {
  const CheckinRouter({super.key});

  @override
  String get routeName => "/checkin";
  @override
  List<Bind<Object>> get bindings => [
        Bind.lazySingleton((i) => CheckinController(
            informationFormRepository: i<PatientInformationFormRepository>()))
      ];

  @override
  WidgetBuilder get view => (context) {
        final form = ModalRoute.of(context)!.settings.arguments
            as PatientInformationFormModel;
        context.get<CheckinController>().informationForm.value = form;
        return const CheckinPage();
      };
}
