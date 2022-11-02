import 'package:flutter/material.dart';

import '../image_widgets/network.dart';

Widget oneOrderItems(BuildContext context, VoidCallback callback,
        String imagesrc, int index) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Align(
            alignment: Alignment.center,
            child: TextButton(
                onPressed: callback,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * .5,
                  height: 200,
                  child: defaultNetworkImg(context, double.infinity,
                      double.infinity, imagesrc, BoxFit.cover, 5, 1),
                )),
          ),
        ],
      ),
    );
