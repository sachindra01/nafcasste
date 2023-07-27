import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nafcassete/src/helpers/styles.dart';
import 'package:nafcassete/src/widgets/add_subimagebtmsheet.dart';

class ImageModalBottomSheet {
    static void moreModalBottomSheet(context,) {
      Size size = MediaQuery.of(context).size;
      bool ontapTrue=false;
      dynamic image;
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
                            Text('1/6',style: w7f14(black),),
                            InkWell(
                              onTap: imageList.isNotEmpty
                              ?(){
                               SubImageModalBottomSheet.subModalBottomSheet(
                                  context,imageList[0]
                                );
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
                        color: Colors.transparent,
                        child:imageList.isEmpty
                        ? Padding(
                            padding: EdgeInsets.only(top: 200.h),
                            child: Text('カセットのメインになる画像をアップしてください',style: w7f14(white),),
                          )
                        : Image.file(
                            ontapTrue==true?image:
                            imageList[0],
                            fit: BoxFit.fill,
                            width: MediaQuery.of(context).size.width,
                          )
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Center(
                      child: Container(
                        height: 190.h,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 60.h,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) {
                                  return  Container(
                                      color: white,
                                      width: 5,);
                                  },
                                  scrollDirection: Axis.horizontal,
                                  itemCount: imageList.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: (){
                                        setStateBtm(() {
                                        ontapTrue=true;
                                        image=imageList[index];
                                        });
                                      },
                                      child: Stack(
                                        children: [
                                          Image.file(imageList[index],
                                            fit: BoxFit.fill,
                                            height: 60,
                                              width: 60
                                            ),
                                          index==0
                                            ? Positioned(
                                              child: Container(
                                                width: 5,
                                                height: 5,
                                                decoration: BoxDecoration(
                                                  color: lightblue,
                                                  borderRadius: BorderRadius.circular(100.0)
                                                ),
                                              )
                                            )
                                          : const SizedBox()
                                        ],
                                      ),
                                    );
                                }
                              ),
                              ),
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