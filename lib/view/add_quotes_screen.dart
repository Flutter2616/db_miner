import 'package:db_miner/controller/quotes_controller.dart';
import 'package:db_miner/modal/quotes_modal.dart';
import 'package:db_miner/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Quotesscreen extends StatefulWidget {
  const Quotesscreen({super.key});

  @override
  State<Quotesscreen> createState() => _QuotesscreenState();
}

class _QuotesscreenState extends State<Quotesscreen> {
  TextEditingController txtquotes = TextEditingController();
  TextEditingController txtauthor = TextEditingController();
  Quotescontroller controller = Get.put(Quotescontroller());
  Map m=Get.arguments;

  @override
  void initState() {
    super.initState();
    if(m['edit']==1)
      {
        txtquotes=TextEditingController(text: controller.quoteslist[m['index']]['quote']);
        txtauthor=TextEditingController(text: controller.quoteslist[m['index']]['author']);
        controller.selectcategory.value='${controller.quoteslist[m['index']]['category']}';
      }

  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: InkWell(
          onTap: () {
            if(m['edit']==0) {
              Quotesmodal q = Quotesmodal(
                  category: controller.selectcategory.value,
                  author: txtauthor.text,
                  quote: txtquotes.text);
              Database_helper.database.insert(q);
            }
            else
              {
                Quotesmodal q = Quotesmodal(
                  quote: controller.quoteslist[m['index']]['quote'],
                  author: controller.quoteslist[m['index']]['author'],
                  category: controller.selectcategory.value,
                  id: controller.quoteslist[m['index']]['id'],
                );
                Database_helper.database.update(q);
              }
            controller.readdata();
            Get.offAllNamed('home');
          },
          child: Container(
            padding: EdgeInsets.all(10),
            child: Text(
              "Create Quotes",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.sp),
              gradient: LinearGradient(
                colors: [
                  Colors.indigo.shade300,
                  Colors.purple.shade300,
                ],
              ),
            ),
          ),
        ),
        appBar: AppBar(
            elevation: 0,
            flexibleSpace: Container(
                height: 7.h,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.purple.shade300,
                  Colors.indigo.shade300
                ]))),
            title: Text(
              "Create Quotes",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp),
            )),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              TextField(
                  controller: txtquotes,
                  textInputAction: TextInputAction.newline,
                  maxLines: 6,
                  decoration: InputDecoration(
                      hintText: "Enter your quotes......",
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.sp),
                          borderSide:
                              BorderSide(width: 2, color: Colors.purple)),
                      label: Text("Quotes",
                          style: TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.w500)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.sp),
                          borderSide: BorderSide(width: 2)))),
              const SizedBox(height: 20),
              TextField(
                  controller: txtauthor,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      hintText: "Enter author name......",
                      label: Text("Author",
                          style: TextStyle(
                              color: Colors.indigo,
                              fontWeight: FontWeight.w500)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.sp),
                          borderSide:
                              BorderSide(width: 2, color: Colors.indigo)),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.sp),
                          borderSide: BorderSide(width: 2)))),
              const SizedBox(height: 20),
              Container(
                height: 6.h,
                width: 100.w,
                padding: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.sp),
                    gradient: LinearGradient(colors: [
                      Colors.purple.shade200,
                      Colors.indigo.shade200
                    ])),
                child: Obx(
                  () => DropdownButton(
                    value: controller.selectcategory.value,
                    alignment: Alignment.bottomCenter,
                    hint: Text("select category",
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15.sp,
                            color: Colors.black)),
                    iconEnabledColor: Colors.indigo,
                    iconDisabledColor: Colors.purple,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                        color: Colors.black),
                    iconSize: 20.sp,
                    items: controller.category
                        .asMap()
                        .entries
                        .map((e) => DropdownMenuItem(
                            alignment: Alignment.center,
                            value: controller.category[e.key]['category'],
                            child: Text(
                                "${controller.category[e.key]['category']}")))
                        .toList(),
                    isExpanded: true,
                    onChanged: (value) {
                      controller.selectcategory.value = value as String;
                    },
                    underline: SizedBox(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
