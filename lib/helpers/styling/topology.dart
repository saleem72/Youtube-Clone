//

import 'package:flutter/material.dart';

import 'pallet.dart';

class Topology {
  Topology._();

  static const TextStyle bottomBar = TextStyle(
    fontSize: 12,
    color: Pallet.headerIconColor,
  );

  static const TextStyle title = TextStyle(
    color: Pallet.primaryTextColor,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle subTitle = TextStyle(
    color: Pallet.primaryTextColor,
    fontSize: 16,
    // fontWeight: FontWeight.w400,
  );

  static const TextStyle body = TextStyle(
    color: Pallet.primaryTextColor,
    fontSize: 14,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: Pallet.secondaryTextColor,
  );
}
