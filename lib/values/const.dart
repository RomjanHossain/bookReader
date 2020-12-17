import 'dart:math';

import 'package:flutter/material.dart';

const kTitle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w400,
  fontSize: 20,
);

const kSubtitle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.w300,
  fontSize: 16,
  letterSpacing: 2,
);

kToggleSwap(val) {
  val ? val = !val : val = !val;
}

const tabbarTextColor = TextStyle(color: Colors.black);

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
