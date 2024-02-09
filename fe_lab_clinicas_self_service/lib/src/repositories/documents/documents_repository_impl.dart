import 'dart:developer';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';

import './documents_repository.dart';

class DocumentsRepositoryImpl implements DocumentsRepository {
  final RestClient _restClient;

  DocumentsRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  Future<Either<RepositoryException, String>> uploadImage(
      Uint8List file, String fileName) async {
    try {
      final formData = FormData.fromMap({
        "file": MultipartFile.fromBytes(file, filename: fileName),
      });
      final Response(data: {'url': pathUrl}) =
          await _restClient.auth.post("/uploads", data: formData);

      return Right(pathUrl);
    } on DioException catch (e, s) {
      log("Erro ao enviar a imagem do documento", error: e, stackTrace: s);
      return Left(RepositoryException());
    }
  }
}
