import 'dart:ui';

import 'package:book_app/controllers/book_controller.dart';
import 'package:book_app/views/image_view_screen.dart';
// ignore: implementation_imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBookPage extends StatefulWidget {
  const DetailBookPage({
    Key? key,
    required this.isbn,
  }) : super(key: key);
  final String isbn;

  @override
  State<DetailBookPage> createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  BookController? controller;
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    controller = Provider.of<BookController>(context, listen: false);
    controller!.fetchDetailBookApi(widget.isbn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      body: Consumer<BookController>(builder: (context, controller, child) {
        return controller.detailBook == null
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ImageViewScreen(
                              imageUrl: controller.detailBook!.image!),
                        ),
                      );
                    },
                    child: Image.network(
                      controller.detailBook!.image!,
                      height: 300,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.8),
                            blurRadius: 20.0,
                            spreadRadius: 0.0,
                            offset: Offset(1.0, 0.0),
                          ),
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.detailBook!.title!,
                            style: const TextStyle(
                              fontSize: 20,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            controller.detailBook!.authors!,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          // Row(
                          //   children: List.generate(
                          //     5,
                          //     (index) => Icon(
                          //       Icons.star,
                          //       color: index <
                          //               int.parse(
                          //                   controller.detailBook!.rating!)
                          //           ? Colors.yellow
                          //           : Colors.grey,
                          //     ),
                          //   ),
                          // ),
                          // Text(
                          //   controller.detailBook!.subtitle!,
                          //   style: const TextStyle(
                          //     fontSize: 12,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.grey,
                          //   ),
                          // ),
                          // Text(
                          //   controller.detailBook!.price!,
                          //   style: const TextStyle(
                          //     fontSize: 14,
                          //     fontWeight: FontWeight.bold,
                          //     color: Colors.green,
                          //   ),
                          // ),
                          SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Description",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(controller.detailBook!.desc!),

                          Container(
                            margin: EdgeInsets.only(
                              top: 10,
                            ),
                            height: 60,
                            padding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: Color.fromARGB(245, 245, 245, 245),
                              borderRadius: BorderRadius.circular(9),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Column(
                                  children: [
                                    Text("Year"),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text("${controller.detailBook!.year!}"),
                                  ],
                                ),
                                VerticalDivider(
                                  color: Colors.black,
                                  thickness: 1.5,
                                ),
                                Column(
                                  children: [
                                    Text("Pages"),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                        "${controller.detailBook!.pages!} Page"),
                                  ],
                                ),
                                VerticalDivider(
                                  color: Colors.black,
                                  thickness: 1.5,
                                ),
                                Column(
                                  children: [
                                    Text("Language"),
                                    SizedBox(
                                      height: 2,
                                    ),
                                    Text("${controller.detailBook!.language!}"),
                                  ],
                                ),

                                // Text("ISBN ${controller.detailBook!.isbn13!}"),
                                // Text("${controller.detailBook!.pages!} Page"),
                                // Text(
                                //     "Publisher: ${controller.detailBook!.publisher!}"),
                                // Text(
                                //     "Language: ${controller.detailBook!.language!}"),

                                //Text(detailBook!.rating!),
                              ],
                            ),
                          ),
                          SizedBox(height: 25),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 15,
                                    ),
                                    primary: Colors.green,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    //fixedSize: Size(double.infinity, 50),
                                  ),
                                  onPressed: () async {
                                    Uri uri =
                                        Uri.parse(controller.detailBook!.url!);
                                    try {
                                      (await canLaunchUrl(uri))
                                          ? launchUrl(uri)
                                          : print("tidak berhasil navigasi");
                                    } catch (e) {}
                                  },
                                  child: const Text("BUY")),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // const Divider(),
                  // controller.similiarBooks == null
                  //     ? const CircularProgressIndicator()
                  //     : SizedBox(
                  //         height: 180,
                  //         child: ListView.builder(
                  //           // shrinkWrap: true,
                  //           scrollDirection: Axis.horizontal,
                  //           itemCount:
                  //               controller.similiarBooks!.books!.length,
                  //           // physics: NeverScrollableScrollPhysics(),
                  //           itemBuilder: (context, index) {
                  //             final current =
                  //                 controller.similiarBooks!.books![index];
                  //             return SizedBox(
                  //               width: 100,
                  //               child: Column(
                  //                 children: [
                  //                   Image.network(
                  //                     current.image!,
                  //                     height: 100,
                  //                   ),
                  //                   Text(
                  //                     current.title!,
                  //                     maxLines: 2,
                  //                     textAlign: TextAlign.center,
                  //                     overflow: TextOverflow.ellipsis,
                  //                     style: const TextStyle(
                  //                       fontSize: 12,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //             );
                  //           },
                  //         ),
                  //       )
                ],
              );
      }),
    );
  }
}
