import 'package:fe_lab_clinicas_adm/src/models/patient_information_form_model.dart';
import 'package:fe_lab_clinicas_adm/src/repositories/patient_information_form/patient_information_form_repository.dart';

import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:signals_flutter/signals_flutter.dart';

class CheckinController with MessagesStateMixin {
  CheckinController(
      {required PatientInformationFormRepository informationFormRepository})
      : _informationFormRepository = informationFormRepository;

  final informationForm = signal<PatientInformationFormModel?>(null);

  final PatientInformationFormRepository _informationFormRepository;
  final endProcess = signal(false);

  Future<void> endCheckin() async {
    if (informationForm() != null) {
      final result = await _informationFormRepository.updateStatus(
          informationForm.value!.id,
          PatientInformationFormStatus.beingAttended);

      switch (result) {
        case Left():
          showError("Erro ao atualizar o status do formulário");
        case Right():
          endProcess.value = true;
      }
    } else {
      showError("Formulário não pode ser nulo");
    }
  }
}
