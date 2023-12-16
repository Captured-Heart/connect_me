import 'package:connect_me/app.dart';

class AddProfilePictureWidget extends StatelessWidget {
  const AddProfilePictureWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: context.colorScheme.onSurface,
              width: 0.1,
            ),
          ),
          height: 80,
          width: 100,
          child: const Icon(
            accountCircleIcon,
            size: 30,
          ),
        ),
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AutoSizeText(TextConstant.profilePhotoRequired),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SocialButtons(
                    iconData: addIcon,
                    text: TextConstant.addAPhoto,
                    elevation: 0,
                    isDense: true,
                  ),
                  const GradientShortBTN(
                    isThinBorder: true,
                    height: 30,
                    iconSize: 16,
                    iconData: deleteOutlineIcon,
                    elevation: 0,
                    tooltip: TextConstant.delete,
                  )
                ].rowInPadding(5),
              )
            ].columnInPadding(5))
      ].rowInPadding(10),
    );
  }
}
