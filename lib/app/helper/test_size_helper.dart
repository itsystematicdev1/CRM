import 'package:flutter/material.dart';

double getFontSize(BuildContext context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = scaleFactor * fontSize;

  double lowerLimit = fontSize * 0.8;
  double upperLimit = fontSize * 1.2;

  responsiveFontSize.clamp(lowerLimit, upperLimit);
  return responsiveFontSize;
}

double getScaleFactor(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  if (width < 600) {
    return width / 400;
  } else if (width < 900) {
    return width / 700;
  } else {
    return width / 1000;
  }
}
