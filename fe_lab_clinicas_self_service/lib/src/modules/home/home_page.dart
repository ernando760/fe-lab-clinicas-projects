import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sizedOf = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: LabClinicasAppBar(actions: [
        PopupMenuButton(
          child: const IconPopupMenuWidgets(),
          itemBuilder: (context) => [
            const PopupMenuItem(value: 1, child: Text("Iniciar Terminal")),
            const PopupMenuItem(value: 2, child: Text("Finalizar Terminal"))
          ],
        )
      ]),
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          margin: const EdgeInsets.all(112),
          padding: const EdgeInsets.all(40),
          width: sizedOf.width * .8,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: LabClinicasTheme.orangeColor)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Bem vindo",
                style: LabClinicasTheme.titleStyle,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: sizedOf.width * .8,
                height: 48,
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/self-service");
                    },
                    child: const Text("INICIAR TERMINAL")),
              )
            ],
          ),
        ),
      ),
    );
  }
}
