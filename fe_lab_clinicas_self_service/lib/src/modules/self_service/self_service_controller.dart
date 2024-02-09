// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:asyncstate/asyncstate.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'package:fe_lab_clinicas_self_service/src/model/patient_model.dart';
import 'package:fe_lab_clinicas_self_service/src/model/self_service_model.dart';
import 'package:fe_lab_clinicas_self_service/src/repositories/information_form/information_form_repository.dart';

enum FormSteps {
  none,
  whoIAm,
  findPatient,
  patient,
  documents,
  done,
  restart,
}

class SelfServiceController with MessagesStateMixin {
  final _step = ValueSignal(FormSteps.none);
  var _model = const SelfServiceModel();
  var password = "";
  SelfServiceModel get model => _model;

  final InformationFormRepository _informationFormRepository;
  SelfServiceController({
    required InformationFormRepository informationFormRepository,
  }) : _informationFormRepository = informationFormRepository;

  FormSteps get step => _step.value;

  void startProcess() {
    _step.forceUpdate(FormSteps.whoIAm);
  }

  void setWhoIAmDataStepAndNext(String name, String lastname) {
    _model = _model.copyWith(name: () => name, lastname: () => lastname);
    _step.forceUpdate(FormSteps.findPatient);
  }

  void clearForm() {
    _model = _model.clear();
  }

  void goToFormPatient(PatientModel? patient) {
    _model = _model.copyWith(patient: () => patient);
    _step.forceUpdate(FormSteps.patient);
  }

  void restartProcess() {
    _step.forceUpdate(FormSteps.restart);
    clearForm();
  }

  void updatePatientAndGoDocument(PatientModel? patientModel) {
    _model = _model.copyWith(patient: () => patientModel);
    _step.forceUpdate(FormSteps.documents);
  }

  void registerDocuments(DocumentType type, String filePath) {
    final documents = _model.documents ?? {};

    if (type == DocumentType.healthInsuranceCard) {
      documents[type]?.clear();
    }
    final values = documents[type] ?? [];
    values.add(filePath);
    documents[type] = values;
    _model = _model.copyWith(documents: () => documents);
  }

  void clearDocuments() {
    _model = _model.copyWith(documents: () => {});
  }

  Future<void> finalize() async {
    final result =
        await _informationFormRepository.register(model).asyncLoader();

    switch (result) {
      case Left():
        showError("Erro ao finalizar o formulário de auto atedimento");
      case Right():
        password = "${_model.name} ${_model.lastname}";
        _step.forceUpdate(FormSteps.done);
    }
  }
}
