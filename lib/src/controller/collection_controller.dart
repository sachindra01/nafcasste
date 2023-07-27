import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nafcassete/src/helpers/repository.dart';
import 'package:nafcassete/src/helpers/styles.dart';
import 'package:nafcassete/src/model/collection_model.dart';
import 'package:nafcassete/src/model/favourite_model.dart';
import 'package:nafcassete/src/widgets/show_message.dart';

class CollectionController extends GetxController{

    List collectionImageList = [];
    List previewimageList = [];
    List categoryimageList = [];
    List<File> categoryselectedImages = []; 
    dynamic coordinateX,coordinateY;
    bool selectedCoordinate =false;
    List categoryselectedImage=[];
    List<Favouritemodel> favoritecollectionData = [];
    List<Collectionmodel> collectionData = [];
    var collectionLoading = false.obs;

    getfavCollectionData() async {
      try {
        collectionLoading(true);
        var response = await ApiRepo.apiGet('collection.json', '');
        if(response!= null){
          final result = List<Map<String, dynamic>>.from(response);
          final data = result.map((e) => Favouritemodel.fromJson(e)).toList();
          favoritecollectionData = data;
        }
      } on Exception catch (e) {
        showMessage("An Error Occured!", e.toString());
      } finally {
        collectionLoading(false);
      }
    }

    getCollectionData() async {
      try {
        collectionLoading(true);
        var response = await ApiRepo.apiGet('mycollection.json', '');
        if(response!= null){
          final result = List<Map<String, dynamic>>.from(response);
          final data = result.map((e) => Collectionmodel.fromJson(e)).toList();
          collectionData = data;
        }
      } on Exception catch (e) {
        showMessage("An Error Occured!", e.toString());
      } finally {
        collectionLoading(false);
      }
    }
    

  //image picker from gallery
  Future getImages(context, cropImages) async {
    List<File> selectedImages = []; 
    final picker = ImagePicker();
    final pickedFile = await picker.pickMultiImage(maxWidth: 1024, maxHeight: 1024, requestFullMetadata: true, imageQuality: 85);
    List<XFile> xfilePick = pickedFile;
    if (xfilePick.isNotEmpty) {
      for (var i = 0; i < xfilePick.length; i++) {
        if(cropImages) {
          var img = await cropImagesWidget(File(xfilePick[i].path));
          if(img != null){
            selectedImages.add(img);
          }
        } else {
          selectedImages.add(File(xfilePick[i].path));
        }
        previewimageList.add(File(xfilePick[i].path));
      }
      
      return selectedImages;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nothing is selected'))
      );
    }
  }

  //image picker from camera
  Future getImagesCamera(context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera, maxWidth: 1024, maxHeight: 1024, requestFullMetadata: true, imageQuality: 85);
    if (pickedFile!= null) {

      return pickedFile;
    } else {
    }
  }

  cropImagesWidget(image) async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: image.path,
      // aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1), // 1:1 aspect ratio
      aspectRatioPresets: [
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.square, 
        CropAspectRatioPreset.ratio16x9,
      ],
      uiSettings:[
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: redCol,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
        ),
        IOSUiSettings(
          title: 'Crop Image',
        ),
      ],
      maxWidth: 1024,
      maxHeight: 1024,
      cropStyle: CropStyle.rectangle, // Change to circle for circular crop
      compressQuality: 100, // Image quality from 0 to 100
    );
    if(croppedImage != null){
      return File(croppedImage.path);
    }
  }

}