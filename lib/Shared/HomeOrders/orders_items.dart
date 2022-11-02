import 'package:flutter/material.dart';

Widget orderItem(
  String orderNumber,
  String orderDate,
  GestureTapCallback pressAction,
  String type,
  String status,
  String address,
) =>
    Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.grey[200]),
          child: ListTile(
            onTap: pressAction,
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: SizedBox(
                  width: 52,
                  height: 52,
                  child: ClipOval(
                      child: Image.asset("assets/images/order/4140048.png"))),
            ),
            title: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text("الطلب رقم $orderNumber",
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            ),
            subtitle: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/profile/Icon feather-map-pin.png"),
                  const SizedBox(width: 10),
                  Expanded(
                      child: Text(address,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 14))),
                ]),
            trailing: Text(
              orderDate,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ));
