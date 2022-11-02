import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Network/local/cache_helper.dart';
import '../../Shared/Drawer/home_drawer.dart';
import '../../Shared/constants/back_ground.dart';
import '../../Shared/image_widgets/asset_image.dart';
import '../../Shared/navigation/navigate_final_to.dart';
import '../Auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    Future.delayed(const Duration(seconds: 5), () {
      navigateFinalTo(
          context,
          CacheHelper.getData(key: 'token') == null
              ? LoginScreen()
              : const HomeDrawer()); //  PharmaciesScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: SafeArea(
            child: Scaffold(
                backgroundColor: HexColor("#FFFFFF"),
                body: Stack(children: [
                  backgroundImage(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height),
                  Center(child: myImage('assets/images/splash/Picture1.png')),
                ]))));
  }
}
