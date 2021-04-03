import 'package:fichier/roger.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new Home());
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mon app",
      home: FlutterPhp(),
    );
  }
}

// import 'package:fichier/fichier.dart';
// import 'package:fichier/fichier2.dart';
// import 'package:fichier/setting.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             RaisedButton(
//               onPressed: () => goto(context, Fichier()),
//               child: Text("FICHIER"),
//             ),
//             RaisedButton(
//               onPressed: () => goto(context, Fichier2()),
//               child: Text("FICHIER2"),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: null,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
