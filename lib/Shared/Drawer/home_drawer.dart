import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../Cubit/cubit_delivery.dart';
import '../../Cubit/states.dart';
import 'menu_item.dart';
import 'menu_screens.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  MyMenuItem currentItem = MenuItems.homepage;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ZoomDrawer(
          isRtl: true,
          menuScreen: Builder(
            builder: (context) => MenuScreen(
                currentItem: currentItem,
                onSelectedItem: (item) {
                  setState(() => currentItem = item);
                  ZoomDrawer.of(context)!.close();
                }),
          ),
          mainScreen: cubit.getScreen(currentItem),
          style: DrawerStyle.defaultStyle,
          borderRadius: 10,
          angle: 0,
          menuBackgroundColor: HexColor("#04914F"),
          slideWidth: MediaQuery.of(context).size.width * 0.75,
        );
      },
    );
  }
}
