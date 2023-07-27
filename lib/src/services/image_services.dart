import "dart:developer";
import "dart:io";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:image_cropper/image_cropper.dart";
import "package:image_picker/image_picker.dart";
import "package:nafcassete/src/helpers/styles.dart";

class ImageServices{
  pickImage({required bool pickFromGalley}) async{
    try {
      final image = await ImagePicker().pickImage(
        source: pickFromGalley ? ImageSource.gallery : ImageSource.camera , maxWidth: 1024, maxHeight: 1024, requestFullMetadata: true, imageQuality: 85);
      if (image == null) {
        return null;
      } else{
        return File(image.path);
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to upload image: $e");
      return null;
    }
  }

  Future pickAndCropImage({required imageSource}) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource, requestFullMetadata: true, imageQuality: 85);
      if (image == null) return null;

      File selFile = File(image.path);
      int fileSizeInBytes = await selFile.length();
      log('File Size => $fileSizeInBytes');
      
      if(fileSizeInBytes <= 5242880){    // check if image is under 5 MB
        //Crop Image
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
        return File(croppedImage!.path);
      } else {
        // showMessage('Notice', 'Image size too large, cannot be used');
      }
    } on PlatformException catch (e) {
      debugPrint("Failed to upload image: $e");
    }
  }

  
}