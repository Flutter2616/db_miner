import 'package:db_miner/controller/quotes_controller.dart';
import 'package:db_miner/modal/quotes_modal.dart';
import 'package:db_miner/utils/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class Viewscreen extends StatefulWidget {
  const Viewscreen({super.key});

  @override
  State<Viewscreen> createState() => _ViewscreenState();
}

class _ViewscreenState extends State<Viewscreen> {
  Quotescontroller controller = Get.put(Quotescontroller());

  String cate = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
              elevation: 0,
              flexibleSpace: Container(
                  height: 7.h,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Colors.purple.shade300,
                    Colors.indigo.shade300
                  ]))),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Get.back();
                },
              ),
              centerTitle: true,
              title: Text(
                "$cate",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500),
              )),
          body: controller.quoteslist.isEmpty
              ? Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/image/page.png",
                        width: 70.w, height: 60.w, fit: BoxFit.fill),
                    const SizedBox(height: 10),
                    Text(
                      "no Quotes available",
                      style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ))
              : Obx(
                  () => ListView.builder(
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print("click===============");
                          controller.changecolor();
                        },
                        child: Obx(
                          () => Container(
                            margin: EdgeInsets.all(10),
                            width: 100.w,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    width: 50.w,
                                    alignment: Alignment.center,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${controller.quoteslist[index]['quote']}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 14.sp,
                                              wordSpacing: 2),
                                        ),
                                        Text(
                                          textAlign: TextAlign.end,
                                          "-${controller.quoteslist[index]['author']}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 11.sp),
                                        ),
                                      ],
                                    )),
                                const SizedBox(height: 40),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        if (controller.like.value == false) {
                                          controller.like.value = true;
                                        } else {
                                          controller.like.value = false;
                                        }
                                        Quotesmodal q = Quotesmodal(
                                            quote: controller.quoteslist[index]
                                                ['quote'],
                                            author: controller.quoteslist[index]
                                                ['author'],
                                            category: controller.quoteslist[index]
                                                ['category'],
                                            id: controller.quoteslist[index]['id'],
                                            like: controller.like.value == true
                                                ? 1
                                                : 0);
                                        Database_helper.database.update(q);
                                        controller.filter_readdata(cate);
                                        controller.like.value=false;
                                      },
                                      child: option(Icon(Icons.favorite,
                                          color: controller.quoteslist[index]
                                                      ['like'] ==
                                                  1
                                              ? Colors.amber
                                              : Colors.black,
                                          size: 15.sp)),
                                    ),
                                    option(Icon(Icons.copy,
                                        color: Colors.black, size: 15.sp)),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed('quotes',
                                            arguments: {"edit": 1, "index": index});
                                      },
                                      child: option(Icon(Icons.edit,
                                          color: Colors.black, size: 15.sp)),
                                    ),
                                    option(Icon(Icons.share,
                                        color: Colors.black, size: 15.sp)),
                                  ],
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    colors: controller.allcolor[
                                        controller.selectcolorindex.value]),
                                borderRadius: BorderRadius.circular(10.sp),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade400,
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: Offset(3, 3),
                                  ),
                                ]),
                          ),
                        ),
                      );
                    },
                    itemCount: controller.quoteslist.length,
                  ),
                ),
        ),
      ),
    );
  }

  Container option(Icon i) {
    return Container(
      height: 10.w,
      width: 13.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.sp)),
      child: i,
    );
  }
}
