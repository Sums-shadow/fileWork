import 'package:flutter/material.dart';

goto(context, path) =>
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => path));
