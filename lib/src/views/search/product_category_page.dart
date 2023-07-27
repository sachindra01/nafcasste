import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:nafcassete/src/helpers/styles.dart';
import 'package:nafcassete/src/widgets/custom_appbar.dart';
import 'package:nafcassete/src/widgets/custom_cached_network_image.dart';
import 'package:nafcassete/src/widgets/modal_sheet.dart';

class ProductCategoryPage extends StatefulWidget {
  final String? image, title, description;
  final List imageList;
  const ProductCategoryPage({super.key, this.image, this.title, this.description, required this.imageList});

  @override
  State<ProductCategoryPage> createState() => _ProductCategoryPageState();
}

class _ProductCategoryPageState extends State<ProductCategoryPage> {
  int activePage = 1;
  bool brownCol =true;
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar('あいうえお', 0),
      backgroundColor: grey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: RefreshIndicator(
        color: redCol,
        onRefresh: (){
          return Future.delayed(const Duration(seconds: 1));
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height - kToolbarHeight -30.0.h,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageView(),
                colorOptions(),
                titleAndPrice(),
                dropDown(),
                coordinatingProducts(),
                similarCordinates(),
                Container(
                  color: white,
                  height: 10.0.h,
                )
              ],
            ),
          ),
        ),
      )
    );
  }
  
  //carousel
  imageView() {
    return Container(
      color: white,
      height: 390.0.h,
      child: CarouselSlider.builder(
        unlimitedMode: true,
        itemCount: widget.imageList.isEmpty ? 1 : widget.imageList.length,
        slideIndicator: CircularSlideIndicator(
          itemSpacing: 15.0.sp,
          indicatorRadius: 5.r,
          indicatorBorderColor: grey,
          indicatorBackgroundColor:Colors.transparent,
          currentIndicatorColor: grey,
          padding: EdgeInsets.only(bottom: 40.0.h)
        ),
        slideBuilder: (index) {
          return DisplayNetworkImage(
            imageUrl: widget.imageList.isEmpty? widget.image : widget.imageList[index],
            fit: BoxFit.contain,
          );
        }
      )
    );
  }
  
  colorOptions() {
    return Container(
      decoration: const BoxDecoration(
        color: white,
        border: Border.symmetric(
          horizontal: BorderSide(
            color: grey,
            width: 1.2
          )
        )
      ),
      height: 61.0.h,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          children: [
            SizedBox(width: 10.0.w,),
            Text('カラー：', style: w4f13(black),),
            ...List.generate(5, (index) => 
              GestureDetector(
                onTap: (){
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 5.0.w),
                  padding: EdgeInsets.symmetric(horizontal :12.0.w,),
                  height: 32.0.h,
                  decoration: BoxDecoration(
                    color: selectedIndex == index ? redCol : const Color(0XFFECECEC),
                    borderRadius: BorderRadius.circular(20.0.r),
                  ),
                  child: Center(child: Text('ナチュラル', style: w5f12(selectedIndex == index ? white : black ),)),
                ),
              ),
            ),
            SizedBox(width: 10.0.w,),
          ],
        ),
      ),
    );
  }
  
  titleAndPrice() {
    return Container(
      color: white,
      padding: EdgeInsets.symmetric(horizontal : 14.0.w, vertical : 24.0.h,),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('棚付きテーブル ヴィンテス\nST WH：17916', style: w7f20(black),),
          SizedBox(height: 8.0.h,),
          RichText(
            text: TextSpan(
              text: '5,990',
              style:  w7f30(black),
              children: [
                TextSpan(
                  text: '円',
                  style: w7f15(black),
                ),
                TextSpan(
                  text: '（税込）',
                  style: w4f13(black),
                ),
              ]
            )
          ),
          SizedBox(height: 10.0.h,),
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellow, size: 24.0.sp,),
              Icon(Icons.star, color: Colors.yellow, size: 24.0.sp,),
              Icon(Icons.star, color: Colors.yellow, size: 24.0.sp,),
              Icon(Icons.star, color: grey, size: 24.0.sp,),
              Icon(Icons.star, color: grey, size: 24.0.sp,),
              Text('（78）', style: w4f12(black),)
            ],
          ),
          SizedBox(height: 20.0.h,),
          Text('質感のあるエンボスPVCがお洒落なヴィンテージ感を出しています。\nワイヤー棚がついており、雑誌しや小物などを置くことが出来ます。', style: w4f12(black),)
        ],
      ),
    );
  }
  
  dropDown() {
    return InkWell(
      onTap:(){
        ModalBottomSheet.moreModalBottomSheet(context);
      }, 
      child: Container(
        decoration: const BoxDecoration(
          color: white,
          border: Border.symmetric(
            horizontal: BorderSide(
              color: grey,
              width: 1.2
            )
          )
        ),
        height: 54.0.h,
        padding: EdgeInsets.symmetric(horizontal: 23.0.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('仕様・サイズ', style: w4f12(textGrey),),
            Icon(Icons.keyboard_arrow_down, color: lightGreyCol, size: 24.0.sp,)
          ],
        ),
      ),
    );
  }
  
  coordinatingProducts() {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0.w,32.0.h,15.0.w,0.0.h),
      margin: EdgeInsets.only(bottom: 16.0.h),
      width: double.infinity,
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('関連商品   ', style: w7f20(black),),
          SizedBox(height: 12.0.h,),
          SizedBox(
            height: 385.0.h,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, 
                mainAxisSpacing: 10.0, 
                crossAxisSpacing: 10.0, 
              ),
              itemCount: 4,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                  },
                  child: Container(
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
                        imageUrl: widget.imageList.isEmpty? widget.image : widget.imageList[index],
                        fit: BoxFit.contain,
                      ),
                    )
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
  
  similarCordinates() {
    return Container(
      padding: EdgeInsets.fromLTRB(15.0.w,33.0.h,15.0.w,23.0.h),
      width: double.infinity,
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('関連のカセット    ', style: w7f20(black),),
          SizedBox(height: 12.0.h,),
          StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            children: List.generate(4, (index) {
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
                              child: DisplayNetworkImage(
                                imageUrl: widget.imageList.isEmpty? widget.image : widget.imageList[index], 
                                fit: BoxFit.contain,
                              ),
                            ),
                          ],
                        ),
                      ),SizedBox(height: 10.0.h,),
                      SizedBox(
                        height: 40.0.h,
                        child: Text(widget.description.toString(), style: w4f12(textGrey), maxLines: 2,)
                      ),
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
  

}