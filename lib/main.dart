import 'package:autoroutetest/_logic/cubit/geo_points_cubit.dart';
import 'package:autoroutetest/app_finals.dart';
import 'package:autoroutetest/default_firebase_options.dart';
import 'package:autoroutetest/routes/router.gr.dart';
import 'package:autoroutetest/search/home_query_cubit.dart';
import 'package:autoroutetest/search/query_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  final _appRouter = AppRouter();
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    //name: 'Hire',
    options: DefaultFirebaseOptions.currentPlatform,
  );

  HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: kIsWeb
          ? HydratedStorage.webStorageDirectory
          : await getApplicationDocumentsDirectory());

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
        BlocProvider(
          create: (context) => QueryCubit(),
        ),
        BlocProvider(
          create: (context) => HomeQueryCubit(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Hire',
        routerDelegate: appRouter.delegate(),
        routeInformationParser: appRouter.defaultRouteParser(),
        theme: ThemeData(
          appBarTheme: AppBarTheme.of(context).copyWith(
            backgroundColor: AppFinals.appBarColor,
            titleTextStyle: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 18,
            ),
            iconTheme: IconTheme.of(context).copyWith(color: Colors.black),
            actionsIconTheme:
                IconTheme.of(context).copyWith(color: Colors.black),
          ),
          textTheme: GoogleFonts.robotoTextTheme(
            Theme.of(context).textTheme.apply(),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey.shade300,
                ),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              backgroundColor: AppFinals.buttonColor,
            ),
          ),
        ),
      ),
    );
  }
}
