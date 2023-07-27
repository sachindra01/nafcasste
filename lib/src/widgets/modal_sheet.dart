import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nafcassete/src/controller/favorite_controller.dart';
import 'package:nafcassete/src/controller/folder_controller.dart';
import 'package:nafcassete/src/helpers/styles.dart';
import 'package:nafcassete/src/widgets/custom_button.dart';
import 'package:nafcassete/src/widgets/custom_dailog.dart';
import 'package:nafcassete/src/widgets/preview_modalsheet.dart';

class ModalBottomSheet {
  static  moreModalBottomSheet(context, [data,isFromProductDetails]) {
    Size size = MediaQuery.of(context).size;
    int selectedIndex = -1;
    dynamic folderid ;
    final FavoriteController controller =Get.put(FavoriteController());
    final FolderController folderController =Get.put(FolderController());
    showModalBottomSheet(
      isDismissible: false,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      context: context,
      builder: (BuildContext ctx) {
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
                    height: 10.h,
                  ),
                  Container(
                    height: 6.0.h,
                    width: 80.0.w,
                    decoration: BoxDecoration(
                      color: lightGreyCol,
                      borderRadius: BorderRadius.circular(30.0.r)                      
                    ),
                  ),
                  SizedBox(
                    height: 6.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:20.0,bottom: 10.0,right: 15.0,left: 15.0 ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: SizedBox(
                            width: 60.0.w,
                            child: Center(child: Text('戻る',style: w4f14(darkgrey),))
                          ),
                        ),
                        Center(child: Text('お気に入りフォルダの選択',style: w7f14(black),)),
                        GestureDetector(
                          onTap: (){
                             controller.getShowfavoriteData(folderid);
                              Get.back(result:folderController.foldername);
                              controller.getShowfavoriteData(folderid);
                          },
                          child: SizedBox(
                            width: 60.w,
                            child: Center(child: Text('完了',style: w4f13(lightblue),)))
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6.0.h,), 
                  SizedBox(
                    height: size.height * 0.33,
                    child: ListView.builder(
                      itemCount:data.length,
                      padding: EdgeInsets.fromLTRB(10.0.w,15.0.h,10.0.w,10.0.h),
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
                            value:data[index].name.contains(folderController.foldername.value.toString())
                              ? true
                              : selectedIndex == index,
                            onChanged: (bool?value){
                              setStateBtm(() {
                                selectedIndex = value! ? index : -1;
                                folderid =  data[index].id;
                                folderController.foldername.value=data[index].name;
                              });
                            }
                          ),
                          data[index].name,
                          context,
                          (){
                            setStateBtm(() {
                                folderid =  data[index].id;
                                folderController.foldername.value=data[index].name;
                            });
                          }
                        );
                      },
                    ),
                  ),
                  Obx(()=>folderController.folderdeleteLoading.isTrue
                  ? const CircularProgressIndicator(
                    backgroundColor: white,
                    color: redCol,
                  )
                  : CustomButton(
                    buttonRadius: 40.0,
                    prefixIcon:const SizedBox(),
                    suffixIcon:const SizedBox() ,
                    bgColor: redCol,
                    text: 'フォルダを削除する',
                    ontap:() async{
                      customDialogBox(
                        context,
                        'このフォルダを削除する?',
                        ()async{
                          await  folderController.deleteFolder(folderid);
                          Get.back();
                          Get.back();
                          folderController.getFolderList();
                        },
                        (){
                           Get.back();
                        }
                      );
                     
                    },  
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