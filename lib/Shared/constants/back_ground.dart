import 'package:flutter/material.dart';

Widget backgroundImage(width, height) => Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Login3/background.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
