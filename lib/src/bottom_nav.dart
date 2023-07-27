
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nafcassete/src/helpers/styles.dart';
import 'package:nafcassete/src/views/chat/chat_list.dart';
import 'package:nafcassete/src/views/collection/collection_listPage.dart';
import 'package:nafcassete/src/views/collection/mycollection_list_page.dart';
import 'package:nafcassete/src/views/others/others_page.dart';
import 'package:nafcassete/src/views/search/search_page.dart';


class BottomNavbar extends StatefulWidget {
  final int? index, tabIndex; 
  const BottomNavbar({Key? key, required this.index, this.tabIndex}) : super(key: key);

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  int selectedIndex = 0;
  var selectedDotIndex = 0.obs;
  List <Widget> ?pages;

  @override
  void initState() {
    super.initState();
    pages =  [
      const  CollectionListPage(),
      const  MyCollectionListPage(),
      const SearchPage(),
      const ChatList(),
      const OthersPage(),
    ];
    handleTap(widget.index);
  }

  handleTap(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: pages![selectedIndex],
        resizeToAvoidBottomInset: false,
        floatingActionButton: Padding(
          padding: EdgeInsets.only(top: 48.0.h),
          child: SizedBox(
            height: 86.h,
            width: 86.h,
            child: FloatingActionButton(
              onPressed: (){
                handleTap(2);
              },
              backgroundColor: white,
              foregroundColor: white,
              highlightElevation: 5,
              elevation: 0,
              child: Container(
                height: 74.h,
                width: 74.h,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: redCol
                ),
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/icons/menu.png',
                    height: 26.0.h,
                    width: 26.0.w,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 4.0.h,),
                  Text("ショールーム", style: w5f8(white),),
                  SizedBox(height: 4.0.h,),
                ],
              ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Container( 
          height: 95.0.h,
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: black.withOpacity(0.4),
                blurRadius: 15.0.r,
              ),
            ],
          ),
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.0.r),
                topRight: Radius.circular(16.0.r),
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: handleTap,
                currentIndex: selectedIndex,
                elevation: 10,
                backgroundColor: white,
                iconSize: 30.0.sp,
                unselectedItemColor: darkGreyCol,
                selectedItemColor: red,
                selectedFontSize: 10.0.sp,
                unselectedFontSize: 10.0.sp,
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom : 2.0.h),
                      child: SvgPicture.asset(
                        'assets/icons/fav.svg',
                        height: 24.h,
                        width: 24.h,
                        colorFilter: ColorFilter.mode(selectedIndex == 0 ? red : darkGreyCol, BlendMode.srcIn)
                      ),
                    ),
                    label: "お気に入り",
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom : 2.0.h),
                      child: const Icon(Icons.add_box_outlined),
                    ),
                    label: "MYカセット",
                  ),
                  const BottomNavigationBarItem(
                    icon:Icon(Icons.home),
                    label: "",
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom : 4.0.h,top: 7.0.h),
                      child: SvgPicture.asset(
                        'assets/icons/chat.svg',
                        height: 23.h,
                        width: 28.h,
                        colorFilter: ColorFilter.mode(selectedIndex == 3 ? red : darkGreyCol, BlendMode.srcIn)
                      ),
                    ),
                    label: "ペタボ",
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(bottom : 2.0.h),
                      child: const Icon(Icons.more_horiz),
                    ),
                    label: "その他",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}