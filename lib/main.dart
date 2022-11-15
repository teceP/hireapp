import 'package:autoroutetest/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  final _appRouter = AppRouter();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    HireApp(
      appRouter: _appRouter,
    ),
  );
}

class HireApp extends StatelessWidget {
  final AppRouter appRouter;
  const HireApp({required this.appRouter, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Hire',
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
      theme: ThemeData(
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme.apply(),
        ),
      ),
    );
  }
}
