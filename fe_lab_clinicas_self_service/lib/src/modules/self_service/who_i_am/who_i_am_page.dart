import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/self_service_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validatorless/validatorless.dart';

class WhoIAmPage extends StatefulWidget {
  const WhoIAmPage({super.key});

  @override
  State<WhoIAmPage> createState() => _WhoIAmPageState();
}

class _WhoIAmPageState extends State<WhoIAmPage> {
  final selfServiceController = Injector.get<SelfServiceController>();
  final formKey = GlobalKey<FormState>();
  final firstNameEC = TextEditingController();
  final lastnameEC = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    firstNameEC.dispose();
    lastnameEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        firstNameEC.text = "";
        lastnameEC.text = "";
        selfServiceController.clearForm();
      },
      child: Scaffold(
        appBar: LabClinicasAppBar(
          actions: [
            PopupMenuButton(
              child: const IconPopupMenuWidgets(),
              itemBuilder: (context) => [
                const PopupMenuItem(
                    value: 1, child: Text("Finalizar Terminal")),
              ],
              onSelected: (value) async {
                if (value == 1) {
                  final nav = Navigator.of(context);
                  await SharedPreferences.getInstance()
                      .then((value) => value.clear());
                  nav.pushNamedAndRemoveUntil("/", (route) => false);
                }
              },
            )
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/images/background_login.png",
                        ),
                        fit: BoxFit.cover)),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(40),
                    width: sizeOf.width * .8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16)),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Image.asset("assets/images/logo_vertical.png"),
                          const SizedBox(height: 48),
                          const Text("Bem-vindo!",
                              style: LabClinicasTheme.titleStyle),
                          const SizedBox(height: 48),
                          TextFormField(
                            controller: firstNameEC,
                            decoration: const InputDecoration(
                                label: Text("Digite seu nome")),
                            validator:
                                Validatorless.required("Nome obrigatótio"),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                              controller: lastnameEC,
                              decoration: const InputDecoration(
                                  label: Text("Digite seu sobrenome")),
                              validator: Validatorless.required(
                                  "Sobrenome obrigatótio")),
                          const SizedBox(height: 24),
                          SizedBox(
                              width: sizeOf.width * .8,
                              height: 48,
                              child: ElevatedButton(
                                  onPressed: () {
                                    final valid =
                                        formKey.currentState?.validate() ??
                                            false;
                                    if (valid) {
                                      selfServiceController
                                          .setWhoIAmDataStepAndNext(
                                              firstNameEC.text,
                                              lastnameEC.text);
                                    }
                                  },
                                  child: const Text("CONTINUAR")))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
