import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nafcassete/src/bottom_nav.dart';
import 'package:nafcassete/src/controller/collection_controller.dart';
import 'package:nafcassete/src/controller/folder_controller.dart';
import 'package:nafcassete/src/controller/showcase_controller.dart';
import 'package:nafcassete/src/helpers/constant.dart';
import 'package:nafcassete/src/helpers/styles.dart';
import 'package:nafcassete/src/widgets/custom_appbar.dart';
import 'package:nafcassete/src/widgets/custom_cached_network_image.dart';
import 'package:nafcassete/src/widgets/preview_modalsheet.dart';

class ProductDetailPage extends StatefulWidget {
  final String? title, from, detailId;
  final List? folderList, showCaseData;
  final int? idx;
  final bool? creator;
  const ProductDetailPage({super.key, this.idx,  this.creator, required this.from, this.detailId, this.folderList, this.showCaseData, this.title});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final CollectionController controller = Get.put(CollectionController());
  final ShowCaseController _showcaseCon =Get.put(ShowCaseController());
  final FolderController folderController =Get.put(FolderController());
  final TextEditingController addToFolderText = TextEditingController();
  bool hideCoordinates = true;
  OverlayEntry? _overlayEntry;
  GlobalKey? overlayButtonKey;
  bool isScrolled = false;
  late ScrollController _scrollController;
  List imgDetailList =[];
  int? idx, idxL;
  int? carouset;
  int? selectedIndex = -1;
  List coordinatingNameList = [];
  
  @override
  void initState() {
    super.initState();
    _showcaseCon.getShowcaseDetail(widget.detailId);
    idx = widget.idx!;
    _scrollController = ScrollController();
    initialise();
  }
  
  @override
  void dispose() {
    _scrollController.dispose();
    _hideBubble();
    super.dispose();
  }

