import 'package:flutter/material.dart';
import 'package:prostate_predict/data/data_constants.dart';
import 'package:prostate_predict/data/user_data.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'homepage_widgets.dart';

class HistoryCard extends StatelessWidget {
  final UserHistory user;

  HistoryCard(this.user);

  @override
  Widget build(BuildContext context) {
    String riskTypeString =
      user.riskType == RiskCalculatorType.PROSTATE_CALCULATOR ?
      prostateCancer :
      skinCancer;

    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Delete Entry',
          icon: Icons.delete,
          onTap: () => print('Delete pressed'),
        )
      ],
      actionExtentRatio: 1 / 5,
      direction: Axis.horizontal,
      child: Card(
          child: ListTile(
          contentPadding: EdgeInsets.all(8.0),
          title: Text(
            riskTypeString),
          subtitle: Text("Risk score: ${user.riskScore!.toString()}"),
          )
      ),
    );
  }
}
