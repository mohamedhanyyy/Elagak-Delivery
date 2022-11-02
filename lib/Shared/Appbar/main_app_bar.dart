import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import '../Drawer/menu_widget.dart';

PreferredSizeWidget myAppBar(String title, Function()? buttonAction,
        Widget widget, BuildContext context) =>
    AppBar(
      iconTheme: const IconThemeData(color: Colors.black),
      title: Text(title,
          style: TextStyle(
              fontSize: 22,
              color: HexColor("#000000"),
              fontWeight: FontWeight.w500)),
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: true,
      actions: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: InkWell(
            onTap: buttonAction,
            child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                    color: HexColor("#FFFFFF"),
                    border: Border.all(color: HexColor("#F2F3F8"), width: 1),
                    borderRadius: BorderRadius.circular(15)),
                child: widget),
          ),
        ),
      ],
      leading: const MenuWidget(),
    );
