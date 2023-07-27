// ignore_for_file: file_names
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nafcassete/src/controller/collection_controller.dart';
import 'package:nafcassete/src/helpers/styles.dart';
import 'package:nafcassete/src/views/collection/add_coordinate_page.dart';
import 'package:nafcassete/src/widgets/custom_appbar.dart';
import 'package:nafcassete/src/widgets/custom_button.dart';

class CategoryCollectionImage extends StatefulWidget {
  final dynamic firstImage;
  const CategoryCollectionImage({super.key, this.firstImage});

  @override
  State<CategoryCollectionImage> createState() => _CategoryCollectionImageState();
}

class _CategoryCollectionImageState extends State<CategoryCollectionImage> {
  final CollectionController _collectionController =Get.put(CollectionController());
  bool ontapTrue=false;
  dynamic image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        '2/6',
        0.0,
        [
          Padding(
            padding: const EdgeInsets.only(top: 20.0,right: 20.0),
            child: InkWell(
              onTap:_collectionController.categoryselectedImage.isNotEmpty
              ?(){
                // coordinateList.clear();
                Get.to(()=> AddCoordinatePage(
                  image: widget.firstImage,
                  imageList: _collectionController.categoryselectedImage,
                ),transition: Transition.rightToLeft);
              }
              :() {},
              child: Text('次へ',style: w7f15(black),)
            ),
          )
        ],
        IconButton(
          onPressed: () => Get.back(), 
          icon: const Icon(
            Icons.arrow_back_ios
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
                height: _collectionController.categoryimageList.isEmpty? 546.h:546.0,
                child: Stack(
                  children: [
                    _collectionController.categoryselectedImage.isEmpty
                      ? Container(
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
                      )
                      : Container(),
                      _collectionController.categoryselectedImage.isEmpty
                      ? Padding(
                        padding: EdgeInsets.only(top: 200.h,left: 60.0,right: 40.0),
                        child: Text('カセットのメインになる画像をアップしてください',style: w7f14(white),),
                      )
                      : gridImage(),
                  ],
                )
              ),
            ),
            SizedBox(
              height: 50.0.h,
            ),
            SizedBox(
              width: 358.w,
              height: 71.h,
              child: CustomButton(
                text: 'カセット画像を追加する',
                buttonRadius:32.0 ,
                prefixIcon: const SizedBox(),
                suffixIcon: const SizedBox(),
                ontap: ()  {
                showDailog();
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
  // gridImage
  gridImage(){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4
        ),
        itemCount: _collectionController.categoryselectedImage.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              InkWell(
                // onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ViewImages(imagesFiles: [_collectionController.categoryimageList[index]]))),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: lightgrey
                    ),
                    borderRadius: BorderRadius.circular(9.0),
                  image :DecorationImage(
                    image: FileImage(File(_collectionController.categoryselectedImage[index].path)),
                    fit: BoxFit.cover,
                  )
                  ),
                ),
              ),
              //Remove Image
            ],
          );
        },
      ),
    );
  }

// show dailog
  showDailog()async{
      return  
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
                            onPressed: () async{
                              var imgs = await _collectionController. getImagesCamera(context);
                           
                                if(imgs != null){
                                  setState(() {
                                  _collectionController.categoryselectedImage.add(imgs);
                                   Navigator.pop(context);
                                    
                                  });
                                }
                            },
                            child: const Text("商品台帳",),
                          ),
                          const Divider(height: 1,),
                          TextButton(
                            style:ButtonStyle(
                              foregroundColor: MaterialStateProperty.resolveWith(
                              (state) => black),
                            ),
                            onPressed: ()async {
                                _collectionController.categoryimageList.clear();
                              var imgs = await _collectionController. getImages(context, false);
                              setState(() {
                                if(imgs != null){
                                   _collectionController.categoryselectedImage.addAll(imgs);

                                }
                                Navigator.pop(context);
                              });
                            },
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
                        Get.back();
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
 
    
}