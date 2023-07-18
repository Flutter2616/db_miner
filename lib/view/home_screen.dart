import 'package:db_miner/controller/quotes_controller.dart';
import 'package:db_miner/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  TextEditingController txtcategory = TextEditingController();
  Quotescontroller controller = Get.put(Quotescontroller());

  @override
  void initState() {
    super.initState();
    controller.readdata();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            flexibleSpace: Container(
                height: 7.h,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.purple.shade300,
                  Colors.indigo.shade300
                ]))),
            elevation: 0,
            title: Text(
              "Amazing Quotes",
              style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            centerTitle: true,
            leading: Icon(Icons.menu, color: Colors.white, size: 18.sp)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(
                    onTap: () {
                      Get.toNamed("quotes",arguments: {'edit':0,'index':null});
                    },
                    child: add_button("Add Quotes")),
                const SizedBox(width: 8),
                InkWell(
                    onTap: () {
                      Get.dialog(
                        barrierDismissible: false,
                        AlertDialog(
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  "cancel",
                                  style: TextStyle(
                                      fontSize: 15.sp, color: Colors.black),
                                )),
                            InkWell(
                              onTap: () {
                                controller.add_Categoty(txtcategory.text);
                                txtcategory.clear();
                                Get.back();
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Add",
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
                          ],
                          title: Text("Add category",
                              style: TextStyle(
                                  color: Colors.purple,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp)),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextField(
                                  decoration: InputDecoration(
                                      hintText: "Enter New category......",
                                      label: Text("Category",
                                          style: TextStyle(
                                              color: Colors.indigo,
                                              fontWeight: FontWeight.w500)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.sp),
                                          borderSide: BorderSide(
                                              width: 2, color: Colors.indigo)),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.sp),
                                          borderSide: BorderSide(width: 2))),
                                  controller: txtcategory),
                            ],
                          ),
                        ),
                      );
                    },
                    child: add_button("Add Category")),
              ]),
              const SizedBox(height: 15),
              Expanded(
                child: Obx(
                  () => ListView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          controller.filter_readdata(
                              controller.category[index]['category']);
                          Get.toNamed('view',
                              arguments:
                                  '${controller.category[index]['category']}');
                        },
                        onLongPress: () {
                          Get.dialog(
                              AlertDialog(
                                title: Text("Are sure delete this category",
                                    style: TextStyle(
                                        color: Colors.indigo, fontSize: 12.sp)),
                                content: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Get.back();
                                        },
                                        child: Text(
                                          "cancel",
                                          style: TextStyle(fontSize: 12.sp),
                                        )),
                                    ElevatedButton(
                                        onPressed: () {
                                          Database_helper.database.deletedb(
                                              controller.category[index]['id']);
                                          controller.readdata();
                                          Get.back();
                                        },
                                        child: Text("Delete",
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Colors.white)),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.purple)),
                                  ],
                                ),
                              ),
                              barrierDismissible: false);
                        },
                        child: Container(
                          width: 90.w,
                          height: 6.h,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("${index + 1}.",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500)),
                                const SizedBox(width: 3),
                                Text(
                                    "${controller.category[index]['category']}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w500)),
                                Spacer(),
                                IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.arrow_forward_ios,
                                        size: 18.sp, color: Colors.purple))
                              ]),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.sp),
                              boxShadow: [
                                BoxShadow(
                                    offset: Offset(3, 3),
                                    color: Colors.grey.shade300,
                                    blurRadius: 5,
                                    spreadRadius: 5)
                              ]),
                        ),
                      );
                    },
                    itemCount: controller.category.length,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Container add_button(String title) {
    return Container(
      height: 6.h,
      width: 45.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          gradient: LinearGradient(
            colors: [Colors.purple.shade300, Colors.indigo.shade300],
          )),
      child: Text("${title}",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              color: Colors.black)),
    );
  }
}
