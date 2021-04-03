import 'package:flutter/material.dart';
import "package:async/async.dart";
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';

import 'dart:io';
import 'package:http/http.dart' as http;

class FlutterPhp extends StatefulWidget {
  @override
  _FlutterPhpState createState() => _FlutterPhpState();
}

class _FlutterPhpState extends State<FlutterPhp> {
  File _image;
  final picker = ImagePicker();
  String nom = "Ezechiel";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () {
                  getImage();
                },
                child: Text("pick image")),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  addProduct(_image, nom);
                },
                child: Text("Uploader")),
          )
        ],
      ),
    );
  }

  Future addProduct(File imageFile, String nom) async {
// ignore: deprecated_member_use
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();
    var uri = Uri.parse("https:/urlDestination.php");

    var request = new http.MultipartRequest(
      "POST",
      uri,
    );

    var multipartFile = new http.MultipartFile("image", stream, length,
        filename: basename(imageFile.path));

    request.files.add(multipartFile);
    request.fields['annonce_id'] = "42";
    request.fields['image_type'] = "principal";
    request.fields['image'] = multipartFile.toString();
    request.fields['legend'] = "Image test upload via mobile";
    request.headers['authorization'] =
        "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZTZiN2RhYWQ2NWY4MTM3Y2VhYzZmMjdmZjE5NWE0MzA4NGQ4NmI1ZGJlZWZiOTkxMDQ4YzExMzllMGU1MjkyOWQ1ZWMzMGRlYTdjYzNhYmMiLCJpYXQiOjE2MTc0NzQ1ODAsIm5iZiI6MTYxNzQ3NDU4MCwiZXhwIjoxNjQ5MDEwNTc5LCJzdWIiOiIxOSIsInNjb3BlcyI6W119.NrPkpoTqJc8aczpr_UmJsL-VEX-oeQ3ejZPv2kRZklzHRdK5BhQ9ErCpQsFf9ovwUc1cpC1aIvMUUOzZgrIYkQr9tf-5n9nNgxKTlgRmegKMagkFn8gz4fy2js6Q7HeeW_lsGIuqtQ0g5lljKXaGlJsHAs6fAGkn6XnkndrD0P_qmtADzCwMppq992vEU-mH8pyytSqt61-aRWKWKz3XSK8oK4Z_-BNDWVdQZ1oJzeOk2aJEkni0FKKw6WhjyBzWOjtsRgSpbPNEgFD3ZL3Xa2m0BzTkla26LSfqKj5W4sjfjTfjbvUQobSirZmuSsWvaVjLFVAfqI9icYiXXsL539d5Qi6jS4PLFpZJMXgoW3nwUwjOR4SVrMTKVUGbKRVPDSPQTIzw0WILxt75DaV-Hm0VC19JhT7UGE9IhoHBraGHH_VlF8mjgznK-PoJ0fc6c4jfpw-FT3J07MXGHMEljke_e8ucd8UMp6id1seUnSL7FizmKx2Nzm9BviZAc-nE5ZoQNwyjTQc_uIZpCCHmA0d_UT245b3EER6TSNiNfRSiur-q42x3dPbNpQWmJjKezxdObeho4sa1Gyix9sGdG0umG7dbO3GEA87nVVPohx_OX_9MsZp6evac17xmBmCqz4o9TWee7ouEk92C7xUqlJbUMOTcQGIJGfYFZxQGPqE";

    var respond = await request.send();
    print("statut ${respond.statusCode}");
    if (respond.statusCode == 200) {
      print("Image Uploaded");
    } else {
      print("Upload Failed");
    }
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }
}
