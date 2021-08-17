import 'package:flutter/material.dart';
import 'package:prostate_predict/data/database_helpers.dart';
import 'package:prostate_predict/data/user_data.dart';
import 'package:prostate_predict/widgets/screen_widgets.dart';
import 'package:provider/provider.dart';

class RiskHistoryScreen extends StatefulWidget {
  const RiskHistoryScreen({Key? key}) : super(key: key);

  @override
  _RiskHistoryScreenState createState() => _RiskHistoryScreenState();
}

class _RiskHistoryScreenState extends State<RiskHistoryScreen> {

  late DatabaseHelper handler;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  Future<List<UserHistory>>? history;

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHelper.instance;
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
          FutureBuilder(
            future: history,
            builder: (BuildContext context, AsyncSnapshot<List<UserHistory>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Dismissible(
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Icon(Icons.delete_forever),
                      ),
                      key: ValueKey<int>(snapshot.data![index].id!),
                      onDismissed: (DismissDirection direction) async {
                          /*setState(() {
                            //maybe this won't work?
                            snapshot.data!.remove(snapshot.data![index]);
                          });*/
                          await this.handler.delete(snapshot.data![index].id!);
                      },
                      child: Card(
                          child: ListTile(
                            contentPadding: EdgeInsets.all(8.0),
                            title: Text(snapshot.data![index].riskType!),
                            subtitle: Text(snapshot.data![index].riskScore!.toString()),
                          )),
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
