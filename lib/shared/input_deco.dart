import 'package:flutter/material.dart';
import 'package:muhadara/shared/collor_pallet.dart';

const InputDecoration inputDecoration = InputDecoration(
  enabled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      style: BorderStyle.solid,
      color: primaryColor,
      width: 2.0,
    ),
  ),
  focusColor: primaryColor,
  fillColor: secColor,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      style: BorderStyle.solid,
      color: primaryColor,
      width: 2.0,
    ),
  ),
);
