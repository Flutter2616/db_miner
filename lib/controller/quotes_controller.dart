import 'dart:math';
import 'dart:ui';

import 'package:db_miner/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Quotescontroller extends GetxController {
  RxList<Map> quoteslist = <Map>[].obs;
  RxList<Map> category = <Map>[].obs;

  RxString selectcategory = ''.obs;
  RxBool like=false.obs;
  List<List<Color>> allcolor = [
    [Colors.pink.shade300, Colors.red.shade50],
    [Colors.black, Colors.white],
    [Colors.purple.shade300, Colors.orange.shade300],
    [Colors.indigo.shade300, Colors.purple.shade300],
    [Colors.orange.shade300, Colors.red.shade300],
    [Colors.indigo.shade300, Colors.cyan.shade300],
    [Colors.teal.shade300, Colors.blueGrey.shade300],
  ];

  RxInt selectcolorindex=0.obs;

  Future<void> readdata() async {
    quoteslist.value = await Database_helper.database.readdb();
    category.value = await Database_helper.database.category_readdb();
    selectcategory = '${category[0]['category']}'.obs;
  }

  Future<void> filter_readdata(String name) async {
    quoteslist.value = await Database_helper.database.filterdata(name);
    print("${quoteslist.length}****************");
    print("list:${quoteslist}****************");
  }

  void changecolor()
  {
    Random random=Random();
    selectcolorindex.value=random.nextInt(allcolor.length);
    update();
  }

  int repeatcate=0;
  void add_Categoty(String text)
  {
    repeatcate=0;
    for(int i=0;i<category.length;i++)
      {
        if(text.toLowerCase()=='${category[i]['category']}'.toLowerCase())
        {
          repeatcate++;
        }
      }
    if(repeatcate==0)
      {
          Database_helper.database.category_insert(text);
          readdata();
      }
  }
}
