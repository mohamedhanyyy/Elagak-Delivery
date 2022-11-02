// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Cubit/cubit_delivery.dart';
import '../../Cubit/states.dart';
import '../../Shared/Buttons/button_auth.dart';
import '../../Shared/TextForm/text_form.dart';
import '../../Shared/constants/back_ground.dart';
import '../../Shared/constants/logo.dart';

var phoneController = TextEditingController();
var passwordController = TextEditingController();

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var size, height, width;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
              child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Stack(
              children: [
                backgroundImage(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height),
                SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Stack(children: [
                        backgroundImage(width, height),
                        Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            logo,
                            const SizedBox(height: 26),
                            const Text("تسجيل الدخول",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700)),
                            const SizedBox(height: 16),
                            Text("برجاء قم بتسجيل الدخول او بإنشاء حساب",
                                style: TextStyle(
                                    fontSize: 18, color: HexColor("#A5A5A5"))),
                            const SizedBox(height: 51),
                            myTextFormField(
                              controller: phoneController,
                              context: context,
                              inputType: TextInputType.emailAddress,
                              label: Text("اسم المستخدم",
                                  style: TextStyle(
                                      color: HexColor("#A5A5A5"),
                                      fontSize: 14)),
                            ),
                            const SizedBox(height: 26),
                            myTextFormField(
                              controller: passwordController,
                              context: context,
                              inputType: TextInputType.visiblePassword,
                              obsecure: true,
                              lines: 1,
                              label: Text("كلمة المرور",
                                  style: TextStyle(
                                      color: HexColor("#A5A5A5"),
                                      fontSize: 14)),
                            ),
                            const SizedBox(height: 85),
                            cubit.isLoadingAuth
                                ? CircularProgressIndicator(
                                    color: HexColor("#04914F"))
                                : myButton("تسجيل الدخول", "#3193E5", () {
                                    cubit.login(
                                        password: passwordController.text,
                                        email: phoneController.text,
                                        context: context);
                                  }),
                          ],
                        ))
                      ])),
                ),
              ],
            ),
          )),
        );
      },
    );
  }
}
