import 'package:fe_lab_clinicas_adm/src/models/patient_information_form_model.dart';
import 'package:fe_lab_clinicas_adm/src/pages/checkin/checkin_controller.dart';
import 'package:fe_lab_clinicas_adm/src/pages/checkin/widgets/checkin_image_link.dart';
import 'package:fe_lab_clinicas_adm/src/shared/data_item.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';

class CheckinPage extends StatefulWidget {
  const CheckinPage({super.key});

  @override
  State<CheckinPage> createState() => _CheckinPageState();
}

class _CheckinPageState extends State<CheckinPage> with MessagesViewMixin {
  final controller = Injector.get<CheckinController>();
  @override
  void initState() {
    super.initState();
    messageListener(controller);
    effect(() {
      if (controller.endProcess()) {
        Navigator.of(context).pushReplacementNamed("/end-checkin");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final PatientInformationFormModel(
      :password,
      :patient,
      :medicalOrders,
      :healthInsuranceCard
    ) = controller.informationForm.watch(context)!;
    return Scaffold(
      appBar: LabClinicasAppBar(),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: MediaQuery.sizeOf(context).width * .5,
            padding: const EdgeInsets.all(40),
            margin: const EdgeInsets.only(top: 56),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                border: Border.all(color: LabClinicasTheme.orangeColor)),
            child: Column(
              children: [
                Image.asset("assets/images/patient_avatar.png"),
                const SizedBox(height: 16),
                const Text(
                  "A senha chamada foi",
                  style: LabClinicasTheme.titleSmallStyle,
                ),
                const SizedBox(height: 16),
                Container(
                  alignment: Alignment.center,
                  padding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  width: 218,
                  decoration: BoxDecoration(
                    color: LabClinicasTheme.orangeColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    password,
                    style: LabClinicasTheme.titleSmallStyle
                        .copyWith(fontSize: 16, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 48),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: LabClinicasTheme.lightOrangeColor,
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    "Cadastro",
                    style: LabClinicasTheme.subTitleSmallStyle.copyWith(
                        color: LabClinicasTheme.orangeColor,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                const SizedBox(height: 24),
                DataItem(
                    label: "Nome Paciente",
                    value: patient.name,
                    padding: const EdgeInsets.only(bottom: 24)),
                DataItem(
                    label: "Email",
                    value: patient.email,
                    padding: const EdgeInsets.only(bottom: 24)),
                DataItem(
                    label: "Telefone de contato",
                    value: patient.phoneNumber,
                    padding: const EdgeInsets.only(bottom: 24)),
                DataItem(
                    label: "CPF",
                    value: patient.document,
                    padding: const EdgeInsets.only(bottom: 24)),
                DataItem(
                    label: "CEP",
                    value: patient.address.cep,
                    padding: const EdgeInsets.only(bottom: 24)),
                DataItem(
                    label: "ENDEREÇO",
                    value:
                        "${patient.address.streetAddress}, ${patient.address.number}, ${patient.address.addressComplement}, ${patient.address.district}, ${patient.address.city} - ${patient.address.state}",
                    padding: const EdgeInsets.only(bottom: 24)),
                DataItem(
                    label: "RESPONSAVEL",
                    value: patient.guardian,
                    padding: const EdgeInsets.only(bottom: 24)),
                DataItem(
                    label: "DOCUMENTO DE IDENTIFICAÇÃO",
                    value: patient.guardianIdentificationNumber,
                    padding: const EdgeInsets.only(bottom: 24)),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: LabClinicasTheme.lightOrangeColor,
                      borderRadius: BorderRadius.circular(16)),
                  child: Text(
                    "Validar Imagens Exames",
                    style: LabClinicasTheme.subTitleSmallStyle.copyWith(
                        color: LabClinicasTheme.orangeColor,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CheckinImageLink(
                        label: "Carteirinha", image: healthInsuranceCard),
                    Column(
                      children: [
                        for (final (index, medicalOrders)
                            in medicalOrders.indexed)
                          CheckinImageLink(
                              label: "Perdido médico ${index + 1}",
                              image: medicalOrders)
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                      onPressed: () async {
                        await controller.endCheckin();
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size.fromHeight(48)),
                      child: const Text("FINALIZAR O ATENDIMENTO")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
