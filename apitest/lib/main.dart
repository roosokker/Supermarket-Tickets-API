import 'package:flutter/material.dart';
import 'api.dart';
import 'package:provider/provider.dart';
import 'TicketsModel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ChangeNotifierProvider(
          create: (_) => TicketsNameModel(),
          child: MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String ticketsname;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TicketsNameModel>(context, listen: false).getTicketsName();
  }

  Widget getTicketname(TicketsNameModel model) {
    if (model.ticketname == null) {
      return CircularProgressIndicator();
    } else {
      return Text(model.ticketname);
    }
  }

  @override
  Widget build(BuildContext context) {
    final result = Provider.of<TicketsNameModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getTicketname(result),
            // RaisedButton(onPressed: () async {
            //   ticketsname = await API().ticketName;
            //   print("ticketname in buttonclick   $ticketsname");
            // })
          ],
        ),
      ),
    );
  }
}
