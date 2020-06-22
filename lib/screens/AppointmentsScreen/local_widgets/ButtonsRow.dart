import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../models/Appointment.dart';
import '../local_widgets/IconButton.dart';
import '../../ChatScreen/screens/ChatScreen.dart';

Widget buttonsRow(BuildContext context, Appointment appointment) {
  return Padding(
    padding: const EdgeInsets.all(5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        iconButton(
          context,
          icon: LineIcons.comment_o,
          text: 'Chat',
          onPress: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (ctx) => ChatScreen(appointment),
          )),
        ),
        iconButton(
          context,
          icon: LineIcons.file_text_o,
          text: 'Docs',
          onPress: () {}
        ),
      ],
    ),
  );
}