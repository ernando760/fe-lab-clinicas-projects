import 'package:fe_lab_clinicas_adm/src/pages/login/login_controller.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with MessagesViewMixin {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginController = Injector.get<LoginController>();

  @override
  void initState() {
    messageListener(loginController);
    effect(() {
      if (loginController.logged) {
        Navigator.pushReplacementNamed(context, "/home");
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizedOf = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(minHeight: sizedOf.height),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background_login.png"),
                fit: BoxFit.cover)),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(40),
            constraints: BoxConstraints(maxWidth: sizedOf.width * .4),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Login",
                    style: LabClinicasTheme.titleStyle,
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(label: Text('Email')),
                    validator: Validatorless.multiple([
                      Validatorless.required("Email Obrigatório"),
                      Validatorless.email("Email inválido")
                    ]),
                  ),
                  const SizedBox(height: 24),
                  Watch(
                    (_) => TextFormField(
                      controller: passwordController,
                      obscureText: loginController.obscuredPassword,
                      validator: Validatorless.required("Senha Obrigatótia"),
                      decoration: InputDecoration(
                        label: const Text('Password'),
                        suffixIcon: IconButton(
                            onPressed: loginController.passwordToggle,
                            icon: Icon(loginController.obscuredPassword
                                ? Icons.visibility
                                : Icons.visibility_off)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                      width: sizedOf.width * .8,
                      height: 48,
                      child: ElevatedButton(
                          onPressed: () async {
                            final valid =
                                formKey.currentState?.validate() ?? false;
                            if (valid) {
                              await loginController.login(emailController.text,
                                  passwordController.text);
                            }
                          },
                          child: const Text("ENTRAR")))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
