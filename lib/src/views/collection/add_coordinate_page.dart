import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nafcassete/src/controller/collection_controller.dart';
import 'package:nafcassete/src/helpers/styles.dart';
import 'package:nafcassete/src/widgets/coordinate_bottomsheet.dart';
import 'package:nafcassete/src/widgets/custom_appbar.dart';
import 'package:nafcassete/src/widgets/custom_button.dart';
import 'package:nafcassete/src/widgets/custom_cached_network_image.dart';

class AddCoordinatePage extends StatefulWidget {
  final dynamic image;
  final dynamic imageList;
  final dynamic coordinatesList;
  final String? from;
  const AddCoordinatePage({super.key, this.image, this.imageList, this.coordinatesList, this.from});

  @override
  State<AddCoordinatePage> createState() => _AddCoordinatePageState();
}

class _AddCoordinatePageState extends State<AddCoordinatePage> {
  final GlobalKey imageKey = GlobalKey();
  bool isBubbleShown = false;
  bool isAddPostBubbleShown = false;
  Offset? tapPosition;

  OverlayEntry? _overlayEntry;
  GlobalKey? overlayButtonKey;
  GlobalKey buttonKey = GlobalKey();
  late ScrollController scrollController;
  List productsInImage = [];
  bool isScrolled = false;

   void hideBubble() {
    _overlayEntry?.remove();
    _overlayEntry = null; // Reset the overlay entry
    overlayButtonKey = null;
  }

   void handleTapDown(TapUpDetails details) {
    //on tap down
    final RenderBox box = context.findRenderObject() as RenderBox;
    final Offset tapPosition = box.globalToLocal(details.globalPosition);
    hideBubble();
    setState(() {
      this.tapPosition = tapPosition;
    });
    debugPrint("x:${tapPosition.dx}, y:${tapPosition.dy}");
  }

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
  }
  
  @override
  void dispose() {
    scrollController.dispose();
    hideBubble();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification notification) {
        if (notification is ScrollUpdateNotification) {
          hideBubble();    // hide bubble when scrolled
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
        onTap: (){
          hideBubble();
        },
        child: Scaffold(
          appBar: customAppbar(
            'ピン留め',
            0.0,
            [
              TextButton(
                onPressed:(){
                  Get.back();
                },
                child: Text('保存',style: w7f14(black))
              )
            ]
          ),
          body: GetBuilder(
            init: CollectionController(),
            builder: (_) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
                       onTapUp: isBubbleShown == false
                      ? handleTapDown 
                      : (value){},
                      child: SizedBox(
                        height: 500.0.h,
                        child: Stack(
                          children: [
                            Container(
                              key: imageKey,
                              child: DisplayNetworkImage(
                                imageUrl: widget.image,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                              ),
                            ),
                            tapPosition == null || widget.coordinatesList.isEmpty
                             ? const SizedBox()
                            : markersWid(widget.coordinatesList, context),
                            if(tapPosition != null)
                            Positioned(
                              left: tapPosition!.dx-25.0.w,
                              top: tapPosition!.dy - 110.0.h,
                              child: GestureDetector(
                                key: buttonKey,
                                onTap: (){
                                  hideBubble();
                                  _showBubble(context, buttonKey);
                                  },
                                child: Container(
                                  height: 34.0.h, width: 34.0.h,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: redCol,
                                    border: Border.all(
                                      color: white,
                                      width: 2.5.sp
                                    )
                                  ),
                                )
                              ),
                            )
                          ],
                        ),
                      ) 
                    ),
                    SizedBox(
                      height: 120.h,
                    ),
                    SizedBox(
                      width: 358.w,
                      height: 71.h,
                      child: CustomButton(
                        text: '画像をタップしてピン留めをしましょう',
                        bgColor: white,
                        buttonRadius:36.0.r ,
                        style: w7f14(
                          redCol
                        ),
                        borderColor: redCol,
                        prefixIcon: const SizedBox(),
                        suffixIcon: const SizedBox(),
                        elevation: 0.0,
                        ontap: ()  {
                        }
                      ),
                    )
                  ],
                ),
              );
            }
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
          left: items.x-25.0.w,
          top: items.y- 110.0.h,
          child: InkWell(
            key: buttonKey,
            onTap: () {
              hideBubble();
              _showBubble(context, buttonKey, index);
              debugPrint(i.toString());
            },
            child: Container(
              height: 34.0.h, width: 34.0.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: redCol,
                border: Border.all(
                  color: white,
                  width: 2.5.sp
                )
              ),
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
  //Show Bubble
  _showBubble(BuildContext context, GlobalKey buttonKey, [int? idx]) {
    final RenderBox buttonBox = buttonKey.currentContext!.findRenderObject() as RenderBox;
    final buttonSize = buttonBox.size;
    final buttonPosition = buttonBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          top: buttonPosition.dy < 170 ? buttonPosition.dy - buttonSize.height + 60.0 :
               buttonPosition.dy - buttonSize.height - 20.0, // Adjust the offset as needed
          left: buttonPosition.dx < 205 ? buttonPosition.dx - (buttonSize.width / 2) + 40.0.w :
                buttonPosition.dx - (buttonSize.width / 2) - 130.0.w,
          // Adjust the offset as needed
          child: Container(
            color: grey,
            padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 15.0.h),
            child: Center(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      //To remove overlay & reset bubble tap
                      hideBubble();
                      //Stop adding another point
                      CoordinateImageModalBottomSheet.coordinateModalBottomSheet(
                        context,widget.imageList,
                        tapPosition!.dy,
                        tapPosition!.dx,
                        widget.coordinatesList,
                        widget.from == 'favourite' ? 'favourite' : 
                        widget.from == 'collection' ? 'collection'
                        : 'search'
                      );
                    },
                    child: Container(
                      height: 40.h,
                      width: idx == null ? 140.0.w : 100.w,
                      padding: const EdgeInsets.all(10),
                      color: white,
                      child: Text(
                        '+ ADD',
                        style: w7f12N(black)
                      ),
                    ),
                  ),
                  //Remove Dot
                  idx == null ? const SizedBox() :
                  Container(
                    height: 40.h,
                    padding: const EdgeInsets.all(10),
                    color: red,
                    child: GestureDetector(
                      onTap: (){
                        hideBubble();
                        setState(() {
                          widget.coordinatesList.removeAt(idx);
                        });
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.delete, color: white,),
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    overlayButtonKey = buttonKey; // Remember the button key of the current overlay
  }
}