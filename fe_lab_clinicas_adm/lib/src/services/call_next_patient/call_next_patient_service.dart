import 'dart:developer';

import 'package:fe_lab_clinicas_adm/src/models/patient_information_form_model.dart';
import 'package:fe_lab_clinicas_adm/src/repositories/attendant_desk_assignment/attendant_desk_assignment_repository.dart';
import 'package:fe_lab_clinicas_adm/src/repositories/painel/painel_repository.dart';
import 'package:fe_lab_clinicas_adm/src/repositories/patient_information_form/patient_information_form_repository.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';

class CallNextPatientService {
  CallNextPatientService(
      {required PatientInformationFormRepository
          patientInformationFormRepository,
      required AttendantDeskAssignmentRepository
          attendantDeskAssignmentRepository,
      required PainelRepository painelRepository})
      : _patientInformationFormRepository = patientInformationFormRepository,
        _attendantDeskAssignmentRepository = attendantDeskAssignmentRepository,
        _painelRepository = painelRepository;

  final PatientInformationFormRepository _patientInformationFormRepository;
  final AttendantDeskAssignmentRepository _attendantDeskAssignmentRepository;
  final PainelRepository _painelRepository;

  Future<Either<RepositoryException, PatientInformationFormModel?>>
      execute() async {
    final result = await _patientInformationFormRepository.callNextToCkeckin();

    switch (result) {
      case Left(value: final exception):
        return Left(exception);
      case Right(value: final patientInformationForm?):
        return updatePanel(patientInformationForm);
      case Right():
        return Right(null);
    }
  }

  Future<Either<RepositoryException, PatientInformationFormModel?>> updatePanel(
      PatientInformationFormModel patientInformationForm) async {
    final resultDesk =
        await _attendantDeskAssignmentRepository.getDeskAssignment();

    switch (resultDesk) {
      case Left(value: final exception):
        return Left(exception);
      case Right(value: final deskNumber):
        final painelResult = await _painelRepository.callOnPanel(
            patientInformationForm.password, deskNumber);
        switch (painelResult) {
          case Left(value: final exception):
            log('ATENÇÃO!!!! Não foi possivel chamar o paciente',
                error: exception,
                stackTrace: StackTrace.fromString(
                    'ATENÇÃO!!!! Não foi possivel chamar o paciente'));
            return Right(patientInformationForm);
          case Right():
            return Right(patientInformationForm);
        }
    }
  }
}
