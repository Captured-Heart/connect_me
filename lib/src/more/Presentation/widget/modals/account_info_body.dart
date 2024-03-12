import 'package:connect_me/app.dart';
import 'package:flutter/services.dart';

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
    // final authUserModel = ref.read(fetchProfileProvider).valueOrNull;

    // I AM DOWNLOADING THE USER PREVIOUS IMAGE AND PASS AS FILE IMAGE
    // if (authUserModel?.imgUrl?.isNotEmpty == true) {
    //   downloadAndSaveImage(authUserModel?.imgUrl ?? ImagesConstant.noImagePlaceholderHttp)
    //       .then((value) => imgUrlFirebaseNotifier.value = value);
    // }
    super.initState();
  }

//?  this is the method for download my network image to file image
  // Future<String> downloadAndSaveImage(String imageUrl) async {
  //   final response = await http.get(Uri.parse(imageUrl));

  //   final documentDirectory = await getApplicationDocumentsDirectory();
  //   final file = File('${documentDirectory.path}/your_image.jpg');

  //   await file.writeAsBytes(Uint8List.fromList(response.bodyBytes));

  //   return file.path;
  // }

  final ValueNotifier<String> imgUrlFirebaseNotifier = ValueNotifier<String>('');
  final ValueNotifier<bool> deletedImageNotifier = ValueNotifier<bool>(false);
  final _formKey = GlobalKey<FormState>();
  final _websiteKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final infoState = ref.watch(addAccountInfoProvider);
    ref.listen(addAccountInfoProvider, (previous, next) {
      if (next.value != null && next.error == null) {
        pop(context);
        showScaffoldSnackBarMessage(
          TextConstant.successful,
          duration: 4,
        );
      }
    });
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
            deletedImageNotifier,
          ],
        ),
        builder: (context, _) {
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AddProfilePictureWidget(
                  onTapAddPhoto: () {
                    pickImageFunction(pickCamera: false).then((value) {
                      if (value != null) {
                        cropImageFunction(pickedFile: value, context: context).then((value) {
                          if (value != null) {
                            imgUrlFirebaseNotifier.value = value.path;
                          }
                        });
                      }
                    });
                  },
                  onTapCamera: () {
                    pickImageFunction(pickCamera: false).then((value) {
                      if (value != null) {
                        cropImageFunction(pickedFile: value, context: context).then((value) {
                          if (value != null) {
                            imgUrlFirebaseNotifier.value = value.path;
                          }
                        });
                      }
                    });
                  },
                  onDeleteImage: () {
                    imgUrlFirebaseNotifier.value = '';
                    deletedImageNotifier.value = true;
                  },
                  deletedImage: deletedImageNotifier.value,
                  imgUrl: widget.authUserModel?.imgUrl,
                  fileImage: imgUrlFirebaseNotifier.value,
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
                  },
                ),

                //website
                AuthTextFieldWidget(
                  // controller: controller.websiteController,
                  labelMaterial: 'website',
                  hintText: 'https://connectme.com',
                  initialValue: webNotifier.value,
                  onChanged: (value) {
                    setState(() {
                      webNotifier.value = value;
                    });
                  },
                  // validator: (p0) {
                  //   if (p0!.startsWith('https') == false) {
                  //     return TextConstant.linkMustStartWithHttps;
                  //   }
                  //   return null;
                  // },
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

                Align(
                  alignment: Alignment.topRight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (webNotifier.value.isNotEmpty &&
                            webNotifier.value.startsWith('http') == false) {
                          showScaffoldSnackBarMessageNoColor(TextConstant.linkMustStartWithHttps,
                              context: context, isError: true, appearsBottom: true);
                        } else {
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

                          if (imgUrlFirebaseNotifier.value.isNotEmpty ||
                              widget.authUserModel?.imgUrl?.isNotEmpty == true) {
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
                            log(''' imgFirebase: ${imgUrlFirebaseNotifier.value}
                        
                        imgUrl: ${widget.authUserModel?.imgUrl}''');
                            showScaffoldSnackBarMessage(
                              TextConstant.profilePhotoRequired,
                              isError: true,
                            );
                          }
                        }
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
