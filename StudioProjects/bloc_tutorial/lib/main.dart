import 'package:bloc_tutorial/logic/cubit/settings_cubit.dart';
import 'package:bloc_tutorial/presentation/router/router.dart';
import 'package:bloc_tutorial/presentation/screens/home_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'logic/cubit/counter_cubit.dart';
import 'logic/cubit/internet_cubit.dart';
import 'logic/utility/app_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationCacheDirectory(),
  );

  Bloc.observer = AppBlocObserver();


  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final AppRoute route = AppRoute();

  @override
  Widget build(BuildContext context)
   => _buildMultiBlocProvider();


  Widget _buildMultiBlocProvider() => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => InternetCubit(),
      ),
      BlocProvider(
        create: (_) => CounterCubit(),
      ),
      BlocProvider(
        create: (_) => SettingsCubit(),
      )
    ],
    child: _buildMaterialApp(),
  );

  Widget _buildMaterialApp() => MaterialApp(
    title: 'Flutter Demo',
    onGenerateRoute: route.onGeneratedRoute,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
  );
}
