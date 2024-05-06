import 'dart:io';

import '../../../../app.dart';


class AddProfilePictureWidget extends StatelessWidget {
  const AddProfilePictureWidget({
    super.key,
    this.onTapAddPhoto,
    this.imgUrl,
    this.onTapCamera,
    this.onDeleteImage,
    this.deletedImage = false,
    this.fileImage,
  });

  final VoidCallback? onTapAddPhoto, onTapCamera, onDeleteImage;
  final String? imgUrl, fileImage;
  final bool deletedImage;

  Widget imageChildWidet(BuildContext context) {
    return deletedImage == false && (imgUrl?.isNotEmpty == true || imgUrl != null)
        ? ClipRRect(
            borderRadius: AppBorderRadius.c12,
            child: CachedNetworkImage(
              imageUrl: imgUrl!,
              fit: BoxFit.fill,
            ),
          )
        : CustomPaint(
            painter: DottedBorderPainter(context),
            child: const Icon(
              accountCircleIcon,
              size: 30,
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    // log(imgUrl.toString());
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: imgUrl?.isEmpty == false
                ? null
                : Border.all(
                    color: context.colorScheme.onSurface,
                    width: 0.1,
                  ),
          ),
          height: 80,
          width: 100,
          child: fileImage?.isNotEmpty == true
              ? ClipRRect(
                  borderRadius: AppBorderRadius.c12,
                  child: Image.file(
                    File(fileImage!),
                    fit: BoxFit.fill,
                  ),
                )
              : imageChildWidet(context),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AutoSizeText(TextConstant.profilePhotoRequired),
            SizedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  deletedImage == false
                      ? const SizedBox.shrink()
                      : Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIconButton(
                              iconData: imageIcon,
                              elevation: 0,
                              isDense: false,
                              onTap: onTapAddPhoto,
                            ),
                            CustomIconButton(
                              iconData: cameraIcon,
                              elevation: 0,
                              isDense: false,
                              onTap: onTapCamera,
                            ),
                          ],
                        ),
                  deletedImage != true
                      ? GradientShortBTN(
                          isThinBorder: true,
                          height: 30,
                          iconSize: 16,
                          iconData: deleteOutlineIcon,
                          elevation: 0,
                          tooltip: TextConstant.delete,
                          onTap: onDeleteImage,
                        )
                      : const SizedBox.shrink(),
                ].rowInPadding(5),
              ),
            )
          ].columnInPadding(7),
        )
      ].rowInPadding(10),
    );
  }
}

class DottedBorderPainter extends CustomPainter {
  final BuildContext context;

  DottedBorderPainter(this.context);
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = context.colorScheme.onSurface
      //  Colors.black
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    // Define the spacing between the dots
    const double dashWidth = 5.0;
    const double dashSpace = 5.0;

    // Calculate the number of dots in each dimension
    final double dotsInWidth = size.width / (dashWidth + dashSpace);
    final double dotsInHeight = size.height / (dashWidth + dashSpace);

    // Draw horizontal dashed line at the top
    for (int i = 0; i < dotsInWidth; i++) {
      final double xPos = i * (dashWidth + dashSpace);
      canvas.drawLine(Offset(xPos, 0), Offset(xPos + dashWidth, 0), paint);
    }

    // Draw horizontal dashed line at the bottom
    for (int i = 0; i < dotsInWidth; i++) {
      final double xPos = i * (dashWidth + dashSpace);
      canvas.drawLine(Offset(xPos, size.height), Offset(xPos + dashWidth, size.height), paint);
    }

    // Draw vertical dashed line at the left
    for (int i = 0; i < dotsInHeight; i++) {
      final double yPos = i * (dashWidth + dashSpace);
      canvas.drawLine(Offset(0, yPos), Offset(0, yPos + dashWidth), paint);
    }

    // Draw vertical dashed line at the right
    for (int i = 0; i < dotsInHeight; i++) {
      final double yPos = i * (dashWidth + dashSpace);
      canvas.drawLine(Offset(size.width, yPos), Offset(size.width, yPos + dashWidth), paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
