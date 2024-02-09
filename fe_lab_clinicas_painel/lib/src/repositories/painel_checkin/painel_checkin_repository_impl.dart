import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
// import 'package:fe_lab_clinicas_painel/src/core/env.dart';
import 'package:fe_lab_clinicas_painel/src/models/panel_checkin_model.dart';
import 'package:intl/intl.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import './painel_checkin_repository.dart';

class PainelCheckinRepositoryImpl implements PainelCheckinRepository {
  final RestClient _restClient;

  PainelCheckinRepositoryImpl({required RestClient restClient})
      : _restClient = restClient;

  @override
  ({WebSocketChannel? channel, Function? dispose}) openChannelSocket() {
    try {
      // const wsbackendBaseUrl = Env.wsBackendBaseUrl;
      const wsbackendBaseUrl = "ws://localhost:8080";
      // "ws://192.168.1.197:8080"
      final wsUrl = Uri.parse("$wsbackendBaseUrl?tables=painelCheckin");
      final channel = WebSocketChannel.connect(wsUrl);

      return (
        channel: channel,
        dispose: () {
          channel.sink.close();
        }
      );
    } on WebSocketChannelException catch (e, s) {
      log("Message: ${e.message}");
      log("ERRO ao connectar no webSocket", error: e.inner, stackTrace: s);
      return (
        channel: null,
        dispose: null,
      );
    } catch (e, s) {
      log("ERRO desconhecido", error: e, stackTrace: s);
      return (
        channel: null,
        dispose: null,
      );
    }
  }

  @override
  Stream<List<PanelCheckinModel>> getTodayPanel(
      WebSocketChannel channel) async* {
    yield await _requestData();

    yield* channel.stream.asyncMap((_) async => _requestData());
  }

  Future<List<PanelCheckinModel>> _requestData() async {
    final dateFormat = DateFormat("y-MM-dd");
    final Response(:List data) = await _restClient.auth.get("/painelCheckin",
        queryParameters: {"time_called": dateFormat.format(DateTime.now())});

    return data.reversed
        .take(7)
        .map((e) => PanelCheckinModel.fromJson(e))
        .toList();
  }
}
