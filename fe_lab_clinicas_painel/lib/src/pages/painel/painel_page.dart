import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_painel/src/models/panel_checkin_model.dart';
import 'package:fe_lab_clinicas_painel/src/pages/painel/painel_controller.dart';
import 'package:fe_lab_clinicas_painel/src/pages/painel/widgets/panel_main_widget.dart';
import 'package:fe_lab_clinicas_painel/src/pages/painel/widgets/password_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PainelPage extends StatefulWidget {
  const PainelPage({super.key});

  @override
  State<PainelPage> createState() => _PainelPageState();
}

class _PainelPageState extends State<PainelPage> {
  final controller = Injector.get<PainelController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.listenerPainel();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final PanelCheckinModel? current;
    final PanelCheckinModel? lastCall;
    final List<PanelCheckinModel> others;

    final listPanel = controller.painelData.watch(context);

    current = listPanel.firstOrNull;
    if (listPanel.isNotEmpty) {
      listPanel.removeAt(0);
    }
    lastCall = listPanel.firstOrNull;
    if (listPanel.isNotEmpty) {
      listPanel.removeAt(0);
    }

    others = listPanel;

    return Scaffold(
      appBar: LabClinicasAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  lastCall != null
                      ? SizedBox(
                          width: MediaQuery.sizeOf(context).width * .4,
                          child: PanelMainWidget(
                              label: "Senha Anterior",
                              password: lastCall.password,
                              deskNumber: lastCall.attendantDesk
                                  .toString()
                                  .padLeft(2, "0"),
                              labelColor: LabClinicasTheme.orangeColor,
                              buttonColor: LabClinicasTheme.blueColor),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(width: 20),
                  current != null
                      ? SizedBox(
                          width: MediaQuery.sizeOf(context).width * .4,
                          child: PanelMainWidget(
                              label: "Chamando senha",
                              password: current.password,
                              deskNumber: current.attendantDesk
                                  .toString()
                                  .padLeft(2, "0"),
                              labelColor: LabClinicasTheme.blueColor,
                              buttonColor: LabClinicasTheme.orangeColor),
                        )
                      : const SizedBox.shrink(),
                ],
              ),
              const SizedBox(height: 40),
              const Divider(color: LabClinicasTheme.orangeColor),
              const SizedBox(height: 30),
              const Text(
                "Ùltimos chamados",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: LabClinicasTheme.orangeColor),
              ),
              const SizedBox(height: 16),
              Wrap(
                runAlignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 10,
                children: others
                    .map((p) => PasswordTileWidget(
                          password: p.password,
                          deskNumber: p.attendantDesk.toString(),
                        ))
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
