import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nafcassete/src/helpers/styles.dart';
import 'package:nafcassete/src/views/collection/product_postpage.dart';
import 'package:nafcassete/src/widgets/custom_button.dart';

List titleList = ['社内','問屋XXXXXX','ナフコ','プロモーション','一般ユーザー'];
List<bool> radioList = List.filled(titleList.length, false);
class PreviewModalBottomSheet {
  static void previewModalBottomSheet(context, [isFromSearch, images]) {
    Size size = MediaQuery.of(context).size;
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      context: context,
      builder: (BuildContext bc) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStateBtm) {
            return Container(
              height: size.height * 0.50,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  topLeft: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: size.height * 0.36,
                    child: ListView.builder(
                      itemCount: titleList.length,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.fromLTRB(15.0.w,15.0.h,15.0.w,10.0.h),
                      itemBuilder: (context,index){
                        return listTile(
                          Checkbox(
                            activeColor: black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                              side: const BorderSide(
                                color: black,
                                width: 2.0,
                              ),
                            ),
                            checkColor: Colors.white,
                            value: radioList[index], 
                            onChanged: (value){
                              setStateBtm(() {
                                radioList[index] = !radioList[index];
                              });
                            }
                          ),
                          titleList[index].toString(),
                          context,
                          (){
                            setStateBtm(() {
                              radioList[index] = !radioList[index];
                            });
                          }
                        );
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal:16.0.w,),
                    margin: EdgeInsets.only(bottom: 20.0.h),
                    width: double.infinity, 
                    height: 71.0.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: CustomButton(
                        text: '公開確定する',
                        buttonRadius: 30.0,
                        prefixIcon: const SizedBox(),
                        suffixIcon: const SizedBox(),
                        ontap: (){
                          isFromSearch == true ? Get.back() :
                          Get.to(()=> ProductPostPage(images: images,));
                          radioList = List.filled(titleList.length, false);
                        }
                      )
                    ),
                  )
                ],
              )
            );
          }
        );
      }
    );
  }
}

listTile(Widget radio, String title, context, VoidCallback onTap){
  return InkWell(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 15.0),
      child: Row(
        children: [
          radio,
          Text(title,style: w7f15(black),),
        ],
      ),
    ),
  );
}