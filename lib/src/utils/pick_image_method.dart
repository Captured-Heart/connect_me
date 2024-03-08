import 'package:connect_me/app.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImageFunction({
  bool? pickCamera,
  bool? cameraRear,
}) async {
  final picker = ImagePicker();

  final selected = await picker.pickImage(
    source: pickCamera == true ? ImageSource.camera : ImageSource.gallery,
    preferredCameraDevice: cameraRear == true ? CameraDevice.rear : CameraDevice.front,
    imageQuality: 95,
    maxHeight: 400,
  );

  return selected;
}

Future<CroppedFile?> cropImageFunction({
  required XFile pickedFile,
  required BuildContext context,
}) async {
  final croppedFile = await ImageCropper().cropImage(
    sourcePath: pickedFile.path,
    compressFormat: ImageCompressFormat.jpg,
    compressQuality: 100,
    uiSettings: [
      AndroidUiSettings(
        toolbarTitle: 'Edit Image'.hardCodedString,
        toolbarColor: context.colorScheme.primary,
        toolbarWidgetColor: Colors.white,
        initAspectRatio: CropAspectRatioPreset.original,
        lockAspectRatio: false,
      ),
      IOSUiSettings(
        title: 'Edit Image'.hardCodedString,
        showCancelConfirmationDialog: true,
      ),
    ],
  );
  return croppedFile;
}

Future<XFile?> pickFromGalleryFunctionNew({
  bool? pickCamera,
  bool? cameraRear,
  required bool isImage,
}) async {
  final picker = ImagePicker();

  if (isImage == true) {
    final selectedImage = await picker.pickImage(
      source: pickCamera == true ? ImageSource.camera : ImageSource.gallery,
      preferredCameraDevice: cameraRear == true ? CameraDevice.rear : CameraDevice.front,
      imageQuality: 95,
      maxHeight: 400,
    );
    return selectedImage;
  } else {
    final selectedVideo = await picker.pickVideo(
        source: pickCamera == true ? ImageSource.camera : ImageSource.gallery,
        preferredCameraDevice: cameraRear == true ? CameraDevice.rear : CameraDevice.front,
        maxDuration: const Duration(seconds: 100));
    return selectedVideo;
  }
}
