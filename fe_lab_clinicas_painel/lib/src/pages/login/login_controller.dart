import 'dart:developer';

import 'package:asyncstate/asyncstate.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_painel/src/services/login/user_login_service.dart';

import 'package:signals_flutter/signals_flutter.dart';

class LoginController with MessagesStateMixin {
  final UserLoginService _loginService;

  LoginController({
    required UserLoginService loginService,
  }) : _loginService = loginService;
  final _obscuredPassword = signal(true);
  final _logged = signal(false);
  bool get logged => _logged.value;

  bool get obscuredPassword => _obscuredPassword.value;

  void passwordToggle() => _obscuredPassword.value = !_obscuredPassword.value;

  Future<void> login(String email, String password) async {
    final loginResult =
        await _loginService.execute(email, password).asyncLoader();

    switch (loginResult) {
      case Left(value: ServiceException(:final message)):
        showError(message);
      case Right(value: _):
        log("logou");
        _logged.value = true;
    }
  }
}
