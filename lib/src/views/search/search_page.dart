
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:nafcassete/src/controller/folder_controller.dart';
import 'package:nafcassete/src/controller/showcase_controller.dart';
import 'package:nafcassete/src/helpers/styles.dart';
import 'package:nafcassete/src/views/search/productdetail_page.dart';
import 'package:nafcassete/src/widgets/custom_appbar.dart';
import 'package:nafcassete/src/widgets/custom_cached_network_image.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}
class _SearchPageState extends State<SearchPage> {
  final ShowCaseController _showcaseCon =Get.put(ShowCaseController());
  final FolderController _folderCon = Get.put(FolderController());

  @override
  void initState() {
    initialise();
    super.initState();
  }

  initialise() async{
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await _showcaseCon.getShowcaseList();
      await _folderCon.getFolderList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: extendedAppBar(),
        body: RefreshIndicator(
          color: redCol,
          onRefresh: (){
            return Future.delayed(const Duration(seconds: 1),()async{
              await _showcaseCon.getShowcaseList();
            });
          },
          child: SingleChildScrollView(
            child: Obx(()=>
              _showcaseCon.showcaseLoading.isTrue 
              ? SizedBox(
                height: 640.0.h,
                child: const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: white,
                    color: redCol,
                  ),
                ),
              ) : imageGrdiList(),
            ),
          ),
        ),
      ),
    );
  }

  //list of image in stragged grid view
  imageGrdiList() {
    return Padding(
      padding: EdgeInsets.fromLTRB(15.0.w, 0.0, 15.0.w, 15.0.h),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        children: List.generate(_showcaseCon.showCaseData.length, (index) {
          return GridTile(
            child: GestureDetector(
              onTap: (){
                Get.to(()=> ProductDetailPage(
                  title: _showcaseCon.showCaseData[index].name.toString(),
                  detailId: _showcaseCon.showCaseData[index].id,
                  showCaseData: _showcaseCon.showCaseData,
                  folderList: _folderCon.folderlist,
                  idx: index,
                  from: 'search',
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
                          height: 121.0.h,
                          width: double.infinity,
                          child: DisplayNetworkImage(
                            imageUrl: _showcaseCon.showCaseData[index].image.toString(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.0.h,),
                  SizedBox(
                    height: 40.0.h,
                    child: Text(_showcaseCon.showCaseData[index].name.toString(), style: w4f12(textGrey), maxLines: 2,)
                  ),
                ], 
              ),
            ),
          );
        }),
      ),
    );
  }
  
}

