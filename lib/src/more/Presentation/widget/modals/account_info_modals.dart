// THE BOTTOM SHEET FOR ACCOUNT INFORMATION

import 'dart:developer';

import 'package:connect_me/app.dart';

SliverWoltModalSheetPage accountInformationModal(
    BuildContext modalSheetContext, TextTheme textTheme) {
  return WoltModalSheetPage(
    hasSabGradient: true,
    backgroundColor: modalSheetContext.theme.scaffoldBackgroundColor,
    // topBarTitle: Text('Account Information', style: textTheme.titleSmall),
    topBar: Container(
      color: modalSheetContext.theme.cardColor,
      alignment: Alignment.center,
      child: Text(TextConstant.accountInformation, style: textTheme.titleSmall),
    ),
    isTopBarLayerAlwaysVisible: true,
    trailingNavBarWidget: IconButton(
      padding: AppEdgeInsets.eA16,
      icon: const Icon(Icons.close),
      onPressed: Navigator.of(modalSheetContext).pop,
    ).padOnly(right: 10),

    // body
    child: const AccountInfoModalBody().padAll(15),
  );
}

class AccountInfoModalBody extends StatefulWidget {
  const AccountInfoModalBody({
    super.key,
  });

  @override
  State<AccountInfoModalBody> createState() => _AccountInfoModalBodyState();
}

class _AccountInfoModalBodyState extends State<AccountInfoModalBody> {
  final ValueNotifier<String> imgUrlNotifier = ValueNotifier('');
  final TextEditingControllerClass controller = TextEditingControllerClass();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
        listenable: Listenable.merge(
          [
            imgUrlNotifier,
          ],
        ),
        builder: (context, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AddProfilePictureWidget(
                onTapAddPhoto: () {
                  pickImageFunction(pickCamera: false).then((value) {
                    if (value != null) {
                      imgUrlNotifier.value = value.path;
                    }
                  });
                },
                onTapCamera: () {
                  pickImageFunction(pickCamera: true).then((value) {
                    if (value != null) {
                      imgUrlNotifier.value = value.path;
                    }
                  });
                },
                onDeleteImage: () {
                  imgUrlNotifier.value = '';
                },
                imgUrl: imgUrlNotifier.value,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: AuthTextFieldWidget(
                      controller: controller.firstNameController,
                      labelMaterial: TextConstant.firstName,
                      hintText: 'Ex: Endo',
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: AuthTextFieldWidget(
                      controller: controller.lastNameController,
                      labelMaterial: TextConstant.lastName,
                      hintText: 'Ex: Trent',
                    ),
                  ),
                ],
              ),
              AuthTextFieldWidget(
                controller: TextEditingController(text: 'captured@gmail.com'),
                labelMaterial: TextConstant.email,
                readOnly: true,
              ),

              //USE COUNTRY CODE WIDGET HERE

              AuthTextFieldWidget(
                controller: controller.phoneNoController,
                labelMaterial: TextConstant.phoneNumber,
                keyboardType: TextInputType.phone,
                prefixIcon: CountryCodeCustomWidget(
                  onChanged: (value) {},
                ),
              ),
              AuthTextFieldWidget(
                controller: controller.websiteController,
                labelMaterial: 'website',
                hintText: 'https://connectme.com',
              ),
              AuthTextFieldWidget(
                controller: controller.bioController,
                inputFormatters: const [],
                labelMaterial: TextConstant.bio,
                hintText: TextConstant.bioHint,
                maxLength: 70,
                maxLines: 4,
              ),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {
                    inspect(
                      AuthUserModel(
                        imgUrl: imgUrlNotifier.value,
                        fname: controller.firstNameController.text,
                        lname: controller.lastNameController.text,
                        phone: controller.phoneNoController.text,
                        website: controller.websiteController.text,
                        bio: controller.bioController.text,
                      ).toJson(),
                    );
                  },
                  child: const Text(TextConstant.save),
                ),
              ),
            ].columnInPadding(15),
          );
        });
  }
}
