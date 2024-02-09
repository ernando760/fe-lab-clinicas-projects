import 'package:fe_lab_clinicas_adm/src/pages/home/home_controller.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with MessagesViewMixin {
  final formKey = GlobalKey<FormState>();

  final deskNumberEC = TextEditingController();

  final homeController = Injector.get<HomeController>();

  @override
  void initState() {
    super.initState();
    messageListener(homeController);
    effect(() {
      if (homeController.informationForm != null) {
        Navigator.of(context).pushReplacementNamed("/pre-checkin",
            arguments: homeController.informationForm);
      }
    });
  }

  @override
  void dispose() {
    deskNumberEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: LabClinicasAppBar(),
      body: Center(
          child: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(40),
          width: sizeOf.width * .4,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: LabClinicasTheme.orangeColor)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Bem Vindo!",
                style: LabClinicasTheme.titleStyle,
              ),
              const SizedBox(height: 32),
              const Text(
                "Preencha o número do guichê que você está atendendo",
                style: LabClinicasTheme.subTitleSmallStyle,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: deskNumberEC,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration:
                    const InputDecoration(label: Text("Número do guichê")),
                validator: Validatorless.multiple([
                  Validatorless.required("Guichê obrigatorio"),
                  Validatorless.number("Guichê Deve ser um número")
                ]),
              ),
              const SizedBox(height: 32),
              SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                      onPressed: () {
                        final valid = formKey.currentState?.validate() ?? false;
                        if (valid) {
                          homeController
                              .startService(int.parse(deskNumberEC.text));
                        }
                      },
                      child: const Text("CHAMAR PRÓXIMO PACIENTE")))
            ],
          ),
        ),
      )),
    );
  }
}
