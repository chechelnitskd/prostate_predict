import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:prostate_predict/data/database_helpers.dart';
import 'package:prostate_predict/data/user_data.dart';
import 'package:prostate_predict/widgets/history_widgets.dart';
import 'package:prostate_predict/widgets/screen_widgets.dart';
import 'package:provider/provider.dart';

class RiskHistoryScreen extends StatefulWidget {
  const RiskHistoryScreen({Key? key}) : super(key: key);

  @override
  _RiskHistoryScreenState createState() => _RiskHistoryScreenState();
}

class _RiskHistoryScreenState extends State<RiskHistoryScreen> {

  final DatabaseHelper handler = DatabaseHelper.instance;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  Future<List<UserHistory>>? history;

  @override
  void initState() {
    super.initState();
    history = this.handler.queryAllHistory();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _key,
      appBar: ColorAppBar(context, _key),
      endDrawer: buildSideBar(context),
      body: //Column(
        //children: [
          /*Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text('Read'),
                  onPressed: () {
                    Provider.of<UserHistory>(context, listen: false).read();
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text('Save'),
                  onPressed: () {
                    Provider.of<UserHistory>(context, listen: false)
                        .save('Test', 3.5);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  child: Text('Show'),
                  onPressed: () {
                    Provider.of<UserHistory>(context, listen: false)
                    .printAll();
                  },
                ),
              ),
            ],
          ),*/
          FutureBuilder<List<UserHistory>>(
            future: history,
            initialData: [],
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, i) {
                    final entry = snapshot.data![i];
                    final entryKey = ValueKey<int>(entry.id!);
                    return Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actions: <Widget>[
                        IconSlideAction(
                          caption: 'Archive test',
                          icon: Icons.archive,
                          onTap: () {
                            print('Archive');
                          },
                        )
                      ],
                      actionExtentRatio: 1 / 5,
                      direction: Axis.horizontal,
                      child: Card(
                          child: ListTile(
                            contentPadding: EdgeInsets.all(8.0),
                            title: Text(snapshot.data![i].riskType!),
                            subtitle: Text(snapshot.data![i].riskScore!.toString()),
                          )
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError)  {
                return Text("error!");
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        //],
      //),
    );
  }
}
