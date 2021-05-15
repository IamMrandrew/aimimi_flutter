import 'package:flutter/material.dart';

import 'colors.dart';

TextStyle selectButtonTextStyle(bool selected) {
  return TextStyle(color: selected ? Colors.white : monoPrimaryColor);
}

ButtonStyle selectButtonStyle(bool selected) {
  return ElevatedButton.styleFrom(
    primary: selected ? themeColor : backgroundColor,
    shadowColor: Colors.transparent,
    elevation: 0,
    padding: EdgeInsets.symmetric(horizontal: 20),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}
