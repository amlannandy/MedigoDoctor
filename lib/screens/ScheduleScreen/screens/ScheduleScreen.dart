import 'package:flutter/material.dart';

import '../local_widgets/ScheduleCard.dart';
import '../../../services/ScheduleProvider.dart';

class ScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final dates = ScheduleProvider.getNext7Days();

    return ListView.builder(
      itemBuilder: (ctx, index) => scheduleCard(context, dates[index]),
      itemCount: dates.length,
    );
  }
}