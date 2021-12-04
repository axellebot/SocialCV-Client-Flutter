import 'package:flutter/material.dart';
import 'package:social_cv_client_flutter/src/presentation/commons/defaults.dart';

String getInitials(String nameString) {
  if (nameString.isEmpty) return ' ';

  final List<String> nameArray =
      nameString.replaceAll(RegExp(r'\s+\b|\b\s'), ' ').split(' ');
  final String initials =
      ((nameArray[0])[0] != null ? (nameArray[0])[0] : ' ') +
          (nameArray.length == 1 ? ' ' : (nameArray[nameArray.length - 1])[0]);

  return initials;
}

List<DropdownMenuItem<String>> getDropDownMenuElementPerPage() {
  final List<String> _values = [
    kCVItemsPerPage1,
    kCVItemsPerPage2,
    kCVItemsPerPage3,
    kCVItemsPerPage4
  ];
  final List<DropdownMenuItem<String>> items = [];
  for (String value in _values) {
    items.add(DropdownMenuItem(value: value, child: Text(value)));
  }
  return items;
}
