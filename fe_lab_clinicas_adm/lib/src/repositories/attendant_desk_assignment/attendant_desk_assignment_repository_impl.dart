import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';

import './attendant_desk_assignment_repository.dart';

class AttendantDeskAssignmentRepositoryImpl
    implements AttendantDeskAssignmentRepository {
  final RestClient _restClient;

  AttendantDeskAssignmentRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<Either<RepositoryException, Unit>> startService(int deskNumber) async {
    final result = await _clearDeskbyUser();

    switch (result) {
      case Left(value: final exception):
        return Left(exception);
      case Right():
        await _restClient.auth.post("/attendantDeskAssignment", data: {
          "user_id": "#userAuthRef",
          "desk_number": deskNumber,
          "data_created": DateTime.now().toIso8601String(),
          "status": "Available"
        });
        return Right(unit);
    }
  }

  Future<Either<RepositoryException, Unit>> _clearDeskbyUser() async {
    try {
      final desk = await _getDeskByUser();
      if (desk != null) {
        await _restClient.auth.delete("/attendantDeskAssignment/${desk.id}");
      }
      return Right(unit);
    } on DioException catch (e, s) {
      log("Erro ao deletar o número do guichê", error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }

  Future<({String id, int deskNumber})?> _getDeskByUser() async {
    final Response(:List data) = await _restClient.auth.get(
        "/attendantDeskAssignment",
        queryParameters: {"user_id": "#userAuthRef"});

    if (data
        case List(
          isNotEmpty: true,
          first: {"id": String id, "desk_number": int number}
        )) {
      return (id: id, deskNumber: number);
    }
    return null;
  }

  @override
  Future<Either<RepositoryException, int>> getDeskAssignment() async {
    try {
      final Response(data: List(first: data)) = await _restClient.auth
          .get("/attendantDeskAssignment", queryParameters: {
        "user_id": "#userAuthRef",
      });
      return Right(data["desk_number"]);
    } on DioException catch (e, s) {
      log("Erro ao buscar o número do guichê", error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
