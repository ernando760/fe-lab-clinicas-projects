import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/self_service_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class DonePage extends StatelessWidget {
  final selfServicesController = Injector.get<SelfServiceController>();
  DonePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            width: sizeOf.width * .85,
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: LabClinicasTheme.orangeColor)),
            child: Column(
              children: [
                Image.asset('assets/images/stroke_check.png'),
                const SizedBox(height: 20),
                const Text("SUA SENHA É",
                    style: LabClinicasTheme.titleSmallStyle),
                const SizedBox(height: 24),
                Container(
                  constraints: const BoxConstraints(
                    minWidth: 218,
                    minHeight: 48,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                      color: LabClinicasTheme.orangeColor,
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    selfServicesController.password,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 40),
                const Text.rich(
                  TextSpan(
                      style: TextStyle(
                          color: LabClinicasTheme.blueColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(text: "AGUARDE!\n"),
                        TextSpan(text: "Sua senha será chamado no painel")
                      ]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                            onPressed: () {},
                            child: const Text("IMPRIMIR SENHA")),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SizedBox(
                        height: 48,
                        child: OutlinedButton(
                            onPressed: () {},
                            child: const Text("ENVIAR SENHA VIA SMS")),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: sizeOf.width * .8,
                  height: 48,
                  child: ElevatedButton(
                      onPressed: () {
                        selfServicesController.restartProcess();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: LabClinicasTheme.orangeColor),
                      child: const Text(
                        "FINALIZAR",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
