import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/self_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SelfServicePage extends StatefulWidget {
  const SelfServicePage({super.key});

  @override
  State<SelfServicePage> createState() => _SelfServicePageState();
}

class _SelfServicePageState extends State<SelfServicePage>
    with MessagesViewMixin {
  final controller = Injector.get<SelfServiceController>();
  @override
  void initState() {
    super.initState();
    messageListener(controller);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.startProcess();
      effect(() {
        var baseRouter = "/self-service/";
        final step = controller.step;
        switch (step) {
          case FormSteps.none:
            return;
          case FormSteps.whoIAm:
            baseRouter += "whoIAm";
          case FormSteps.findPatient:
            baseRouter += "find-patient";
          case FormSteps.patient:
            baseRouter += "patient";
          case FormSteps.documents:
            baseRouter += "documents";
          case FormSteps.done:
            baseRouter += "done";
          case FormSteps.restart:
            Navigator.of(context)
                .popUntil(ModalRoute.withName("/self-service"));
            controller.startProcess();
            return;
        }
        Navigator.pushNamed(context, baseRouter);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('self-services'),
      ),
      body: Container(),
    );
  }
}
