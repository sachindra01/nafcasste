
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nafcassete/src/helpers/styles.dart';
import 'package:nafcassete/src/model/collection_model.dart';
import 'package:nafcassete/src/model/favourite_model.dart';
import 'package:nafcassete/src/widgets/custom_cached_network_image.dart';

import '../model/search_model.dart';

class CoordinateImageModalBottomSheet {
  static void coordinateModalBottomSheet(context,listImage,double cordiateY, double cordinateX, coordinatesList,from) {
    Size size = MediaQuery.of(context).size;
    List selectedImage = [];
    showModalBottomSheet(
      backgroundColor: redCol,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateBtm) {
            return Container(
              padding: EdgeInsets.symmetric(horizontal : 20.0.w, vertical: 15.0.h),
              height: size.height*0.6,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 6.0.h,
                    width: 80.0.w,
                    decoration: BoxDecoration(
                      color: lightGreyCol,
                      borderRadius: BorderRadius.circular(30.0.r)                      
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Center(
                    child: SingleChildScrollView(
                      child: GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10
                        ),
                        itemCount: listImage.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){ 
                              setStateBtm(() {
                                var coordinates = from == 'favourite' ?
                                CoordinateListFav.fromJson(
                                  {
                                  "x": cordinateX,
                                  "y": cordiateY,
                                  }
                                ) : 
                                from == 'collection' ?
                                CoordinateListCol.fromJson(
                                  {
                                  "x": cordinateX,
                                  "y": cordiateY,
                                  }
                                ) :
                                CoordinateList.fromJson(
                                  {
                                  "x": cordinateX,
                                  "y": cordiateY,
                                  }
                                );
                                coordinatesList.add(coordinates);
                                Get.back(); 
                              }); 
                            },
                            child: selectedImage.contains(listImage[index]) ?
                            Stack(
                              children: [
                                Container(
                                  height: 175.0.h,
                                  width: 175.0.h,
                                  decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(10.0.r),
                                    border: Border.all(
                                      color: grey,
                                      width: 1.2.sp
                                    )
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0.r),
                                    child: DisplayNetworkImage(
                                      imageUrl:listImage[index],
                                      width: double.infinity,
                                      height: double.infinity,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  decoration: BoxDecoration(
                                    color:  Colors.black.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10.0.r),
                                  ),
                                  child: Icon(Icons.check, color: white, size: 45.sp,),
                                )
                              ],
                            ) : 
                            Container(
                              height: 175.0.h,
                              width: 175.0.h,
                              decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(10.0.r),
                                border: Border.all(
                                  color: grey,
                                  width: 1.2.sp
                                )
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0.r),
                                child: DisplayNetworkImage(
                                  imageUrl: listImage[index],
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: listImage.length <= 2 ? 150.0.h : 20.0.h,),
                ],
              )
            );
        }
        );
      }
    );
  }
}


