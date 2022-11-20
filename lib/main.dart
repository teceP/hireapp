import 'package:autoroutetest/_logic/cubit/geo_points_cubit.dart';
import 'package:autoroutetest/default_firebase_options.dart';
import 'package:autoroutetest/routes/router.gr.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  final _appRouter = AppRouter();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    //name: 'Hire',
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GeoPointsCubit(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Hire',
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
        theme: ThemeData(
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme.apply(),
          ),
        ),
      ),
    );
  }
}
