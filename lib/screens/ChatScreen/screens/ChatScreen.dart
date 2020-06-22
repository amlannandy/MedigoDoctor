import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../local_widgets/ChatAppBar.dart';
import '../../../models/Appointment.dart';
import '../local_widgets/MessagesStream.dart';
import '../local_widgets/InputField.dart';
import '../../../services/AppointmentProvider.dart';

class ChatScreen extends StatefulWidget {

  final Appointment appointment;

  ChatScreen(this.appointment);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  final _textController = TextEditingController();

  @override
  void initState() {
    getCameraAndMicPermission();
    AppointmentProvider.updateLastSeen(widget.appointment.id);
    super.initState();
  }

  void getCameraAndMicPermission() async {
    var status = await PermissionHandler().requestPermissions([PermissionGroup.camera, PermissionGroup.microphone]);
    print(status);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: chatAppBar(context, widget.appointment.id, widget.appointment.userId),
      body: Column(
        children: <Widget>[
          MessagesStream(widget.appointment),
          inputField(
            context: context,
            appointmentId: widget.appointment.id,
            userId: widget.appointment.doctorId,
            controller: _textController,
          ),
        ],
      ),
    );
  }

}