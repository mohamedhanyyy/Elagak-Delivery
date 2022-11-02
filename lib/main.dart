import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Cubit/cubit_delivery.dart';
import 'Modules/notification/notification.dart';
import 'Modules/opening/offline.dart';
import 'Modules/opening/splash.dart';
import 'Network/local/cache_helper.dart';
import 'Shared/constants/global_key.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  debugPrint("Notification ");
  BuildContext globalContext = Global.materialKey.currentContext!;
  Navigator.of(globalContext).pushNamed("notification");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: HexColor("#04914F")));

  // foreground fcm
  FirebaseMessaging.onMessage.listen((event) {
    Fluttertoast.showToast(
      msg: "there is an update of Notification go and check it",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  });

  // when click on notification to open app
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    BuildContext globalContext = Global.materialKey.currentContext!;
    Navigator.of(globalContext).pushNamed("notification");
  });

  // background fcm
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await CacheHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeCubit()..getAboutUs(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        theme: ThemeData(fontFamily: 'DIN Next LT Arabic'),
        title: "3elagk-delivery",
        color: HexColor("#04914F"),
        routes: {
          "notification": (_) => const NotificationScreen(),
        },
        home: OfflineBuilder(
          connectivityBuilder: (
            BuildContext context,
            ConnectivityResult connectivity,
            Widget child,
          ) {
            final bool connected = connectivity != ConnectivityResult.none;
            if (connected) {
              return const SplashScreen();
            } else {
              return const OfflineWidget();
            }
          },
          child: const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
