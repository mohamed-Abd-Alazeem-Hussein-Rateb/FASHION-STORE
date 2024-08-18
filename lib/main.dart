import 'package:flutter/material.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/authentication_screen/auth_cubit/auth_cubit.dart';
import 'package:flutter_application_1/contuc_cubit/contuctus_cubit.dart';
import 'package:flutter_application_1/cubit_home/homedata_cubit.dart';
import 'package:flutter_application_1/layouts/layout_cubit.dart';
import 'package:flutter_application_1/screens/register_screen.dart';
import 'package:flutter_application_1/screens/layout_screen.dart';
import 'package:flutter_application_1/shared/network/local_network.dart';
import 'package:flutter_application_1/widget/costant_color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/widget/bloc_observer.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheNetwork.caheIntilization();
  token = CacheNetwork.getCache(key: 'token');
  changePassword = CacheNetwork.getCache(key: 'password');
  print('password  $changePassword');
  print('token  $token');
   Bloc.observer = SimpleBlocObserver();
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const EcomerceApp(),
  ));
}

class EcomerceApp extends StatelessWidget {
  const EcomerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit()..GetDataBanner()),
        BlocProvider(create: (context) => LayoutCubit()..getUserData()..GetDataCategory()),
        BlocProvider(create: (context) => ContuctusCubit()..FetshContactUs()),
        BlocProvider(create: (context) => HomedataCubit()..GetHomeData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: DevicePreview.appBuilder,
        locale: DevicePreview.locale(context),
        home: token != null && token != '' ? LayoutScreen() : RegisterScreen(),
      ),
    );
  }
}
