import 'package:flutter/material.dart';

import 'pagination.dart';

class PriorityTwo extends StatelessWidget {
  static const int _COUNT = 10;

  Future<List<String>> pageData(int previousCount) async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    List<String> dummyList = List();
    if (previousCount < 30) {
      for (int i = previousCount; i < previousCount + _COUNT; i++) {
        dummyList.add('Item $i');
      }
    }
    return dummyList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pagination")),
      body: Pagination(
        pageBuilder: (currentListSize) => pageData(currentListSize),
        itemBuilder: (item, _) => ListTile(title: Text(item.toString())),
      ),
    );
  }
}
