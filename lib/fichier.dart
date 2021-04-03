import 'dart:io';

import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class Fichier extends StatefulWidget {
  @override
  _FichierState createState() => _FichierState();
}

class _FichierState extends State<Fichier> {
  TextEditingController controller = TextEditingController();
  bool loading = false;
  File file;
  var data = "no data found";
  @override
  void initState() {
    super.initState();
    getPermission(); // uniquement si on veut ecrire dans les dossier publique
  }

  getPermission() async => await Permission.storage.request();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
            height: 150,
          ),
          Container(
            width: 70,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                  hintText: "Entrer une phrase à sauvegarder dans le fichier"),
            ),
          ),
          RaisedButton(
              onPressed: saveDataPublique,
              // onPressed:saveData,

              child: loading ? CircularProgressIndicator() : Text("save data")),
          RaisedButton(
              onPressed: () {
                readData();
              },
              child: loading ? CircularProgressIndicator() : Text("read data")),
          Center(
            child: Text("$data"),
          )
        ],
      ),
    );
  }

  // getFilePath() async {
  //   final directory = await getApplicationDocumentsDirectory(); // enregistre les données dans le dossier data(dossier ou est sauvegarder les donnees de l'application), cela ne demande pas la permission de l'utilisateur(fonction mis a l'initstate)

  //   var data = File("${directory.path}/sums.txt");
  //   return data;
  // }

  getFilePathPublique() async {
    String path = await ExtStorage.getExternalStoragePublicDirectory(
        // enregistre le fichier dans le dossier document un dossier publique, cela demande la permission de l'utilisateur(donction mis a l'initstate)
        ExtStorage.DIRECTORY_ALARMS);
    var data = File("$path/information.txt");
    return data;
  }

  //enregistre dans le dossier data(dossier à la racine)
  // saveData() async {
  //   getFilePath().then((val) {
  //     file = val;
  //     print(file);
  //     var a = file.writeAsString(controller.text);
  //     print("saved $a");
  //   });
  // }

  //enregistre dans le dossier document
  saveDataPublique() async {
    setState(() => loading = true);
    getFilePathPublique().then((val) {
      file = val;
      print(file);
      var a = file.writeAsString(controller.text);
      setState(() => loading = false);
      controller.text = "";
      print("saved $a");
    });
  }

  readData() async {
    setState(() => loading = true);

    try {
      getFilePathPublique().then((val) async {
        file = val;
        final content = await file.readAsString();
        print("read $content");
        setState(() {
          data = content;
        });
        setState(() => loading = false);
        controller.text = "";
      });
    } catch (e) {
      print("error occured $e");
      controller.text = "";

      setState(() => loading = false);
    }
  }
}
