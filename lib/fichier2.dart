import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:flutter/material.dart';

import 'package:permission_handler/permission_handler.dart';

class Fichier2 extends StatefulWidget {
  @override
  _Fichier2State createState() => _Fichier2State();
}

class _Fichier2State extends State<Fichier2> {
  var pourcent = 0; //pourcentage de téléchargement
  //url du fichier à télécharger
  final imgUrl =
      "https://www.fustel-yaounde.net/sites/default/files/Doucments-2017-03/exercices%20corrig%C3%A9s%20algorithme.pdf";

  var dio =
      Dio(); // dio concurent de http, permettra de communiquer avec le serveur avec des fonction get et post
  @override
  void initState() {
    super.initState();
    getPermission(); //demande la permission d'ecriture au telephone
  }

  getPermission() async => await Permission.storage
      .request(); // fonnction pour demander à l'utilisateur la permission

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //bouton pour telecharger
          RaisedButton(onPressed: downloadData, child: Text("Download")),
          // bar de progression de telechargement
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: LinearProgressIndicator(
              value: double.parse(pourcent.toString()),
            ),
          ),
          //texte qui montre l'evolution en pourcentage
          Center(
            child: Text("$pourcent%"),
          )
        ],
      ),
    );
  }

  //fonction pour telecharger
  downloadData() async {
    //path recupere le dossier DOWNLOAD du telephone
    String path = await ExtStorage.getExternalStoragePublicDirectory(
        ExtStorage.DIRECTORY_DOWNLOADS);
//creation du nouveau fichier
    String fullPath = "$path/nouveauFichier.pdf";
    //fonction qui recupere le fichier sur internet
    telechargerSurInternet(dio, imgUrl, fullPath);
  }

//fonction de telechargment
  void telechargerSurInternet(Dio dio, String url, String fullPath) async {
    //dio recupere sur internet
    Response response = await dio.get(
      url, //l'url du fichier declarer au debut
      onReceiveProgress:
          showDownloadProgress, //fonction qui renvoi le nombre de byte recu
      //option de recuperation
      options: Options(
          responseType: ResponseType
              .bytes, //on specie qu'on veut recupere le fichier en byte
          followRedirects: false, //annule la redictetion
          validateStatus: (status) {
            //renvoi un statut vrai si y a pas d'erreur
            return status < 500;
          }),
    );

    //ecriture du fichier recu
    File file = File(
        fullPath); //declaration de la variable file en pointant vers le fichier donwload qu'on avait declaré
    var raf = file.openSync(
        mode: FileMode
            .write); // on specifie que le fichier est ouvert en mode ecriture
    raf.writeFromSync(response
        .data); // on ecrit dans le fichier fromSync pour dire que le fichier est ecrit en byte
    await raf.close(); // fermeture du fichier en ecriture
  }

  //fonction qui renvoi le %

  void showDownloadProgress(int count, int total) {
    if (total != -1) {
      // si il y a les données
      setState(() {
        //on actualise la variable pourcent
        pourcent = int.parse((count / total * 100)
            .toStringAsFixed(0)); //algorithme qui renvoi le pourcent
      });
      print((count / total * 100).toStringAsFixed(0) + "%");
    }
  }
}
