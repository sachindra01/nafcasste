// ignore_for_file: file_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:nafcassete/src/controller/collection_controller.dart';
import 'package:nafcassete/src/helpers/styles.dart';
import 'package:nafcassete/src/widgets/custom_appbar.dart';
import 'package:nafcassete/src/widgets/custom_button.dart';
import 'package:nafcassete/src/widgets/preview_modalsheet.dart';

class CollectionPreviewPage extends StatefulWidget {
  final String? image, title, description;
  final dynamic imagesList;
  const CollectionPreviewPage({super.key, this.image, this.title, this.description, this.imagesList});

  @override
  State<CollectionPreviewPage> createState() => _CollectionPreviewPageState();
}

class _CollectionPreviewPageState extends State<CollectionPreviewPage> {
  final CollectionController _collectionController =Get.put(CollectionController());
  bool hideCoordinates = true;
  OverlayEntry? _overlayEntry;
  // ignore: unused_field
  GlobalKey? _overlayButtonKey;
  bool isScrolled = false;
  late ScrollController _scrollController;
  
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    _hideBubble();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollUpdateNotification) {
          _hideBubble();    // hide bubble when scrolled
          setState(() {
            isScrolled = true;
          });
        } else{
          setState(() {
            isScrolled = false;
          });
        }
        return true;
      },
      child: GestureDetector(
        onTap: () {
          _hideBubble();
        }, 
        child: Scaffold(
          appBar: customAppbar('5/6', 0),
          floatingActionButton: floatingButton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          backgroundColor: grey,
          body: ScrollConfiguration(
            behavior:NoGlowScrollBehavior(),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imageView(),
                  description(),
                  // coordinatingProducts(),
                  categoryImages(),
                  Container(
                    color: white,
                    height: 90.0.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  
  //carousel
  imageView() {
    return SizedBox(
      height: 537.0.h,
      child: CarouselSlider.builder(
        unlimitedMode: true,
        itemCount: widget.imagesList.isEmpty ? 1 : widget.imagesList.length,
        slideIndicator: CircularSlideIndicator(
          itemSpacing: 15.0.sp,
          indicatorRadius: 5.r,
          indicatorBorderColor: white,
          indicatorBackgroundColor:Colors.transparent,
          currentIndicatorColor: white,
          padding: EdgeInsets.only(bottom: 40.0.h)
        ),
        slideBuilder: (index) {
          return index == 0 ? 
          Stack(
            children: [
              Image.file(
                widget.imagesList.isEmpty? widget.image : widget.imagesList[index],
                width: double.infinity,
                height: 537.0.h,
                fit: BoxFit.fitWidth,
              ),
              // hideCoordinates == true ? const SizedBox() : markersWid(coordinateList, context),
              Positioned(
                bottom: 20.0.h,
                right: 20.0.w,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: (){
                    setState(() {
                      hideCoordinates = !hideCoordinates;
                    });
                  },
                  child: Container(
                    height: 28.0.h, width: 28.0.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: redCol,
                      border: Border.all(
                        color: white,
                        width: 2.0.sp
                      )
                    ),
                  )
                ),
              ),
            ],
          ):
          Image.file(
            widget.imagesList.isEmpty? widget.image : widget.imagesList[index],
            fit: BoxFit.cover,
          );
        }
      )
    );
  }
  
  description() {
   String  description = "質感のあるエンボスPVCがお洒落なヴィンテージ感を出しています。ワイヤー棚がついており、雑誌しや小物などを置くことが出来ます。";
    return Container(
      padding: EdgeInsets.fromLTRB(15.0.w,43.0.h,15.0.w,23.0.h),
      margin: EdgeInsets.only(bottom: 16.0.h),
      width: double.infinity,
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(description,style: w5f15(black),)
        ],
      ),
    );
  }
  
  categoryImages() {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0.w,43.0.h,15.0.w,23.0.h),
      width: double.infinity,
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('コーディネート商品   ', style: w7f20(black),),
          SizedBox(height: 12.0.h,),
          StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: List.generate( _collectionController.categoryselectedImage.length, (index) {
              // List multiImg = imageList[index]['multiImage'] as List;
              return GridTile(
                child: GestureDetector(
                  onTap: (){},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12.0.r),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 121.0.h,
                              width: double.infinity,
                              child: Image.file(
                                File( _collectionController.categoryselectedImage[index].path),
                                fit: BoxFit.cover,
                              ),
                            ),
                            // multiImg.isEmpty ?
                            const SizedBox() 
                            // : Positioned(
                            //   top: 9.0.h,
                            //   right: 11.0.w,
                            //   child: Icon(Icons.image,color: white, size: 22.0.sp,)
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.0.h,),
                      Text("商品名9", style: w7f15(black),),
                      SizedBox(height: 1.0.h,),
                      Text("説明文説明文説明文", style: w4f12(textGrey),),
                      SizedBox(height: 6.0.h,),
                    ], 
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  floatingButton() {
    return Container(
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
            _hideBubble();
            PreviewModalBottomSheet.previewModalBottomSheet(context, false, widget.imagesList[0]);
          })
      ),
    );
  }
  
  

  //show cordinates  
  Widget markersWid(list, context) {
    List<Widget> datas = [];
    int i = 0;

    for (var index = 0; index < list.length; index++) {
      var items = list[index];
      GlobalKey buttonKey = GlobalKey();

      datas.add(
        Positioned(
          left: items['x']-25.0.w,
          top: items['y']- 110.0.h,
          child: InkWell(
            key: buttonKey,
            onTap: () {
              _showBubble(context, buttonKey);
              debugPrint('X => ${items['x']} && Y => ${items['y']}');
              debugPrint(i.toString());
            },
            child:  CircleAvatar(
              backgroundColor: redCol.withOpacity(0.7),
              child: Icon(Icons.circle, color: white, size: 20.0.sp,)
            ),
          ),
        ),
      );
      i++;
    }
    return Stack(
      clipBehavior: Clip.none,
      children: datas,
    );
  }

  //show bubble on taping cordinates
  void _showBubble(BuildContext context, GlobalKey buttonKey) {
    final RenderBox buttonBox = buttonKey.currentContext!.findRenderObject() as RenderBox;
    final buttonSize = buttonBox.size;
    final buttonPosition = buttonBox.localToGlobal(Offset.zero);

    // Remove any existing overlay entry
    _hideBubble();

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          top: buttonPosition.dy - buttonSize.height - 20.0, // Adjust the offset as needed
          left: buttonPosition.dx - (buttonSize.width / 2) + 40.0, // Adjust the offset as needed
          child: GestureDetector(
            onTap: () {
              _hideBubble(); // Hide the overlay when tapped
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 7.0.w, vertical: 16.0.h),
              color: Colors.white,
              child: Center(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '食器棚K 3プレ...',
                          style: w7f14(black)
                        ),
                        Text(
                          '￥27,956',
                          style: w6f15(black)
                        ),
                      ],
                    ),
                    const VerticalDivider(
                      endIndent: 0,
                      indent: 0,
                      color: black,
                    ),
                    SizedBox(width: 30.0.w,),
                    Icon(Icons.arrow_forward_ios, size: 20.0.sp,)
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    _overlayButtonKey = buttonKey; // Remember the button key of the current overlay
  }

  //hide bubble
  void _hideBubble() {
    _overlayEntry?.remove();
    _overlayEntry = null; // Reset the overlay entry
    _overlayButtonKey = null; // Reset the button key
  }
  
  //dialog shown when bookmarked
  bookmarkedDialog() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState){
          return Dialog(
            backgroundColor: const Color.fromARGB(255, 63, 63, 63),
            insetPadding: EdgeInsets.fromLTRB(15.0.w,60.0.h,15.0.w,620.0.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0.r),
            ),
            child: Padding(
              padding: EdgeInsets.only(left:24.0.w,right: 16.0.w, top: 16.0.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Japanese Text', style: w7f20(white),),
                      IconButton(
                        onPressed: (){
                          Get.back();
                        }, 
                        icon: Icon(Icons.clear, color: white, size: 20.0.sp,)
                      )
                    ],
                  ),
                  SizedBox(height: 8.0.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Japanese Text', style: w7f20(white),),
                      Container(
                        padding: EdgeInsets.all(10.0.sp),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: white,
                            width: 1.0.sp
                          ),
                          borderRadius: BorderRadius.circular(6.0.r),
                        ),
                        child: Text('Japanese Text', style: w5f15(white),)
                      ),
                    ],
                  ),
                ],
              ),
            )
          );
        });
      }
    );
  }

  //dialog shown when not INtereste
  notIntersetDialog() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState){
          return Dialog(
            backgroundColor: const Color.fromARGB(255, 63, 63, 63),
            insetPadding: EdgeInsets.fromLTRB(15.0.w,28.0.h,15.0.w,652.0.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0.r),
            ),
            child: Padding(
              padding: EdgeInsets.only(left:24.0.w,right: 16.0.w, top: 10.0.w, bottom: 10.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Japanese Text', style: w7f20(white),),
                  IconButton(
                    onPressed: (){
                      Get.back();
                    }, 
                    icon: Icon(Icons.clear, color: white, size: 20.0.sp,)
                  )
                ],
              ),
            )
          );
        });
      }
    );
  }

  //dialog shown when added to favourite
  addToFavouriteDialogue() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState){
          return Dialog(
            backgroundColor: const Color.fromARGB(255, 63, 63, 63),
            insetPadding: EdgeInsets.fromLTRB(15.0.w,28.0.h,15.0.w,652.0.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0.r),
            ),
            child: Padding(
              padding: EdgeInsets.only(left:24.0.w,right: 16.0.w, top: 10.0.w, bottom: 10.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Japanese Text', style: w7f20(white),),
                  IconButton(
                    onPressed: (){
                      Get.back();
                    }, 
                    icon: Icon(Icons.clear, color: white, size: 20.0.sp,)
                  )
                ],
              ),
            )
          );
        });
      }
    );
  }

  // dialog shown when added to favourite
  showCommentDialogue() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState){
          return Dialog(
            insetPadding: EdgeInsets.fromLTRB(20.0.w,330.0.h,20.0.w,330.0.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0.r),
            ),
            child: Padding(
              padding: EdgeInsets.only(left:24.0.w,right: 16.0.w, top: 10.0.w, bottom: 30.0.w),
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
                  SizedBox(height: 14.0.h,),
                  Center(child: Text('Japanese Text', style: w7f20(black),)),
                ],
              ),
            )
          );
        });
      }
    );
  }
}