// ignore_for_file: must_be_immutable

import 'package:elagk_deivery/Shared/loading/loading_screen.dart';
import 'package:elagk_deivery/Shared/navigation/navigate_to.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Cubit/cubit_delivery.dart';
import '../../Cubit/states.dart';
import '../../Shared/Appbar/log_out_app_bar.dart';
import '../../Shared/HomeOrders/orders_items.dart';
import '../../Shared/constants/app_bar_icons.dart';
import '../../Shared/constants/back_ground.dart';
import 'one_order.dart';

class AllOrders extends StatelessWidget {
  AllOrders({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
                child: cubit.allOrdersModel == null
                    ? loadingWidget()
                    : RefreshIndicator(
                        onRefresh: () => cubit.getAboutUs(),
                        child: Scaffold(
                          appBar: logOutAppBar(
                              "الطلبات", appBarIconLogout, context, cubit),
                          body: Stack(
                            children: [
                              backgroundImage(MediaQuery.of(context).size.width,
                                  MediaQuery.of(context).size.height),
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    /*Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: myTextFormField(
                              controller: searchController,
                              context: context,
                              focuscolor: Colors.white,
                              hint: "ابحث ...",
                              hintColor: Colors.black,
                              inputType: TextInputType.text,
                              suffixIcon: InkWell(
                                onTap: (){},
                                child: Container(
                                  width: 35, height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color.fromARGB(255, 007, 165, 91),
                                        Color.fromARGB(255, 29, 113, 184)
                                      ],
                                    )
                                  ),
                                  child: const Icon(Icons.search, color: Colors.white),
                                ),
                              )
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 40,
                            color: Colors.transparent,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: 3,
                              itemBuilder: (BuildContext context, int index) {
                                return categories((){}, "order status");
                              },
                            )
                          ),
                          const SizedBox(height: 20),*/
                                    ListView.builder(
                                      itemCount:
                                          cubit.allOrdersModel!.data!.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return orderItem(
                                          cubit.allOrdersModel!.data![index].id
                                              .toString(),
                                          cubit
                                              .allOrdersModel!.data![index].date
                                              .toString(),
                                          () {
                                            cubit.getOneOrders(cubit
                                                .allOrdersModel!.data![index].id
                                                .toString());
                                            navigateTo(context,
                                                const OneOrderScreen());
                                          },
                                          cubit
                                              .allOrdersModel!.data![index].type
                                              .toString(),
                                          cubit.allOrdersModel!.data![index]
                                              .status
                                              .toString(),
                                          cubit.allOrdersModel!.data![index]
                                              .address
                                              .toString(),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )));
      },
    );
  }
}
