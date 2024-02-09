import 'dart:developer';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/model/self_service_model.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/patient/patient_controller.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/patient/patient_form_controller.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/self_service_controller.dart';
import 'package:fe_lab_clinicas_self_service/src/modules/self_service/widgets/lab_clinicas_self_service_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class PatientPage extends StatefulWidget {
  const PatientPage({super.key});

  @override
  State<PatientPage> createState() => _PatientPageState();
}

class _PatientPageState extends State<PatientPage>
    with PatientFormController, MessagesViewMixin {
  final formKey = GlobalKey<FormState>();
  final SelfServiceController selfServiceController =
      Injector.get<SelfServiceController>();

  final PatientController patientController = Injector.get<PatientController>();

  late bool patientFound;
  late bool enableForm;

  @override
  void initState() {
    super.initState();
    messageListener(patientController);
    final SelfServiceModel(:patient) = selfServiceController.model;

    patientFound = patient != null;
    enableForm = !patientFound;
    initializeForm(patient);
    effect(() {
      if (patientController.nextStep) {
        log("next step: ${patientController.nextStep}");
        selfServiceController
            .updatePatientAndGoDocument(patientController.patient);
      }
    });
  }

  @override
  void dispose() {
    disposeForm();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeOf = MediaQuery.sizeOf(context);
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
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Visibility(
                      visible: patientFound,
                      replacement: Image.asset("assets/images/lupa_icon.png"),
                      child: Image.asset("assets/images/check_icon.png")),
                  const SizedBox(height: 24),
                  Visibility(
                    visible: patientFound,
                    replacement: const Text(
                      "Cadastro não encontrado",
                      style: LabClinicasTheme.titleSmallStyle,
                    ),
                    child: const Text(
                      "Cadastro encontrado",
                      style: LabClinicasTheme.titleSmallStyle,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Visibility(
                    visible: patientFound,
                    replacement: const Text(
                        "Preencha o formulário abaixo para fazer o seu cadastro",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: LabClinicasTheme.blueColor)),
                    child: const Text("Confirma os dados do seu cadastro",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: LabClinicasTheme.blueColor)),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: nameEC,
                    decoration:
                        const InputDecoration(label: Text("Nome Paciente")),
                    validator:
                        Validatorless.required("Nome do Paciente Obrigatório"),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: emailEC,
                    decoration: const InputDecoration(label: Text("E-mail")),
                    validator: Validatorless.multiple([
                      Validatorless.required("E-mail Obrigatório"),
                      Validatorless.email("E-mail inválido")
                    ]),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                      readOnly: !enableForm,
                      controller: phoneEC,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        TelefoneInputFormatter()
                      ],
                      decoration: const InputDecoration(
                          label: Text("Telefone de Contato")),
                      validator: Validatorless.required(
                          "Telefone de Contato Obrigatório")),
                  const SizedBox(height: 16),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: documentEC,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter()
                    ],
                    decoration:
                        const InputDecoration(label: Text("Digite CPF")),
                    validator: Validatorless.multiple([
                      Validatorless.required("CPF Obrigatório"),
                      // Validatorless.cpf("CPF Inválido")
                    ]),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                      readOnly: !enableForm,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        CepInputFormatter()
                      ],
                      controller: cepEC,
                      decoration: const InputDecoration(label: Text("CEP")),
                      validator: Validatorless.required("Cep Obrigatório")),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        flex: 3,
                        child: TextFormField(
                            readOnly: !enableForm,
                            controller: streetEC,
                            decoration:
                                const InputDecoration(label: Text("Endereço")),
                            validator:
                                Validatorless.required("Endereço Obrigatório")),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        flex: 1,
                        child: TextFormField(
                            readOnly: !enableForm,
                            controller: numberEC,
                            decoration:
                                const InputDecoration(label: Text("Número")),
                            validator: Validatorless.multiple([
                              Validatorless.required("Número Obrigatório"),
                              Validatorless.number("Número Invalido")
                            ])),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                            readOnly: !enableForm,
                            controller: complementsEC,
                            decoration: const InputDecoration(
                                label: Text("Complemento")),
                            validator: Validatorless.required(
                                "Complemento Obrigatório")),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                            readOnly: !enableForm,
                            controller: stateEC,
                            decoration:
                                const InputDecoration(label: Text("Estado")),
                            validator:
                                Validatorless.required("Estado Obrigatório")),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                            readOnly: !enableForm,
                            controller: cityEC,
                            decoration:
                                const InputDecoration(label: Text("Cidade")),
                            validator:
                                Validatorless.required("Cidade Obrigatória")),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                            readOnly: !enableForm,
                            controller: districtEC,
                            decoration:
                                const InputDecoration(label: Text("Bairro")),
                            validator:
                                Validatorless.required("Bairro Obrigatório")),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: guardianEC,
                    decoration:
                        const InputDecoration(label: Text("Responsável")),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    readOnly: !enableForm,
                    controller: guardianIdentificationNumbeEC,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      CpfInputFormatter()
                    ],
                    decoration: const InputDecoration(
                        label: Text("Documentos de identificação")),
                  ),
                  const SizedBox(height: 32),
                  Visibility(
                    visible: !enableForm,
                    replacement: SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                            onPressed: () {
                              final valid =
                                  formKey.currentState?.validate() ?? false;
                              if (valid) {
                                if (patientFound) {
                                  patientController.updateAndNext(updatePatient(
                                      selfServiceController.model.patient!));
                                } else {
                                  patientController
                                      .saveAndNext(createPatientRegister());
                                }
                              }
                            },
                            child: Visibility(
                                visible: !patientFound,
                                replacement: const Text("SALVAR E CONTINUAR"),
                                child: const Text("CADASTRAR")))),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                              height: 48,
                              child: OutlinedButton(
                                  onPressed: () {
                                    setState(() {
                                      enableForm = true;
                                    });
                                  },
                                  child: const Text("EDITAR"))),
                        ),
                        const SizedBox(width: 17),
                        Expanded(
                          child: SizedBox(
                              height: 48,
                              child: ElevatedButton(
                                  onPressed: () {
                                    patientController.patient =
                                        selfServiceController.model.patient;
                                    patientController.goNextStep();
                                  },
                                  child: const Text("CONTINUAR"))),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
