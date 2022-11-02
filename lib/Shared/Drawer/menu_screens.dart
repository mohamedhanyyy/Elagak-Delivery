import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'menu_item.dart';

class MenuItems {
  static const homepage = MyMenuItem('الصفحة الرئيسية', Icons.home);
  static const profile = MyMenuItem('البروفايل', Icons.call);
  static const contactUs = MyMenuItem('اتصل بنا', Icons.call);
  static const aboutUs = MyMenuItem('عن الابليكشن', Icons.info);
  static const complaints = MyMenuItem('شكاوي', Icons.call);

  static const all = <MyMenuItem>[
    homepage,
    profile,
    contactUs,
    aboutUs,
    complaints
  ];
}

class MenuScreen extends StatelessWidget {
  final MyMenuItem currentItem;
  final ValueChanged<MyMenuItem> onSelectedItem;

  const MenuScreen(
      {Key? key, required this.currentItem, required this.onSelectedItem})
      : super(key: key);

  Widget buildMenuItem(MyMenuItem item) => ListTileTheme(
        selectedColor: Colors.grey[200],
        child: ListTile(
          selectedColor: Colors.white,
          selected: currentItem == item,
          minLeadingWidth: 20,
          leading: Icon(item.icon),
          title: Text(item.title),
          onTap: () => onSelectedItem(item),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: HexColor("#04914F"),
          body: SafeArea(
              child: Column(
            children: [
              const Spacer(),
              ...MenuItems.all.map(buildMenuItem).toList(),
              const Spacer(
                flex: 2,
              ),
            ],
          )),
        ));
  }
}
