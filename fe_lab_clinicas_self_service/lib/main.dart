import 'dart:async';
import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/binding/lab_clinicas_application_binding.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/auth/auth_module.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/home/home_module.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/self_service_module.dart';
import 'package:fe_lab_clinicas_self_service/src/pages/splash_page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

late List<CameraDescription> _cameras;

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();
    runApp(const LabClinicasSelfServicesApp());
  }, (error, stack) {
    log("Error não tratado", error: error, stackTrace: stack);
    throw error;
  });
}

class LabClinicasSelfServicesApp extends StatelessWidget {
  const LabClinicasSelfServicesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LabClinicasCoreConfig(
      title: "Lab clinicas Auto Atendimento",
      bindings: LabClinicasApplicationBinding(),
      pagesBuilder: [
        FlutterGetItPageBuilder(page: (_) => const SplashPage(), path: "/")
      ],
      modules: [AuthModule(), HomeModule(), SelfServiceModule()],
      didStart: () {
        FlutterGetItBindingRegister.registerPermanentBinding(
            "CAMERAS", [Bind.lazySingleton((i) => _cameras)]);
      },
    );
  }
}
