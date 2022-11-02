import 'package:elagk_deivery/Cubit/cubit_delivery.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Cubit/states.dart';
import '../../Shared/AppDataWidget/contact_us_container.dart';
import '../../Shared/Appbar/fixxed_app_bar.dart';
import '../../Shared/constants/back_ground.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
                child: Scaffold(
              appBar: fixxedAppBar("التواصل معانا"),
              body: Stack(
                children: [
                  backgroundImage(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          myContactContainer(
                              "assets/images/contact us/العنوان.png",
                              "العنوان",
                              "العنوان", () {
                            cubit.launchMap(
                                lat: cubit.aboutUsModel!.data!.latitude
                                    .toString(),
                                lng: cubit.aboutUsModel!.data!.longitude
                                    .toString());
                          }),
                          const SizedBox(height: 32),
                          myContactContainer(
                              "assets/images/contact us/whatsapp.png",
                              "What's App",
                              cubit.aboutUsModel!.data!.whatsapp.toString(),
                              () {
                            cubit.whatsAppOpen(
                                cubit.aboutUsModel!.data!.whatsapp.toString());
                          }),
                          const SizedBox(height: 32),
                          myContactContainer(
                              "assets/images/contact us/gmail.png",
                              "البريد الإلكتروني",
                              cubit.aboutUsModel!.data!.gmail.toString(), () {
                            cubit.sendingMails(
                                cubit.aboutUsModel!.data!.gmail.toString());
                          }),
                          const SizedBox(height: 32),
                          myContactContainer(
                              "assets/images/contact us/svgexport-6 (6).png",
                              "رقم الهاتف",
                              cubit.aboutUsModel!.data!.phone.toString(), () {
                            cubit.makePhoneCall(
                                cubit.aboutUsModel!.data!.phone.toString());
                          }),
                          const SizedBox(height: 32),
                          myContactContainer(
                              "assets/images/face.jpg",
                              "Facebook",
                              cubit.aboutUsModel!.data!.facebook.toString(),
                              () {
                            cubit.openFaceBook(
                                cubit.aboutUsModel!.data!.facebook.toString());
                          }),
                          const SizedBox(height: 32),
                          myContactContainer(
                              "assets/images/insta.png",
                              "انستاجرام",
                              cubit.aboutUsModel!.data!.instagram.toString(),
                              () {
                            cubit.launchInstagram(
                                cubit.aboutUsModel!.data!.instagram.toString(),
                                cubit.aboutUsModel!.data!.instagram.toString());
                          }),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )));
      },
    );
  }
}
