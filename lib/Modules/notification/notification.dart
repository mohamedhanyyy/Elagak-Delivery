import 'package:elagk_deivery/Cubit/cubit_delivery.dart';
import 'package:elagk_deivery/Cubit/states.dart';
import 'package:elagk_deivery/Modules/HomePage/one_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Shared/Appbar/noraml_app_bar.dart';
import '../../Shared/HomeOrders/notification.dart';
import '../../Shared/navigation/navigate_to.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

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
              appBar: noramlAppBar("التنبيهات"),
              body: SingleChildScrollView(
                child: ListView.builder(
                  itemCount: cubit.allOrdersModel!.data!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return notificationUtem(
                      cubit.allOrdersModel!.data![index].id.toString(),
                      cubit.allOrdersModel!.data![index].date.toString(),
                      () {
                        cubit.getOneOrders(
                            cubit.allOrdersModel!.data![index].id.toString());
                        navigateTo(context, const OneOrderScreen());
                      },
                    );
                  },
                ),
              ),
            )));
      },
    );
  }
}
