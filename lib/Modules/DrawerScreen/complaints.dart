import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Cubit/cubit_delivery.dart';
import '../../Cubit/states.dart';
import '../../Shared/Appbar/fixxed_app_bar.dart';
import '../../Shared/Buttons/button_class.dart';
import '../../Shared/TextForm/text_form.dart';
import '../../Shared/constants/back_ground.dart';

var titleController = TextEditingController();
var bodyController = TextEditingController();
var nameController = TextEditingController();
var emailController = TextEditingController();
var phoneController = TextEditingController();

class ComplaintsScreen extends StatelessWidget {
  ComplaintsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: fixxedAppBar("مقترحات و شكاوى"),
              body: Stack(
                children: [
                  backgroundImage(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height),
                  SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            const SizedBox(height: 35),
                            myTextFormField(
                                context: context,
                                controller: titleController,
                                label: const Text("عنوان الشكوى")),
                            const SizedBox(height: 20),
                            myTextFormField(
                              context: context,
                              controller: bodyController,
                              inputType: TextInputType.multiline,
                              lines: 5,
                              label: Text("تفاصيل الشكوى",
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: HexColor("#A5A5A5"))),
                            ),
                            const SizedBox(height: 35),
                            cubit.isLoadingAuth
                                ? CircularProgressIndicator(
                                    color: HexColor("#04914F"))
                                : myButtonClass(
                                    title: "ارسال الطلب",
                                    color: "#1D71B8",
                                    pressAction: () {
                                      cubit
                                          .contactUS(
                                              body: bodyController.text,
                                              title: titleController.text,
                                              context: context)
                                          .then((value) {
                                        bodyController.clear();
                                        titleController.clear();
                                        debugPrint(
                                            "emailController is : ${emailController.text} \n nameController is : ${nameController.text} \n phoneController is : ${phoneController.text} \n bodyController is : ${bodyController.text} \n titleControlleris : ${titleController.text} ");
                                      });
                                    })
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
