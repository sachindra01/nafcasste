import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nafcassete/src/bottom_nav.dart';
import 'package:nafcassete/src/controller/collection_controller.dart';
import 'package:nafcassete/src/helpers/styles.dart';
import 'package:nafcassete/src/json_data/image_list.dart';
import 'package:nafcassete/src/widgets/custom_button.dart';

import 'collection_image_page.dart';

class ProductPostPage extends StatefulWidget {
  final dynamic images;
  const ProductPostPage({super.key, this.images});

  @override
  State<ProductPostPage> createState() => _ProductPostPageState();
}

class _ProductPostPageState extends State<ProductPostPage> {
  final CollectionController _con = Get.put(CollectionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 155.h,
          ),
           Center(child: Text('商品名',style: w7f20(black),)),
           SizedBox(
            height: 30.h,
          ),
          Material(
             child: widget.images != null ?
               Image.file(
                widget.images, 
                width: 260.0.w,
                height: 320.h,
                fit: BoxFit.cover,
              ) :
              Image.asset(
                'assets/images/img1.png',
                fit: BoxFit.cover,
                height: 320.h,
              ),
           ),
          SizedBox(
            height: 105.h,
          ),
          SizedBox(
            width: 362.w,
            height: 50.h,
            child: CustomButton(
              bgColor: white,
              text: 'カセット登録',
              borderColor: redCol,
              style: w7f20(
                redCol
              ),
              buttonRadius:32.0 ,
              prefixIcon: const SizedBox(),
              suffixIcon: const Icon(Icons.edit_document,color: redCol,),
              ontap: () {
                setState(() {
                  _con.previewimageList.clear();
                  _con.categoryimageList.clear();
                  var mapToAdd = 
                    { 'image' : widget.images,
                      'multiImage' : [ ],
                      'name' : '商品名1',
                      'desc' : '説明文説明文説明文',
                      'price' : "Rs.100",
                      'color' : ['brown','natural' ],
                      'ratings' : 3,
                      'imageFile' : true
                    };
                  myCollectionList.add(mapToAdd);
                  _con.collectionImageList.clear();
                });
                Get.to(()=> const BottomNavbar(
                  index: 1,
                  tabIndex: 1,
                ));
              },
            ),
          ),
          SizedBox(
            height: 15.h,
          ),
          SizedBox(
            width: 362.w,
            height: 50.h,
            child: CustomButton(
              text: 'カセット登録',
              buttonRadius:32.0 ,
              prefixIcon: const SizedBox(),
              suffixIcon: const Icon(Icons.add_to_photos),
              ontap: () {
                setState(() {
                  _con.previewimageList.clear();
                  _con.categoryimageList.clear();
                });
                Get.to(()=>const CollectionImagePage(),transition:Transition.downToUp );
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(child: Text('商品名',style: w7f20(Colors.grey),)),
           const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

}