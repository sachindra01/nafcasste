// ignore_for_file: file_names

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nafcassete/src/helpers/styles.dart';
import 'package:nafcassete/src/views/collection/add_coordinate_page.dart';
import 'package:nafcassete/src/widgets/custom_button.dart';

class SubImageModalBottomSheet {
    static void subModalBottomSheet(context,firstImage) {
      Size size = MediaQuery.of(context).size;
      List imageList = [];
      showModalBottomSheet(
        backgroundColor: Colors.transparent,
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(00.0),
          ),
          context: context,
          builder: (BuildContext bc) {
            return StatefulBuilder(
              builder: (BuildContext context, StateSetter setStateBtm) {
                return Container(
                  height: size.height*0.98,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30.0),
                      topLeft: Radius.circular(30.0),
                    ),
                  ),
                  child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height: 20.h,
                    ),
                    Container(
                      color: white,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.clear,color:black,)),
                            Text('2/6',style: w7f14(black),),
                               InkWell(
                              onTap: imageList.isNotEmpty
                              ?(){
                              Get.to(()=> AddCoordinatePage(
                                image: firstImage,
                                imageList: imageList,
                              ),);
                              }
                             :() {},
                              child: Text('次へ',style: w7f14(lightblue),))
                          
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 546.h,
                        color: imageList.isEmpty?Colors.transparent:white,
                        child:imageList.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(top: 200.h),
                            child: Text('カセットのメインになる画像をアップしてください',style: w7f14(white),),
                          )
                        :  const SizedBox(
                           )
                      ),
                    ),
                    SizedBox(
                      height: imageList.isEmpty?15.h:0.0.h,
                    ),
                    Center(
                      child: Container(
                        height:imageList.isEmpty? 190.h:205.h,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              SizedBox(
                                  height: 60.h,
                                ),
                              //submit button
                              SizedBox(
                                width: 358.w,
                                height: 71.h,
                                child: CustomButton(
                                  text: 'カセット画像を追加する',
                                  buttonRadius:32.0 ,
                                  prefixIcon: const SizedBox(),
                                  suffixIcon: const SizedBox(),
                                  ontap: () async {
                                  await  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return FractionallySizedBox(
                                          widthFactor: 0.9,
                                          child: Material(
                                            type: MaterialType.transparency,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                Container(
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: [
                                                      TextButton(
                                                        style:ButtonStyle(
                                                          foregroundColor: MaterialStateProperty.resolveWith(
                                                            (state) => black),
                                                        ),
                                                        onPressed: () {},
                                                        child: const Text("商品台帳",),
                                                      ),
                                                      const Divider(height: 1,),
                                                      TextButton(
                                                        style:ButtonStyle(
                                                          foregroundColor: MaterialStateProperty.resolveWith(
                                                              (state) => black),
                                                        ),
                                                        onPressed: () {},
                                                        child: const Text("アルバム"),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  decoration: const BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                    BorderRadius.all(Radius.circular(10.0)),
                                                  ),
                                                  child: TextButton(
                                                    style:ButtonStyle(
                                                      foregroundColor: MaterialStateProperty.resolveWith(
                                                          (state) => black)
                                                    ),
                                                    onPressed: ()async {
                                                      var imgs = await getImages(context);

                                                      setStateBtm(() {
                                                          imageList = imgs;
                                                          Navigator.pop(context);
                                                      });
                                                    },
                                                    child: const Text("戻る"),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 40,
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    );
                                  }
                                ),
                              )
                            ],
                          )
                        ),
                      ),
                    ),

                  ],
                )
            );
          }
        );
      }
    );
  }
  //Image picker button
}


//image picker from gallery
Future getImages(context) async {
  List<File> selectedImages = []; 
  final picker = ImagePicker();
  final pickedFile = await picker.pickMultiImage(imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
  List<XFile> xfilePick = pickedFile;
  if (xfilePick.isNotEmpty) {
    for (var i = 0; i < xfilePick.length; i++) {
      selectedImages.add(File(xfilePick[i].path));
    }
    return selectedImages;
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nothing is selected')));
  }
}
