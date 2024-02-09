import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_painel/src/models/panel_checkin_model.dart';
import 'package:fe_lab_clinicas_painel/src/repositories/painel_checkin/painel_checkin_repository.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PainelController with MessagesStateMixin {
  PainelController({required PainelCheckinRepository repository})
      : _repository = repository;

  final PainelCheckinRepository _repository;
  final painelData = listSignal<PanelCheckinModel>([]);

  Connect? _painelConnect;

  Function? _socketDispose;

  void listenerPainel() {
    final (:channel, :dispose) = _repository.openChannelSocket();

    _socketDispose = dispose;

    _painelConnect = connect(painelData);
    if (channel != null) {
      final painelStream = _repository.getTodayPanel(channel);
      _painelConnect!.from(painelStream);
    }
  }

  void dispose() {
    _painelConnect?.dispose();
    if (_socketDispose != null) {
      _socketDispose!();
    }
  }
}
