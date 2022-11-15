import 'package:autoroutetest/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  final _appRouter = AppRouter();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Hire',
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    ),
  );
}
