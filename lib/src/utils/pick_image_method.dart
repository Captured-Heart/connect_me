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

// Future<void> requestPhotoPermission() async {
//   PermissionStatus status = await Permission.photos.request();

//   if (status.isGranted) {
//     // Permission is granted, you can access photos
//     // Place your code to access photos here
//   } else {
//     // Permission denied
//     print("Permission denied");
//     // You may want to show a dialog or message to inform the user
//   }
// }

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