  initialise() async{
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await folderController.getFolderList();
    });
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
          appBar: customAppbar(widget.title, 0),
          floatingActionButton: floatingButton(),
          resizeToAvoidBottomInset: false,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          backgroundColor: white,
          body: RefreshIndicator(
            color: redCol,
            onRefresh: (){
              return Future.delayed(const Duration(seconds: 1),()async{
                _showcaseCon.getShowcaseDetail(widget.showCaseData![idx!].id);
              });
            },
            child: SingleChildScrollView(
              child: Obx(()=>
                _showcaseCon.showcaseDetailLoading.isTrue
                ? SizedBox(
                  height: 640.0.h,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: redCol,
                    ),
                  ),
                ) 
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    imageView(),
                    description(),
                    Container(
                      color: lightgrey,
                      height: 20.0.h,
                    ),
                    coordinatingProducts(),
                    Container(
                      color: white,
                      height: 110.0.h,
                    )
                  ],
                ),
              )
            ),
          ),
        ),
      ),
    );
  }
  
  //carousel
  imageView() {
    return SizedBox(
      height: 500.0.h,
      child: CarouselSlider.builder(
        unlimitedMode: true,
        itemCount: _showcaseCon.showCaseDetailImg.isEmpty ? 1 : _showcaseCon.showCaseDetailImg.length,
        scrollPhysics: _showcaseCon.showCaseDetailImg.isEmpty || _showcaseCon.showCaseDetailImg.length == 1
          ? const NeverScrollableScrollPhysics() 
          : const BouncingScrollPhysics(),
        autoSliderDelay: const Duration(hours:1),
        autoSliderTransitionTime: const Duration(hours:1),
        slideIndicator: CircularSlideIndicator(
          itemSpacing: 15.0.sp,
          indicatorRadius: 5.r,
          indicatorBorderColor: _showcaseCon.showCaseDetailImg.isEmpty || _showcaseCon.showCaseDetailImg.length == 1 ? Colors.transparent : white,
          indicatorBackgroundColor:Colors.transparent,
          currentIndicatorColor: _showcaseCon.showCaseDetailImg.isEmpty || _showcaseCon.showCaseDetailImg.length == 1? Colors.transparent : white,
          padding: EdgeInsets.only(bottom: 40.0.h),
        ),
        onSlideChanged: (set){
          setState(() {
            carouset = set;
          });
        },
        onSlideStart: () {
          _hideBubble();
        },
        slideBuilder: (int carouselIndex) {
          return carouset == 0 || carouselIndex == 0 ? 
          Stack(
            children: [
              DisplayNetworkImage(
                imageUrl: _showcaseCon.showCaseDetailImg.isEmpty ? "null" : '${garageApi}v1.0/file/thumbnail/${_showcaseCon.showCaseDetailImg[carouselIndex]}',
                width: double.infinity,
                height: 537.0.h,
              ),
              hideCoordinates == true ? const SizedBox() : markersWid(_showcaseCon.showCaseDetailsPinned, context),
              _showcaseCon.showCaseDetailsPinned.isNotEmpty ?
              Positioned(
                bottom: 20.0.h,
                right: 20.0.w,
                child: InkWell(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onTap: (){
                    _hideBubble();
                    setState(() {
                      hideCoordinates = !hideCoordinates;
                    });
                  },
                  child: Container(
                    height: 33.0.h, width: 33.0.h,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: redCol,
                    ),
                    child: Icon(Icons.location_on_sharp, color: white, size: 20.0.sp,),
                  )
                ),
              )
              : const SizedBox(),
              widget.creator == true?
              Positioned(
                top: 20.0.h,
                right: 20.0.w,
                child: GestureDetector(
                  onTap: (){
                    _hideBubble();
                    setState(() {
                      // Get.to(()=> AddCoordinatePage(
                      //   image: widget.image, imageList: widget.catergoryImgList,
                      //   coordinatesList: widget.cordinatesList,
                      //   from: widget.from == 'favourite' ? 'favourite' : 
                      //   widget.from == 'collection' ? 'collection'
                      //   : 'search',
                      // ));
                      hideCoordinates = true;
                    });
                  },
                  child: Container(
                    height: 30.0.h, width: 77.0.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0.r),
                      color: redCol,
                    ),
                    child: Center(child: Text('ピン編集', style: w4f13(white), textAlign: TextAlign.center,))
                  )
                ),
              ) : const SizedBox(),
            ],
          ):
          DisplayNetworkImage(
            imageUrl: _showcaseCon.showCaseDetailImg.isEmpty? _showcaseCon.showCaseDetailImg : _showcaseCon.showCaseDetailImg[carouselIndex],
          );
        }
      )
    );
  }
  
  description() {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0.w,20.0.h,15.0.w,0.0.h),
      margin: EdgeInsets.only(bottom: 16.0.h),
      width: double.infinity,
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(_showcaseCon.showCaseDetailDesc,style: w4f13(black),)
        ],
      ),
    );
  }
  
  coordinatingProducts() {
    return _showcaseCon.similarItems.isEmpty ? const SizedBox() 
    : Container(
      padding: EdgeInsets.fromLTRB(15.0.w,20.0.h,15.0.w,20.0.h),
      width: double.infinity,
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('掲載されている商品 ', style: w7f20(black),),
          SizedBox(height: 20.0.h,),
          StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: List.generate(_showcaseCon.similarItems.length > 4 ? 4 : _showcaseCon.similarItems.length, (index) {
              coordinatingNameList.add(_showcaseCon.similarItems[index]["name"]);
              return GridTile(
                child: GestureDetector(
                  onTap: (){
                    // Get.to(()=> ProductCategoryPage(
                    //   imageList: widget.catergoryImgList!,
                    //   description: widget.description,
                    //   image: widget.image,
                    //   title: widget.title,
                    // ));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            imageUrl: _showcaseCon.similarItems[index]["image"],
                            fit: BoxFit.cover,
                          ),
                        )
                      ),
                      SizedBox(height: 10.0.h,),
                      Text(' ${_showcaseCon.similarItems[index]["name"] ?? ""}', style: w7f12(black),),
                      Text(_showcaseCon.similarItems[index]["sub"] ?? "", style: w5f10(lightGreyCol),),
                      SizedBox(height: 2.0.h,)
                    ],
                  ),
                )
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
        child: FloatingActionButton(
          elevation: 0.0,
          backgroundColor:greyCol,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36.0.r),
          ),
          onPressed: () {
            // Handle button press
          },
          highlightElevation: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    idx = idx! == 0 ? idx! : idx! - 1 ;
                  });
                  _showcaseCon.getShowcaseDetail(widget.showCaseData![idx!].id);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0.r),
                    color: white,
                  ),
                  height: 28.0.h,
                  width: 28.0.h,
                  child: const Icon(Icons.arrow_back, color: greyCol,)
                ),
              ),
              SizedBox(width: .1.w,),
              GestureDetector(
                onTap: (){
                  favouriteDialogBox();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0.r),
                    color: white,
                  ),
                  height: 40.0.h,
                  width: 40.0.h,
                  child: const Icon(Icons.favorite_outline, color: black,)
                ),
              ),
              GestureDetector(
                onTap: (){
                  notIntersetDialog();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0.r),
                    color: white,
                  ),
                  height: 40.0.h,
                  width: 40.0.h,
                  child: const Icon(Icons.visibility_off, color: black,)
                ),
              ),
              GestureDetector(
                onTap: (){
                  thumnbsUpDialog();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0.r),
                    color: white,
                  ),
                  height: 40.0.h,
                  width: 40.0.h,
                  child: const Icon(Icons.thumb_up_off_alt_outlined, color: black,)
                ),
              ),
              GestureDetector(
                onTap: (){
                  showCommentDialogue();
                  Future.delayed(const Duration(seconds: 1), () {
                    Get.to(()=> const BottomNavbar(index: 3));
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0.r),
                    color: white,
                  ),
                  padding: EdgeInsets.all(10.0.sp),
                  child: SvgPicture.asset(
                    'assets/icons/bubble.svg',
                    height: 20.h,
                    width: 20.h,
                    colorFilter: const ColorFilter.mode(black, BlendMode.srcIn)
                  ),
                ),
              ),
              SizedBox(width: .1.w,),
              GestureDetector(
                onTap: (){
                  setState(() {
                    carouset = 0;
                    idx = idx! == widget.showCaseData!.length-1 ? idx! : idx! + 1 ;
                  });
                  _showcaseCon.getShowcaseDetail(widget.showCaseData![idx!].id);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0.r),
                    color: white,
                  ),
                  height: 28.0.h,
                  width: 28.0.h,
                  child: const Icon(Icons.arrow_forward, color: greyCol,)
                ),
              ),
            ],
          ),
        ),
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
          left: items['x']+0.0.w,
          top: items['y']+0.0.h,
          child: InkWell(
            key: buttonKey,
            onTap: () {
              _showBubble(context, buttonKey);
              debugPrint(i.toString());
            },
            child: Container(
              height: 28.0.h, width: 28.0.h,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: redCol,
              ),
              child: Center(child: Icon(Icons.circle, color: white, size: 16.0.sp,)),
            )
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
          top: buttonPosition.dy < 170 ? buttonPosition.dy - buttonSize.height + 40.0 :
               buttonPosition.dy - buttonSize.height - 25.0, // Adjust the offset as needed
          left: buttonPosition.dx < 200 ? buttonPosition.dx - (buttonSize.width / 2) + 25.0.w :
                buttonPosition.dx - (buttonSize.width / 2) - 115.0.w,
          child: GestureDetector(
            onTap: () {
              _hideBubble(); // Hide the overlay when tapped

              // Get.to(()=> ProductCategoryPage(
              //   imageList: widget.catergoryImgList!,
              //   description: widget.description,
              //   image: widget.image,
              //   title: widget.title,
              // ));
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 7.0.w, vertical: 14.0.h),
              color: Colors.white,
              child: Center(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          coordinatingNameList[0],
                          style: w7f14(black)
                        ),
                      ],
                    ),
                    SizedBox(width: 10.0.w,),
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
    overlayButtonKey = buttonKey; // Remember the button key of the current overlay
  }

  //hide bubble
  void _hideBubble() {
    _overlayEntry?.remove();
    _overlayEntry = null; // Reset the overlay entry
    overlayButtonKey = null; // Reset the button key
  }
  
  //dialog shown when bookmarked
  favouriteDialogBox() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, setState){
          return Dialog(
            backgroundColor: const Color.fromARGB(255, 63, 63, 63),
            insetPadding: EdgeInsets.fromLTRB(15.0.w,60.0.h,15.0.w,575.0.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0.r),
            ),
            child: Padding(
              padding: EdgeInsets.only(left:14.0.w,right: 14.0.w, top: 8.0.w),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('お気に入りに追加しました', style: w7f14(white),),
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
                      Text('保存先：　アイディア参考', style: w7f14(white),),
                      GestureDetector(
                        onTap: (){
                          folderBottomSheet(context, widget.folderList);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10.0.sp),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: white,
                              width: 1.0.sp
                            ),
                            borderRadius: BorderRadius.circular(6.0.r),
                          ),
                          child: Text('選択', style: w7f15(white),)
                        ),
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
                  Text(' 非表示に設定しました', style: w7f14(white),),
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
  thumnbsUpDialog() {
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
                  Text('いいねしました', style: w7f14(white),),
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
            insetPadding: EdgeInsets.fromLTRB(20.0.w,320.0.h,20.0.w,300.0.h),
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
                  Center(child: Text('ペタボを開きます', style: w7f20(black),)),
                ],
              ),
            )
          );
        });
      }
    );
  }
  
  folderBottomSheet(context, data) {
    dynamic folder;
    Size size = MediaQuery.of(context).size;
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
              height: size.height * 0.58,
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
                        //cancel
                        GestureDetector(
                          onTap: (){
                            Get.back();
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
                            if(folder != null){
                              _showcaseCon.addToFolder(folder.id, widget.detailId, folder.name);
                            }
                            Get.back();
                          },
                          child: SizedBox(
                            width: 60.w,
                            child: Center(child: Text('完了',style: w4f13(lightblue),)))
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.0.h,),
                  SizedBox(
                    width: 320.w,
                    child: TextFormField(
                      controller: addToFolderText,
                      decoration: const InputDecoration(
                        hintText: '新規フォルダ作成',
                        hintStyle:  TextStyle(
                          color: darkgrey,
                        ),
                        labelStyle: TextStyle(
                          color: darkgrey,
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: darkgrey),
                        ),
                        prefixIcon:  Icon(Icons.add,color: darkgrey,),
                      ),
                      onFieldSubmitted: (newValue)async{
                        await  folderController.createFolder(addToFolderText.text.toString());
                        await folderController.getFolderList();
                        addToFolderText.clear();
                      },
                    ),
                  ),
                  SizedBox(height: 10.0.h,),
                  Obx(() => folderController.folderLoading.isTrue ?
                    SizedBox(
                      height: size.height * 0.38,
                      child: const Center(child: CircularProgressIndicator(color: red,)),
                    ) :
                    SizedBox(
                      height: size.height * 0.38,
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
                              value:  selectedIndex == index,
                              onChanged: (bool?value){
                                setStateBtm(() {
                                  selectedIndex = value! ? index : -1;
                                  folder = data[index];
                                });
                              }
                            ),
                            data[index].name,
                            context,
                            (){
                              setStateBtm(() {
                              });
                            }
                          );
                        },
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
  
  

}