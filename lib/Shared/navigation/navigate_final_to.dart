import 'package:flutter/material.dart';

void navigateFinalTo(context, widget) => Navigator.pushReplacement(
    context, MaterialPageRoute(builder: (context) => widget));
