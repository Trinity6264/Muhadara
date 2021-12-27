import 'package:flutter/material.dart';
import 'package:muhadara/shared/collor_pallet.dart';

final inputDec = InputDecoration(
  border: InputBorder.none,
  filled: true,
  fillColor: baseColor,
  enabled: true,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  focusedBorder: const OutlineInputBorder(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(20),
      topLeft: Radius.circular(20),
    ),
    borderSide: BorderSide(color: secColor, style: BorderStyle.solid),
  ),
);
