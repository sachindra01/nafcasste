import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nafcassete/src/controller/collection_controller.dart';
import 'package:nafcassete/src/helpers/styles.dart';
import 'package:nafcassete/src/views/collection/collection_previewPage.dart';
import 'package:nafcassete/src/widgets/custom_appbar.dart';
import 'package:nafcassete/src/widgets/custom_textfield.dart';

class ProductDetailForm extends StatefulWidget {
  final dynamic imageList;
  const ProductDetailForm({super.key, this.imageList});

  @override
  State<ProductDetailForm> createState() => _ProductDetailFormState();
}

class _ProductDetailFormState extends State<ProductDetailForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  final CollectionController _collectionController = Get.put(CollectionController());
  TextEditingController partNumCtrl = TextEditingController();
  TextEditingController cordinatetitleCtrl = TextEditingController();
  TextEditingController exTextCtrl  = TextEditingController();
  final FocusNode _partNumNode = FocusNode();
  final FocusNode _cordinatetitleCtrlnode = FocusNode();
  final FocusNode _exTextCtrlNode = FocusNode();

  @override
  void dispose() {
    super.dispose();
    partNumCtrl.dispose();
    cordinatetitleCtrl.dispose();
    exTextCtrl.dispose();
    _partNumNode.dispose();
    _cordinatetitleCtrlnode.dispose();
    _exTextCtrlNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(
        '4/6',
        0.0,
        [
          InkWell(
            onTap: (){
              Get.to(() => CollectionPreviewPage(
                imagesList: _collectionController.collectionImageList,
              ));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('次へ',style: w7f20(black),),
            ),
          )
        ]
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          '品番',
                          style: w7f14(black)
                        )
                      ),
                      SizedBox(
                        height: 15.0.h,
                      ),
                      CustomTextField(
                        autoFocus: false,
                        autovalidateMode:
                            AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        context: context,
                        focusNode: _partNumNode,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: red,
                          ),
                        ),
                        controller: partNumCtrl,
                        textCapitalization: TextCapitalization.none,
                        borderColor: black,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        borderRadius: 5.0,
                        fillColor: white,
                        hintStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 15.0.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          'コーディネートタイトル',
                          style: w7f14(black),
                        ),
                      ),
                      SizedBox(height: 15.0.h),
                      CustomTextField(
                        autoFocus: false,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        textInputAction: TextInputAction.done,
                        context: context,
                        focusNode: _cordinatetitleCtrlnode,
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(
                            color: red,
                          ),
                        ),
                        controller: cordinatetitleCtrl,
                        textCapitalization: TextCapitalization.none,
                        borderColor: black,
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                        borderRadius: 5,
                        fillColor: white,
                        hintStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      SizedBox(height: 15.0.h),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          '説明文',
                          style: w7f14(black),
                        ),
                      ),
                      SizedBox(height: 10.0.h),
                      TextFormField(
                        focusNode: _exTextCtrlNode,
                        onEditingComplete: () {},
                        controller: exTextCtrl,
                        decoration: InputDecoration(
                          fillColor: white,
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color:black
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: redCol,
                            ),
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: black),
                            borderRadius:BorderRadius.all(
                              Radius.circular(5)
                            ),
                          ),
                        ),
                        maxLines: 15,
                      ),
                      SizedBox(
                        height: 20.0.h,
                      ),
                    ]
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
