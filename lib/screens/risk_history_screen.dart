import 'package:flutter/material.dart';
import 'package:prostate_predict/data/database_helpers.dart';
import 'package:prostate_predict/data/user_data.dart';
import 'package:prostate_predict/widgets/screen_widgets.dart';

class RiskHistoryScreen extends StatefulWidget {
  const RiskHistoryScreen({Key? key}) : super(key: key);

  @override
  _RiskHistoryScreenState createState() => _RiskHistoryScreenState();
}

class _RiskHistoryScreenState extends State<RiskHistoryScreen> {
// TODO: make this actually flutterish

  late DatabaseHelper handler;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    this.handler = DatabaseHelper.instance;

    /*
    this.handler.().whenComplete(() async {
      await this.addUsers();
      setState(() {});
    });*/
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _key,
      appBar: ColorAppBar(context, _key),
      endDrawer: buildSideBar(context),
      body: FutureBuilder(
        future: this.handler.queryAllHistory(),
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
                    await this.handler.delete(snapshot.data![index].id!);
                    setState(() {
                      snapshot.data!.remove(snapshot.data![index]);
                    });
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
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
