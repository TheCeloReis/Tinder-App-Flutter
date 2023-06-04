import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

void showSnackBar(GlobalKey<ScaffoldState> globalKey, String message) {
  final snackBar = SnackBar(content: Text(message));
  globalKey.currentState.hideCurrentSnackBar();
  globalKey.currentState.showSnackBar(snackBar);
}

String compareAndCombineIds(String userID1, String userID2) {
  if (userID1.compareTo(userID2) < 0) {
    return userID2 + userID1;
  } else {
    return userID1 + userID2;
  }
}

String convertEpochMsToDateTime(int epochMs) {
  int oneDayInMs = 86400000;
  var date = DateTime.fromMillisecondsSinceEpoch(epochMs);
  int currentTimeMs = DateTime.now().millisecondsSinceEpoch;

  initializeDateFormatting(
      'pt_BR', null); // Initialize the date formatting for the Brazilian locale

  if ((currentTimeMs - epochMs) >= oneDayInMs) {
    return '${DateFormat('dd/MM/yyyy', 'pt_BR').format(date)}  ${DateFormat.jm('pt_BR').format(date)}';
  } else {
    return DateFormat.jm('pt_BR').format(date);
  }
}
