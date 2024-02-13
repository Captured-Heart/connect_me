// THE BOTTOM SHEET FOR ACCOUNT INFORMATION

// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'dart:typed_data';

import 'package:connect_me/app.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

SliverWoltModalSheetPage accountInformationModal(
  BuildContext modalSheetContext,
  TextTheme textTheme,
  AuthUserModel? authUserModel,
) {
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
    child: AccountInfoModalBody(
      authUserModel: authUserModel,
    ).padAll(15),
  );
}

class AccountInfoModalBody extends ConsumerStatefulWidget {
  const AccountInfoModalBody({
    super.key,
    this.authUserModel,
  });

  final AuthUserModel? authUserModel;

  @override
  ConsumerState<AccountInfoModalBody> createState() => _AccountInfoModalBodyState();
}

class _AccountInfoModalBodyState extends ConsumerState<AccountInfoModalBody> {
  late ValueNotifier<String> phonePrefixNotifier;
  late ValueNotifier<String> fnameNotifier;
  late ValueNotifier<String> lnameNotifier;
  late ValueNotifier<String> emailNotifier;
  late ValueNotifier<String> phoneNotifier;
  late ValueNotifier<String> webNotifier;
  late ValueNotifier<String> bioNotifier;

  @override
  void initState() {
    phonePrefixNotifier = ValueNotifier(widget.authUserModel?.phonePrefix ?? '');
    fnameNotifier = ValueNotifier<String>(widget.authUserModel?.fname ?? '');
    lnameNotifier = ValueNotifier<String>(widget.authUserModel?.lname ?? '');
    emailNotifier = ValueNotifier<String>(widget.authUserModel?.email ?? '');
    phoneNotifier = ValueNotifier<String>(widget.authUserModel?.phone ?? '');
    webNotifier = ValueNotifier<String>(widget.authUserModel?.website ?? '');
    bioNotifier = ValueNotifier<String>(widget.authUserModel?.bio ?? '');

    //
    final authUserModel = ref.read(fetchProfileProvider).valueOrNull;

    // I AM DOWNLOADING THE USER PREVIOUS IMAGE AND PASS AS FILE IMAGE
    if (authUserModel?.imgUrl?.isNotEmpty == true) {
      downloadAndSaveImage(authUserModel?.imgUrl ?? ImagesConstant.noImagePlaceholderHttp)
          .then((value) => imgUrlFirebaseNotifier.value = value);
    }
    super.initState();
  }

//?  this is the method for download my network image to file image
  Future<String> downloadAndSaveImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));

    final documentDirectory = await getApplicationDocumentsDirectory();
    final file = File('${documentDirectory.path}/your_image.jpg');

    await file.writeAsBytes(Uint8List.fromList(response.bodyBytes));

    return file.path;
  }

  final ValueNotifier<String> imgUrlFirebaseNotifier = ValueNotifier<String>('');
  @override
  Widget build(BuildContext context) {
    final infoState = ref.watch(addAccountInfoProvider);

    return ListenableBuilder(
        listenable: Listenable.merge(
          [
            phonePrefixNotifier,
            fnameNotifier,
            lnameNotifier,
            emailNotifier,
            phoneNotifier,
            webNotifier,
            bioNotifier,
            imgUrlFirebaseNotifier,
          ],
        ),
        builder: (context, _) {
          return Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // widget.authUserModel?.imgUrl?.isNotEmpty == true && imgUrlFirebaseNotifier.value.isEmpty
                //     ? const CircularProgressIndicator()
                //     :

                // imgUrlFirebaseNotifier.value.isEmpty
                //     ? AddProfilePictureWidget(
                //         onTapAddPhoto: () {
                //           pickImageFunction(pickCamera: false).then((value) {
                //             if (value != null) {
                //               imgUrlFirebaseNotifier.value = value.path;
                //             }
                //           });
                //         },
                //         onTapCamera: () {
                //           pickImageFunction(pickCamera: true).then((value) {
                //             if (value != null) {
                //               imgUrlFirebaseNotifier.value = value.path;
                //             }
                //           });
                //         },
                //       )
                //     :

                AddProfilePictureWidget(
                  onTapAddPhoto: () {
                    pickImageFunction(pickCamera: false).then((value) {
                      if (value != null) {
                        imgUrlFirebaseNotifier.value = value.path;
                      }
                    });
                  },
                  onTapCamera: () {
                    pickImageFunction(pickCamera: true).then((value) {
                      if (value != null) {
                        imgUrlFirebaseNotifier.value = value.path;
                      }
                    });
                  },
                  onDeleteImage: () {
                    imgUrlFirebaseNotifier.value = '';
                  },
                  isFromFirebase: imgUrlFirebaseNotifier.value.isNotEmpty,
                  imgUrl: imgUrlFirebaseNotifier.value,
                  imageIsLoading: widget.authUserModel?.imgUrl?.isNotEmpty == true &&
                      imgUrlFirebaseNotifier.value.isEmpty,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: AuthTextFieldWidget(
                        // controller: controller.firstNameController,
                        labelMaterial: TextConstant.firstName,
                        hintText: 'Ex: Endo',
                        initialValue: fnameNotifier.value,
                        onChanged: (value) {
                          fnameNotifier.value = value;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: AuthTextFieldWidget(
                        // controller: controller.lastNameController,
                        labelMaterial: TextConstant.lastName,
                        hintText: 'Ex: Trent',
                        initialValue: lnameNotifier.value,
                        onChanged: (value) {
                          lnameNotifier.value = value;
                        },
                      ),
                    ),
                  ],
                ),
                AuthTextFieldWidget(
                  controller: TextEditingController(text: widget.authUserModel?.email ?? ''),
                  labelMaterial: TextConstant.email,
                  readOnly: true,
                ),

                //USE COUNTRY CODE WIDGET HERE

                AuthTextFieldWidget(
                  // controller: controller.phoneNoController,
                  labelMaterial: TextConstant.phoneNumber,
                  keyboardType: TextInputType.phone,
                  prefixIcon: CountryCodeCustomWidget(
                    onChanged: (value) {
                      phonePrefixNotifier.value = value.dialCode!;
                    },
                    initialPrefix: phonePrefixNotifier.value,
                  ),
                  initialValue: phoneNotifier.value,
                  onChanged: (value) {
                    phoneNotifier.value = value;
                    log(phoneNotifier.value);
                  },
                ),
                AuthTextFieldWidget(
                  // controller: controller.websiteController,
                  labelMaterial: 'website',
                  hintText: 'https://connectme.com',
                  initialValue: webNotifier.value,
                  onChanged: (value) {
                    webNotifier.value = value;
                  },
                ),
                AuthTextFieldWidget(
                  // controller: controller.bioController,
                  inputFormatters: const [],
                  labelMaterial: TextConstant.bio,
                  hintText: TextConstant.bioHint,
                  maxLength: 150,
                  maxLines: 4,
                  initialValue: bioNotifier.value,
                  onChanged: (value) {
                    bioNotifier.value = value;
                  },
                ),

                infoState.value == null || infoState.hasError
                    ? const SizedBox.shrink()
                    : Text(
                        infoState.hasError
                            ? infoState.error.toString()
                            : infoState.valueOrNull.toString(),
                        style: AppTextStyle.bodyMedium.copyWith(
                            color:
                                infoState.hasError ? Colors.red : AppThemeColorDark.successColor),
                      ),

                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: () {
                      // inspect(
                      MapDynamicString map = CreateFormMap.createDataMap(
                        controllersText: [
                          // controller.firstNameController.text,
                          // controller.lastNameController.text,
                          // controller.phoneNoController.text,
                          // controller.websiteController.text,
                          // controller.bioController.text,
                          fnameNotifier.value,
                          lnameNotifier.value,
                          phonePrefixNotifier.value,
                          phoneNotifier.value,
                          webNotifier.value,
                          bioNotifier.value,
                        ],
                        customKeys: // initiate my custom keys
                            [
                          FirebaseDocsFieldEnums.fname.name,
                          FirebaseDocsFieldEnums.lname.name,
                          FirebaseDocsFieldEnums.phonePrefix.name,
                          FirebaseDocsFieldEnums.phone.name,
                          FirebaseDocsFieldEnums.website.name,
                          FirebaseDocsFieldEnums.bio.name,
                        ],
                      );
                      // );

                      if (imgUrlFirebaseNotifier.value.isNotEmpty) {
                        ref
                            .read(addAccountInfoProvider.notifier)
                            .addAccountInfo(
                              map: map,
                              imgUrl: imgUrlFirebaseNotifier.value,
                            )
                            .whenComplete(() {
                          ref.invalidate(fetchProfileProvider);
                        });
                      } else {
                        showScaffoldSnackBarMessage(
                          TextConstant.profilePhotoRequired,
                          isError: true,
                        );
                      }
                    },
                    child: infoState.isLoading == true
                        ? SizedBox(
                            height: 20,
                            width: 30,
                            child: CircularProgressIndicator(
                              backgroundColor: context.colorScheme.surface,
                            ))
                        : const Text(TextConstant.save),
                  ),
                ),
              ].columnInPadding(15),
            ),
          );
        });
  }
}
