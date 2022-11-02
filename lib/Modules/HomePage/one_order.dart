// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Cubit/cubit_delivery.dart';
import '../../Cubit/states.dart';
import '../../Shared/Appbar/app_bar_icon_back.dart';
import '../../Shared/HomeOrders/one_order_caer_items.dart';
import '../../Shared/HomeOrders/one_order_selected.dart';
import '../../Shared/HomeOrders/price.dart';
import '../../Shared/constants/app_bar_icons.dart';
import '../../Shared/constants/back_ground.dart';
import '../../Shared/image_widgets/asset_image.dart';
import '../../Shared/loading/loading_screen.dart';
import '../../Shared/navigation/navigate_to.dart';
import '../notification/notification.dart';
import 'slide_show.dart';

class OneOrderScreen extends StatelessWidget {
  const OneOrderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
              child: cubit.oneOrdersModel == null
                  ? loadingWidget()
                  : Scaffold(
                      appBar: myAppBarWithBack(
                          "الطلب رقم ${cubit.oneOrdersModel!.data!.id.toString()}",
                          () {
                        navigateTo(context, const NotificationScreen());
                      }, appBarIconNotification, context),
                      body: Stack(
                        children: [
                          backgroundImage(MediaQuery.of(context).size.width,
                              MediaQuery.of(context).size.height),
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  /*InkWell(
                                    onTap: (){ },
                                      child: Image.asset("assets/images/order/bg-map.png")),
                                  */
                                  Row(
                                    children: [
                                      myImage(
                                          "assets/images/order/Icon feather-map-pin.png"),
                                      const SizedBox(width: 14),
                                      Text(
                                        "التوصيل الي : ${cubit.oneOrdersModel!.data!.client!.name}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: HexColor("#404040")),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    cubit.oneOrdersModel!.data!.address
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    cubit.oneOrdersModel!.data!.client!.phone!
                                        .toString(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 5),
                                  TextButton(
                                      onPressed: () {
                                        cubit.launchMap(
                                            lat: cubit
                                                .oneOrdersModel!.data!.latitude
                                                .toString(),
                                            lng: cubit
                                                .oneOrdersModel!.data!.longitude
                                                .toString());
                                      },
                                      child: const Text("تفاصيل العنوان")),
                                  /*Row(
                                    children: [
                                      myImage("assets/images/order/phamacy.png"),
                                      const SizedBox(width: 14),
                                      const Align(
                                        alignment: Alignment.centerRight,
                                        child: Text("عنوان الصيدلية",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 16)),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5),
                                  const Text("مدنية نصر -التجمع الخامس - شارع افريقيا السينمائى",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600)),
                                  */
                                  const SizedBox(height: 10),
                                  if (cubit.oneOrdersModel!.data!.type!
                                          .toInt() ==
                                      1)
                                    const Align(
                                      alignment: Alignment.centerRight,
                                      child: Text("المنتجات",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  if (cubit.oneOrdersModel!.data!.type!
                                          .toInt() ==
                                      1)
                                    ListView.builder(
                                      itemCount: cubit.oneOrdersModel!.data!
                                          .medicines!.length,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return oneOrderItemSelected(
                                            context,
                                            cubit.oneOrdersModel!.data!
                                                .medicines![index].photo
                                                .toString(),
                                            cubit.oneOrdersModel!.data!
                                                .medicines![index].name
                                                .toString(),
                                            cubit.oneOrdersModel!.data!
                                                .medicines![index].pivot!.amount
                                                .toString(),
                                            cubit.oneOrdersModel!.data!
                                                .medicines![index].pivot!.price
                                                .toString(),
                                            3);
                                      },
                                    ),
                                  if (cubit.oneOrdersModel!.data!.type!
                                          .toInt() ==
                                      0)
                                    const Align(
                                      alignment: Alignment.centerRight,
                                      child: Text("الروشتة",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  if (cubit.oneOrdersModel!.data!.type!
                                          .toInt() ==
                                      0)
                                    if (cubit.oneOrdersModel!.data!
                                            .description !=
                                        null)
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Text(
                                            cubit.oneOrdersModel!.data!
                                                .description
                                                .toString(),
                                            style: const TextStyle(
                                                fontSize: 20,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                  if (cubit.oneOrdersModel!.data!.type!
                                          .toInt() ==
                                      0)
                                    if (cubit.oneOrdersModel!.data!.photo !=
                                        null)
                                      ListView.builder(
                                        itemCount: 1,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return oneOrderItems(
                                              context,
                                              () => navigateTo(
                                                  context,
                                                  ImageSlideShow(
                                                      image: cubit
                                                          .oneOrdersModel!
                                                          .data!
                                                          .photo
                                                          .toString())),
                                              cubit.oneOrdersModel!.data!.photo
                                                  .toString(),
                                              index);
                                        },
                                      ),
                                  priceSumary(
                                      cubit.oneOrdersModel!.data!.price,
                                      cubit.oneOrdersModel!.data!.couponAmount,
                                      cubit.oneOrdersModel!.data!.deliveryPrice,
                                      cubit.oneOrdersModel!.data!
                                          .priceAfterOffer),
                                  const SizedBox(height: 25),
                                  if (cubit
                                          .oneOrdersModel!.data!.deliveryType !=
                                      1)
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        if (cubit
                                                .oneOrdersModel!.data!.status !=
                                            5)
                                          InkWell(
                                            onTap: () => cubit.startOrder(
                                                cubit.oneOrdersModel!.data!.id!
                                                    .toString(),
                                                context),
                                            child: Container(
                                              width: 120,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: HexColor("#EFFCF6"),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "توصيل",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: HexColor("#04914F")),
                                              )),
                                            ),
                                          ),
                                        const SizedBox(width: 15),
                                        if (cubit
                                                .oneOrdersModel!.data!.status ==
                                            5)
                                          InkWell(
                                            onTap: () => cubit.endOrder(
                                                cubit.oneOrdersModel!.data!.id!
                                                    .toString(),
                                                context),
                                            child: Container(
                                              width: 120,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: HexColor("#FCEFEF"),
                                              ),
                                              child: Center(
                                                  child: Text(
                                                "تم التوصيل",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.w600,
                                                    color: HexColor("#FF1717")),
                                              )),
                                            ),
                                          ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
        );
      },
    );
  }
}
