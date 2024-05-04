import 'package:connection_notifier/connection_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamazh_auth/cuibts/home_cuibt/home_cuibt.dart';
import 'package:hamazh_auth/data/dio_data/dio_data.dart';
import 'package:hamazh_auth/utls/theme/light_theme.dart';
import 'package:hamazh_auth/views/splash/screen/splash_screen.dart';

import 'data/local_data/shared_preferences_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DioHelper.init();
  await SharedPreference.init();
  await ConnectionNotifierTools.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCuibt(),
      child: MaterialApp(
        title: 'News test',
        debugShowCheckedModeBanner: false,
        theme: lightTheme(context),
        home: const SplashScreen(),
      ),
    );
  }
}
