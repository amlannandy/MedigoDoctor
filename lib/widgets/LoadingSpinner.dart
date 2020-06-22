import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

Widget loadingSpinner(BuildContext context) {
  return Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.white,
      valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor),
    ),
  );
}