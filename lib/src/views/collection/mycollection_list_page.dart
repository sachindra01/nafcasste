// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:nafcassete/src/controller/favorite_controller.dart';
import 'package:nafcassete/src/controller/folder_controller.dart';
import 'package:nafcassete/src/helpers/read_write.dart';
import 'package:nafcassete/src/helpers/styles.dart';
import 'package:nafcassete/src/views/search/productdetail_page.dart';
import 'package:nafcassete/src/widgets/custom_appbar.dart';
import 'package:nafcassete/src/widgets/custom_cached_network_image.dart';
import 'package:nafcassete/src/widgets/custom_searchbar.dart';
import 'package:nafcassete/src/widgets/custsom_shimmer.dart';
import 'package:nafcassete/src/widgets/modal_sheet.dart';

class MyCollectionListPage extends StatefulWidget {
  const MyCollectionListPage({super.key});

  @override
  State<MyCollectionListPage> createState() => _MyCollectionListPageState();
}

class _MyCollectionListPageState extends State<MyCollectionListPage> {
  final FolderController _folderController = Get.put(FolderController());
  final FavoriteController controller =Get.put(FavoriteController());
  final TextEditingController _folderText =TextEditingController();
  bool openSheet=false;

  @override
  void initState() {
    initialise();
    super.initState();
  }

  initialise() async{
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await _folderController.getFolderList();
      await   controller.getShowfavoriteData(_folderController.folderId.toString());
    });
  }

  @override
  Widget build(BuildContext context) { 
    return  SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar:extendedAppBar(),
        body:contentBody(context),
      ),
    );
  }

  //content 
  contentBody(context){
    return RefreshIndicator(
      color: redCol,
      onRefresh: ()async{
        // return Future.delayed(const Duration(seconds: 1),()async{
        //   await _collectionController.getfavCollectionData();
        // }); 
      },
      child: SingleChildScrollView(
        child: GetBuilder(
          init: FavoriteController(),
          builder: (ctx) {
            return  Padding(
                padding: EdgeInsets.fromLTRB(15.0.w,0.0,15.0.w,15.0.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                         SizedBox(
                          height: 30.h,
                          width: 77.h,
                          child: GestureDetector(
                            onTap:(){
                              // var selectedFolder =
                              ModalBottomSheet.moreModalBottomSheet(context,_folderController.folderlist);
                              // setState(() {
                              //   // _folderController.foldername = selectedFolder;
                              // });
                            } ,
                            child:Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: const Color(0XFFD9D9D9),
                                  width: 1.0.sp,
                                ),
                                borderRadius: BorderRadius.circular(20.0.r),
                              ),
                              child:
                              Obx(()=>_folderController.folderLoading.isTrue
                              ? Padding(
                               padding: const EdgeInsets.all(8.0),
                                child: CustomShimmer(
                                  height: 5,
                                  width: 80.w,
                                ),
                              )
                              : SizedBox(
                                child: Row(
                                    children: [
                                      Obx(() => 
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              _folderController.foldername.toString(),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                               style: w4f12(textGrey),),
                                          ),
                                        )
                                      ),
                                      const Icon(Icons.keyboard_arrow_down,color: textGrey,
                                      )
                                    ],
                                  ),
                              ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 5.h,
                        ),
                        searchBar(),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // InkWell(
                        //   onTap: () {
                        //     showCommentDialogue();
                        //   },
                        //   child: Container(
                        //     height: 40.h,
                        //     decoration: BoxDecoration(
                        //       border: Border.all(
                        //           color: redCol,
                        //           width: 1.0.sp,
                        //         ),
                        //         borderRadius: BorderRadius.circular(5.0.r),
                        //     ),
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(8.0),
                        //       child: Center(child: Text("+フォルダ作成", style: w7f14(redCol),),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(
                        //   width: 10.w,
                        // ),
                         Container(
                          height: 40.h,
                          width: 60.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: redCol,
                                width: 1.0.sp,
                              ),
                              borderRadius: BorderRadius.circular(5.0.r),
                  
                          ),
                          child: Center(child: Text("選択", style: w7f14(redCol),),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Obx(()=>controller.isfavoriteLoading.isTrue||_folderController.folderLoading.isTrue
                      ? SizedBox(
                        height: 540.h,
                        child:  const Center(child: CircularProgressIndicator(
                          backgroundColor: white,
                          color: redCol,
                        )),
                      )
                      : controller.favoriteData!=null
                      ? imageGrdiList()
                      :  SizedBox(
                          height: 540.h,
                          child: const Center(child: CircularProgressIndicator(
                            backgroundColor: white,
                            color: redCol,
                          )
                        ),
                      )
                    )
                  ],
                ),
            );
          }
        ),
      ),
    );
  }

  showCommentDialogue() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState){
          return Dialog(
            insetPadding: EdgeInsets.fromLTRB(20.0.w,50.0.h,20.0.w,350.0.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0.r),
            ),
            child: Padding(
              padding: EdgeInsets.only(left:24.0.w,right: 16.0.w, top: 10.0.w, bottom: 10.0.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(),
                      IconButton(
                        onPressed: (){
                          Get.back();
                        }, 
                        icon: Icon(Icons.clear, color: black, size: 20.0.sp,)
                      )
                    ],
                  ),
                  SizedBox(height: 8.0.h,),
                   Obx(()=>_folderController.foldercreateLoading.isTrue
                   ? const CircularProgressIndicator(
                      backgroundColor: white,
                      color: redCol,
                    )
                   :SizedBox(
                      width: 306.w,
                      child: TextFormField(
                        controller: _folderText,
                        decoration: InputDecoration(
                          hintText: '新規フォルダ作成',
                          hintStyle:  w5f15(
                            darkgrey
                          ),
                          labelStyle: const TextStyle(
                            color: darkgrey,
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: darkgrey),
                          ),
                          prefixIcon:  const Icon(Icons.add,color: darkgrey,),
                        ),
                        onFieldSubmitted: (value)async {
                        await  _folderController.createFolder(_folderText.text.toString());
                        _folderText.clear();
                          Get.back();
                        _folderController.getFolderList();
                        },
                      ),
                    ),
                   ),
                ],
              ),
            )
          );
        });
      }
    );
  }
  //list of image in stragged grid view
  imageGrdiList() {
    return StaggeredGrid.count(
      crossAxisCount: 2,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: List.generate(controller.favoriteData.data.length, (index) {
      var data =controller.favoriteData.data[index];
      if(data.creatorId!=null &&data.creatorId==read('garageId')){
        return GridTile(
          child: GestureDetector(
            onTap: (){
              Get.to(()=> ProductDetailPage(
                detailId: controller.favoriteData.data[index].id,
                showCaseData:controller.favoriteData.data,
                folderList: _folderController.folderlist,
                idx: index,
                from: 'favourite',
              )); 
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0.r),
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: DisplayNetworkImage(
                          imageUrl:data.image
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6.0.h,),
                Text( data.name.toString(), style: w7f14(black), maxLines: 1,),
                SizedBox(height: 2.0.h,),
                SizedBox(
                  height: 20.0.h,
                  child: Text(data.profiles.discription, style: w4f12(textGrey), maxLines: 1,)),
                SizedBox(height: 2.0.h,),
              ], 
            ),
          ),
        );
      }else{
        return const SizedBox(
        );
      }
      }),
    );
  }
  searchBar() {
    return Expanded(
      child: Container(
        color: Colors.transparent,
        child: SizedBox(
          height: 40.0.h,
          width: 260.w,
          child: CustomSearchBar(
            backgroundColor: grey,
            onTap: (){},
          )
        ),
      ),
    );
  }
}


