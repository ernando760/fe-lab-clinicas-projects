// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_self_service/src/model/patient_model.dart';

import 'package:fe_lab_clinicas_self_service/src/repositories/patients/patient_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class FindPatientController with MessagesStateMixin {
  FindPatientController({
    required PatientRepository repository,
  }) : _repository = repository;

  final PatientRepository _repository;

  final _patientNotFound = ValueSignal<bool?>(null);
  bool? get patientNotFound => _patientNotFound.value;

  final _patient = ValueSignal<PatientModel?>(null);
  PatientModel? get patient => _patient.value;

  Future<void> findPatientByDocument(String document) async {
    final patientResult = await _repository.findPatientByDocument(document);

    bool patientNotFound = false;
    PatientModel? patient;

    switch (patientResult) {
      case Right(value: PatientModel model?):
        patientNotFound = false;
        patient = model;
      case Right(value: _):
        patientNotFound = true;
        patient = null;
      case Left():
        showError("Erro ao buscar paciente");
        return;
    }
    // manda um sinal apenas uma vez
    batch(() {
      _patient.value = patient;
      _patientNotFound.value = patientNotFound;
    });
  }

  void continueWithOutDocument() {
    batch(() {
      _patient.value = null;
      _patientNotFound.value = null;
    });
  }
}
