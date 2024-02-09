import 'package:asyncstate/asyncstate.dart';
import 'package:fe_lab_clinicas_core/fe_lab_clinicas_core.dart';
import 'package:fe_lab_clinicas_core/src/loader/lab_clinicas_loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class LabClinicasCoreConfig extends StatelessWidget {
  const LabClinicasCoreConfig(
      {super.key,
      required this.title,
      this.bindings,
      this.pages,
      this.pagesBuilder,
      this.modules,
      this.didStart});
  final ApplicationBindings? bindings;
  final List<FlutterGetItPageRouter>? pages;
  final List<FlutterGetItPageBuilder>? pagesBuilder;
  final List<FlutterGetItModule>? modules;
  final String title;
  final VoidCallback? didStart;
  @override
  Widget build(BuildContext context) {
    return FlutterGetIt(
      debugMode: kDebugMode,
      bindings: bindings,
      modules: modules,
      pages: [...pages ?? [], ...pagesBuilder ?? []],
      builder: (context, routes, flutterGetItNavObserver) {
        if (didStart != null) didStart!();
        return AsyncStateBuilder(
          loader: LabClinicasLoader(),
          builder: (navigatorObserver) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: title,
              theme: LabClinicasTheme.lightTheme,
              darkTheme: LabClinicasTheme.darkTheme,
              navigatorObservers: [navigatorObserver, flutterGetItNavObserver],
              routes: routes,
            );
          },
        );
      },
    );
  }
}
