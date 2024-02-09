import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_adm/src/models/patient_information_form_model.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';

import './patient_information_form_repository.dart';

class PatientInformationFormRepositoryImpl
    implements PatientInformationFormRepository {
  PatientInformationFormRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  final RestClient _restClient;

  @override
  Future<Either<RepositoryException, PatientInformationFormModel?>>
      callNextToCkeckin() async {
    final Response(:List data) =
        await _restClient.auth.get("/patientInformationForm", queryParameters: {
      "status": PatientInformationFormStatus.waiting.id,
      "page": 1,
      "limit": 1,
    });

    if (data.isEmpty) {
      return Right(null);
    }

    final formData = data.first;
    final updateStatusResult = await updateStatus(
        formData["id"], PatientInformationFormStatus.checkIn);
    switch (updateStatusResult) {
      case Left(value: final exception):
        return Left(exception);
      case Right():
        formData["status"] = PatientInformationFormStatus.checkIn.id;
        formData["patient"] = await _getPatient(formData["patient_id"]);
        log("Form Data $formData");
        return Right(PatientInformationFormModel.fromJson(formData));
    }
  }

  @override
  Future<Either<RepositoryException, Unit>> updateStatus(
      String id, PatientInformationFormStatus status) async {
    try {
      await _restClient.auth
          .put("/patientInformationForm/$id", data: {"status": status.id});
      return Right(unit);
    } on DioException catch (e, s) {
      log("Erro ao atualizar  status do form", error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  Future<Map<String, dynamic>> _getPatient(String id) async {
    final Response(:data) = await _restClient.auth.get("/patients/$id");
    return data;
  }
}
