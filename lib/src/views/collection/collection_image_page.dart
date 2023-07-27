// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nafcassete/src/controller/collection_controller.dart';
import 'package:nafcassete/src/helpers/styles.dart';
import 'package:nafcassete/src/views/collection/category_collection_image.dart';
import 'package:nafcassete/src/widgets/custom_appbar.dart';
import 'package:nafcassete/src/widgets/custom_button.dart';


class CollectionImagePage extends StatefulWidget {
  const CollectionImagePage({super.key});

  @override
  State<CollectionImagePage> createState() => _CollectionImagePageState();
}

class _CollectionImagePageState extends State<CollectionImagePage> {
  final CollectionController _collectionController =Get.put(CollectionController());
  bool ontapTrue=false;
  dynamic image;

  @override
  void dispose() {
    setState(() {
      _collectionController.collectionImageList.clear();
      _collectionController.previewimageList.clear();
      _collectionController.categoryimageList.clear();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: customAppbar(
        '1/6',
        0.0,
        [
          Padding(
            padding: const EdgeInsets.only(top: 20.0,right: 20.0),
            child: InkWell(
              onTap:_collectionController. collectionImageList.isNotEmpty
              ?(){
                 _collectionController.categoryselectedImage.clear();
                Get.to(()=>CategoryCollectionImage(
                  firstImage:_collectionController.collectionImageList[0],
                  
                ),transition:Transition.downToUp );
                // SubImageModalBottomSheet.subModalBottomSheet(
                //   context,imageList[0]
                // );
              }
              :() {},
              child: Text('次へ',style: w7f15(black),)
            ),
          )
        ],
        IconButton(
          onPressed: () => Get.back(), 
          icon: const Icon(
            Icons.clear
          )
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(
              height: 20.h,
            ),
            Center(
              child: SizedBox(
                height: 546.h,
                child: Stack(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                        image: DecorationImage(
                          image: const AssetImage("assets/images/img6.png"),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.7),
                            BlendMode.darken
                          ),
                        ),
                      ),
                      ),
                    _collectionController.collectionImageList.isEmpty
                    ? Padding(
                        padding: EdgeInsets.only(top: 200.h,left: 60.0,right: 40.0),
                        child: Text('カセットのメインになる画像をアップしてください',style: w7f14(white),),
                      )
                    : Container(
                      color: white,
                      height: 546.h,
                      child: Center(
                        child: Image.file(
                          ontapTrue==true?image:
                          _collectionController. collectionImageList[0],
                          fit: BoxFit.fitWidth,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                    )
                  ],
                )
              
              ),
            ),
            SizedBox(
              height: 0.0.h,
            ),
            Center(
              child: Container(
                height: 190.h,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0,left: 10.0,right: 10.0),
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
                            itemCount: _collectionController.collectionImageList.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  setState(() {
                                  ontapTrue=true;
                                  image=_collectionController.collectionImageList[index];
                                  });
                                },
                                child: Stack(
                                  children: [
                                    Image.file(_collectionController.collectionImageList[index],
                                      fit: BoxFit.cover,
                                      height: 60,
                                        width: 60
                                      ),
                                    index==0
                                      ? Positioned(
                                        top:0.0,
                                        right: 0.0,
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
                            
                          },),
                        ),
                        SizedBox(
                          height: 10.0.h,
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
                            var imgs = await _collectionController.getImages(context, true);
                            setState(() {
                              if(imgs != null){
                              _collectionController. collectionImageList = imgs;
                              }
                            });
                          }
                        ),
                      )
                    ],
                  )
                ),
              ),
            ),
          ],
        ),
      ),

    );
  }
 
}