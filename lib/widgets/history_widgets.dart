import 'package:flutter/material.dart';
import 'package:prostate_predict/data/user_data.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HistoryCard extends StatelessWidget {
  final UserHistory user;

  HistoryCard(this.user);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actions: <Widget>[
        IconSlideAction(
          caption: 'Archive test',
          icon: Icons.archive,
          onTap: () => print('Archive'),
        )
      ],
      actionExtentRatio: 1 / 5,
      direction: Axis.horizontal,
      child: Card(
          child: ListTile(
          contentPadding: EdgeInsets.all(8.0),
          title: Text(user.riskType!),
          subtitle: Text(user.riskScore!.toString()),
          )
      ),
    );
  }
}
