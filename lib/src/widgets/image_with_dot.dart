import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nafcassete/src/helpers/styles.dart';

class ImageWithTapDot extends StatefulWidget {
  final File? pickedImage;
  final bool? isScrolled;

  const ImageWithTapDot({Key? key, required this.pickedImage, this.isScrolled}) : super(key: key);

  @override
  State<ImageWithTapDot> createState() => _ImageWithTapDotState();
}

class _ImageWithTapDotState extends State<ImageWithTapDot> {
  final GlobalKey imageKey = GlobalKey();
  bool isBubbleShown = false;
  bool isAddPostBubbleShown = false;
  Offset? tapPosition;

  OverlayEntry? _overlayEntry;
  GlobalKey? overlayButtonKey;
  GlobalKey buttonKey = GlobalKey();
  final scrollController = ScrollController();
  List productsInImage = [];

  void handleTapDown(TapUpDetails details) {
    //on tap down
    // final RenderBox? imageBox = imageKey.currentContext?.findRenderObject() as RenderBox?;
    // final imageSize = imageBox?.size;
    // final tapPosition = details.localPosition;
    // if (imageSize != null) {
    //   final tapX = tapPosition.dx / imageSize.width;
    //   final tapY = tapPosition.dy / imageSize.height;
    //   setState(() {
    //     this.tapPosition = Offset(tapX, tapY);
    //   });
    //   debugPrint("x:${tapPosition.dx}, y:${tapPosition.dy}");

      final RenderBox box = context.findRenderObject() as RenderBox;
      final Offset tapPosition = box.globalToLocal(details.globalPosition);
      setState(() {
        this.tapPosition = tapPosition;
      });
      debugPrint("x:${tapPosition.dx}, y:${tapPosition.dy}");
  }

  void hideBubble() {
    _overlayEntry?.remove();
    _overlayEntry = null; // Reset the overlay entry
    overlayButtonKey = null;
  }

  @override
  void initState() {
    // scrollController.addListener(() {
    //   hideBubble();
    // });
    super.initState();
  }

  @override
  void dispose() {
    hideBubble();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.isScrolled == true){
      hideBubble();
      isBubbleShown = false;
      isAddPostBubbleShown = false;
    }
    return Scaffold(
      body: GestureDetector(
        onTapUp: isBubbleShown == false
         ? handleTapDown 
         : (value){},
        child: Stack(
          children: [
            Container(
              key: imageKey,
              child: Image.file(
                widget.pickedImage!,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            ),
            if (tapPosition != null)
              Positioned(
                left: tapPosition!.dx,
                top: tapPosition!.dy,
                child: GestureDetector(
                  key: buttonKey,
                  onTap: isAddPostBubbleShown == false //Check if add post is already shown
                    ?(){
                      setState(() {
                        //Stop adding another point
                        isBubbleShown = true;
                        isAddPostBubbleShown = true;
                      });
                      Padding(
                        padding: EdgeInsets.only(bottom: 15.h, right: 100.w),
                        child: _showBubble(context, buttonKey),
                      );
                    }
                    : (){},
                  child: CircleAvatar(
                    backgroundColor: redCol.withOpacity(0.7),
                    child: Icon(Icons.circle, color: white, size: 20.0.sp,)
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  //Show Bubble
  _showBubble(BuildContext context, GlobalKey buttonKey) {
    final RenderBox buttonBox = buttonKey.currentContext!.findRenderObject() as RenderBox;
    final buttonSize = buttonBox.size;
    final buttonPosition = buttonBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Positioned(
          top: buttonPosition.dy - buttonSize.height - 20.0, // Adjust the offset as needed
          left: buttonPosition.dx - (buttonSize.width / 2) + 40.0, // Adjust the offset as needed
          child: Container(
            color: grey,
            padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 15.0.h),
            child: Center(
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          //To remove overlay & reset bubble tap
                          hideBubble();
                          setState(() {
                            tapPosition = null;
                            isBubbleShown = false;
                            isAddPostBubbleShown = false;
                          });
                        },
                        child: Container(
                          height: 40.h,
                          width: 100.w,
                          padding: const EdgeInsets.all(10),
                          color: white,
                          child: Text(
                            '+ ADD',
                            style: w7f12N(black)
                          ),
                        ),
                      ),
                    ],
                  ),
                  //Remove Dot
                  Container(
                    height: 40.h,
                    padding: const EdgeInsets.all(10),
                    color: red,
                    child: GestureDetector(
                      onTap: (){
                        hideBubble();
                        setState(() {
                          tapPosition = null;
                          isBubbleShown = false;
                          isAddPostBubbleShown = false;
                        });
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.delete, color: white,),
                          // Text("Remove Dot", style: w7f12N(white)),
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
