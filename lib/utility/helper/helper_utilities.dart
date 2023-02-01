import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import 'const_utility.dart';

class Utilities {
  String locale(BuildContext context) =>
      Localizations.localeOf(context).toString();

  /// Currency formatter for NGN.
  NumberFormat ngnFormat(BuildContext context, {int dec = 2}) {
    return NumberFormat.currency(
      locale: locale(context),
      name: '$ngn',
      decimalDigits: dec,
    );
  }

  /// Percent formatter with two decimal points.
  NumberFormat percentFormat(BuildContext context, {int decimalDigits = 2}) {
    return NumberFormat.decimalPercentPattern(
      locale: locale(context),
      decimalDigits: decimalDigits,
    );
  }
}

/// get a unique random string id at call
String getRandomUID() {
  var uuid = const Uuid();
  return uuid.v4();
}
