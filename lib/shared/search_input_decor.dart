import 'package:flutter/material.dart';
import 'package:muhadara/shared/collor_pallet.dart';

InputDecoration searchInputDecor = InputDecoration(
  border: InputBorder.none,
  contentPadding: const EdgeInsets.only(top: 10),
  enabled: true,
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(
      color: primaryColor,
    ),
  ),
  fillColor: secColor,
  filled: true,
  hintText: '    Search',
  hintStyle: const TextStyle(color: primaryColor),
  focusColor: primaryColor,
  focusedBorder: OutlineInputBorder(
    borderSide: const BorderSide(
      color: primaryColor,
    ),
    borderRadius: BorderRadius.circular(20),
  ),
);
