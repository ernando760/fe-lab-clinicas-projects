// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/model/patient_model.dart';

import 'package:fe_lab_clinicas_self_service/src/repositories/patients/patient_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PatientController with MessagesStateMixin {
  final PatientRepository _patientRepository;
  PatientController({
    required PatientRepository patientRepository,
  }) : _patientRepository = patientRepository;
  PatientModel? patient;
  final _nextStep = ValueSignal<bool>(false);
  bool get nextStep => _nextStep.value;

  void goNextStep() {
    _nextStep.forceUpdate(true);
  }

  Future<void> updateAndNext(PatientModel model) async {
    final updateResult = await _patientRepository.update(model);

    switch (updateResult) {
      case Left():
        showError("Error ao atualizar dados paciente, chame o atendente");
      case Right():
        showInfo("Paciente atualizado com sucesso");
        patient = model;
        goNextStep();
    }
  }

  Future<void> saveAndNext(RegisterPatientModel patient) async {
    final result = await _patientRepository.register(patient);

    switch (result) {
      case Left():
        showError("Error ao cadastrar do paciente");
      case Right(value: final patient):
        showInfo("Paciente cadastrado com sucesso");
        this.patient = patient;
        goNextStep();
    }
  }
}
