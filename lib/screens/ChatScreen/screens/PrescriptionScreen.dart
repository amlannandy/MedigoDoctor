import 'package:flutter/material.dart';

import '../../../models/Prescription.dart';
import '../local_widgets/CustomHeader.dart';
import '../local_widgets/PrescriptionInput.dart';
import '../../../services/AppointmentProvider.dart';
import '../../../services/UserDatabaseService.dart';
import '../../../screens/HomeScreen/local_widgets/CustomAppBar.dart';

class PrescriptionScreen extends StatefulWidget {

  final String appointmentId;

  PrescriptionScreen(this.appointmentId);

  @override
  _PrescriptionScreenState createState() => _PrescriptionScreenState();
}

class _PrescriptionScreenState extends State<PrescriptionScreen> {

  final UserDatabaseService userDatabaseService = UserDatabaseService();
  final _controller = TextEditingController();

  void getData() async {
    Prescription prescription = await userDatabaseService.getPrescription(widget.appointmentId);
    setState(() => _controller.text = prescription.data);
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        AppointmentProvider.updatePrescription(widget.appointmentId, _controller.text);
        return Future.value(true);
      },
      child: Scaffold(
        appBar: customAppBar(context, 'Prescription', popCall: () => AppointmentProvider.updatePrescription(widget.appointmentId, _controller.text)),
        backgroundColor: Colors.white,
        body: Column(
          children: <Widget>[
            customHeader(context),
            PrescriptionField(_controller),
            customFooter(context),
          ],
        ),
      ),
    );
  }
}