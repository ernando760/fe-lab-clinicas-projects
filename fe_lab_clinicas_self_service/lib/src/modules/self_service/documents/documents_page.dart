import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/model/self_service_model.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/documents/widgets/document_box_widget.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/self_service_controller.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/widgets/lab_clinicas_self_service_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class DocumentsPage extends StatefulWidget {
  const DocumentsPage({super.key});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> with MessagesViewMixin {
  final selfServicesController = Injector.get<SelfServiceController>();

  @override
  void initState() {
    super.initState();
    messageListener(selfServicesController);
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
    // final documents = selfServicesController.model.documents;
    final totalHeathInsuranceCard = selfServicesController
            .model.documents?[DocumentType.healthInsuranceCard]?.length ??
        0;
    final totalMedicalOrder = selfServicesController
            .model.documents?[DocumentType.medicalOrder]?.length ??
        0;
    return Scaffold(
      appBar: LabClinicasSelfServiceAppBar(),
      body: Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: Container(
            width: sizeOf.width * .85,
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: LabClinicasTheme.orangeColor)),
            child: Column(
              children: [
                Image.asset('assets/images/folder.png'),
                const SizedBox(height: 24),
                const Text("ADICIONAR DOCUMENTOS",
                    style: LabClinicasTheme.titleSmallStyle),
                const SizedBox(height: 32),
                const Text("Selecione o documento que deseja fotografar",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: LabClinicasTheme.blueColor)),
                const SizedBox(height: 24),
                SizedBox(
                  width: sizeOf.width * .8,
                  height: 300,
                  child: Row(
                    children: [
                      DocumentBoxWidget(
                        uploaded: totalHeathInsuranceCard > 0,
                        icon: Image.asset("assets/images/id_card.png"),
                        label: "CARTEIRINHA",
                        totalFile: totalHeathInsuranceCard,
                        onTap: () async {
                          final filePath = await Navigator.of(context)
                              .pushNamed("/self-service/documents/scan");

                          if (filePath != null && filePath != "") {
                            selfServicesController.registerDocuments(
                                DocumentType.healthInsuranceCard,
                                filePath.toString());
                            setState(() {});
                          }
                        },
                      ),
                      const SizedBox(width: 32),
                      DocumentBoxWidget(
                        uploaded: totalMedicalOrder > 0,
                        icon: Image.asset("assets/images/document.png"),
                        label: "PEDIDO MÈDICO",
                        totalFile: totalMedicalOrder,
                        onTap: () async {
                          final filePath = await Navigator.of(context)
                              .pushNamed("/self-service/documents/scan");

                          if (filePath != null && filePath != "") {
                            selfServicesController.registerDocuments(
                                DocumentType.medicalOrder, filePath.toString());
                            setState(() {});
                          }
                        },
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Visibility(
                  visible: totalMedicalOrder > 0 && totalHeathInsuranceCard > 0,
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              selfServicesController.clearDocuments();
                              setState(() {});
                            },
                            style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.red,
                                side: const BorderSide(color: Colors.red),
                                fixedSize: const Size.fromHeight(48)),
                            child: const Text("REMOVER TODAS")),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await selfServicesController.finalize();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: LabClinicasTheme.orangeColor,
                              fixedSize: const Size.fromHeight(48)),
                          child: const Text("FINALIZAR"),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
