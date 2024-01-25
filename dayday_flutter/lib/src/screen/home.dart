import 'package:dayday_flutter/src/screen/feed/create.dart';
import 'package:flutter/material.dart';
import 'package:dayday_flutter/src/widget/feed_list_item.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  String getToday() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    String strToday = formatter.format(now);
    return strToday;
  }

  Widget build(BuildContext contest) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffD4A7FB),
        title: const Text(
          'DayDay',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
        actions: <Widget>[
          Container(
              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
              child: Text(
                getToday(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              )),
        ],
      ),
      body: const FeedIndex(),
    );
  }
}
