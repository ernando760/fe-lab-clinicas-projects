import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';

import './painel_repository.dart';

class PainelRepositoryImpl implements PainelRepository {
  PainelRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  final RestClient _restClient;

  @override
  Future<Either<RepositoryException, String>> callOnPanel(
      String password, int attendantDesk) async {
    try {
      final Response(data: {"id": id}) =
          await _restClient.auth.post("/painelCheckin", data: {
        "password": password,
        "time_called": DateTime.now().toIso8601String(),
        "attendant_desk": attendantDesk
      });
      return Right(id);
    } on DioException catch (e, s) {
      log("Erro ao chamar o paciente no painel", error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
