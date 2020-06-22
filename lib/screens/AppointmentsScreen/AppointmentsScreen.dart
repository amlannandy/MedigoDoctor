import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../../widgets/LoadingSpinner.dart';
import './local_widgets/AppointmentsList.dart';

class AppointmentsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<FirebaseUser>(context);

    return Scaffold(
      body: user == null ? loadingSpinner(context) : appointmentsList(context, user.uid),
    );
  }
  
}