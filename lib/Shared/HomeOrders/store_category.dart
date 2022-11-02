import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget categories(
  VoidCallback? buttonAction,
  String categoryName,
) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: InkWell(
        onTap: () {
          buttonAction;
        },
        child: Container(
            width: 90,
            height: 35,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: HexColor("#1D71B8"),
            ),
            child: Center(
              child: Text(categoryName,
                  style: const TextStyle(fontSize: 12, color: Colors.white)),
            )),
      ),
    );
