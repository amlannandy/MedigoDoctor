import 'package:flutter/material.dart';

import '../../../models/MedicalReport.dart';
import '../local_widgets/CustomHeader.dart';
import '../local_widgets/MedicalReportField.dart';
import '../../../services/UserDatabaseService.dart';
import '../../../screens/HomeScreen/local_widgets/CustomAppBar.dart';

class MedicalReportScreen extends StatefulWidget {

  final String appointmentId;

  MedicalReportScreen(this.appointmentId);

  @override
  _MedicalReportScreenState createState() => _MedicalReportScreenState();
}

class _MedicalReportScreenState extends State<MedicalReportScreen> {

  final UserDatabaseService userDatabaseService = UserDatabaseService();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Medical Report'),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          customHeader(context),
          StreamBuilder<MedicalReport>(
            stream: userDatabaseService.streamMedicalReport(widget.appointmentId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active && snapshot.hasData) {
                final report = snapshot.data;
                _controller.text = report.data;
              }
              return MedicalReportField(_controller);
            }
          ),
          customFooter(context),
        ],
      ),
    );
  }
}