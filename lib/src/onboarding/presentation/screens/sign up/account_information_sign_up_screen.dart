import 'dart:io';

import '../../../../../app.dart';

class AccountInformationSignUpScreen extends ConsumerStatefulWidget {
  const AccountInformationSignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AccountInformationSignUpScreenState();
}

class _AccountInformationSignUpScreenState extends ConsumerState<AccountInformationSignUpScreen> {
  final GlobalKey<FormState> accountKey = GlobalKey<FormState>();

  final ValueNotifier<String> phonePrefixNotifier = ValueNotifier('+234');
  final ValueNotifier<String> fnameNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> lnameNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> emailNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> phoneNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> webNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> bioNotifier = ValueNotifier<String>('');
  final ValueNotifier<String> imgUrl = ValueNotifier<String>('');

  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final authUserData = ref.watch(fetchProfileProvider).valueOrNull;
    final infoState = ref.watch(addAccountInfoProvider);
    ref.listen(addAccountInfoProvider, (previous, next) {
      if (next.valueOrNull == TextConstant.successful) {
        final refresh = ref.refresh(fetchProfileProvider);
        if (refresh.value != null) {
          pushReplacement(
            context,
            const SignUpMainScreen(),
            ref: ref,
            routeName: ScreenName.completeYourProfileScreen,
          );
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text(
          TextConstant.accountInformation,
        ),
      ),
      body: ListenableBuilder(
          listenable: Listenable.merge(
            [
              phoneNotifier,
              fnameNotifier,
              lnameNotifier,
              emailNotifier,
              phoneNotifier,
              webNotifier,
              bioNotifier,
              imgUrl,
            ],
          ),
          builder: (context, snapshot) {
            return Form(
              key: accountKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(
                shrinkWrap: true,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isLoading = true;
                        });
                        if (imgUrl.value.isEmpty) {
                          pickImageFunction(pickCamera: false).then((value) {
                            setState(() {
                              isLoading = false;
                            });
                            if (value != null) {
                              cropImageFunction(pickedFile: value, context: context).then((value) {
                                setState(() {
                                  isLoading = false;
                                });
                                if (value != null) {
                                  imgUrl.value = value.path;
                                }
                              }).onError((error, stackTrace) {
                                setState(() {
                                  isLoading = false;
                                });
                                showScaffoldSnackBarMessage(error.toString(), isError: true);
                              });
                            }
                          });
                        }
                      },
                      child: SizedBox(
                        height: 160,
                        width: 150,
                        child: imgUrl.value.isNotEmpty
                            ? ClipRRect(
                                borderRadius: AppBorderRadius.c10,
                                child: Stack(
                                  // alignment: Alignment.str,
                                  fit: StackFit.expand,
                                  children: [
                                    Image.file(
                                      File(imgUrl.value),
                                      fit: BoxFit.fill,
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: GestureDetector(
                                        onTap: () {
                                          imgUrl.value = '';
                                        },
                                        child: Container(
                                          width: 200,
                                          height: 35,
                                          color: AppThemeColorDark.textError.withOpacity(0.7),
                                          child: Center(
                                            child: Text(
                                              TextConstant.delete,
                                              style: context.textTheme.bodyMedium?.copyWith(
                                                color: AppThemeColorDark.textDark,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : CustomPaint(
                                willChange: true,
                                painter: DottedBorderPainter(context),
                                child: isLoading == true
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : const Icon(
                                        addImageIcon,
                                        size: 50,
                                      ),
                              ),
                      ),
                    ),
                  ),
                  imgUrl.value.isNotEmpty
                      ? const SizedBox.shrink()
                      : const CustomListTileWidget(
                          title: "Tap to add a profile picture",
                          subtitle: '(Headshots are preferred)',
                        ),
                  imgUrl.value.isEmpty
                      ? const SizedBox.shrink()
                      :
                      // form
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return TextConstant.required;
                                      } else {
                                        return null;
                                      }
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return TextConstant.required;
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),

                            //
                            AuthTextFieldWidget(
                              controller: TextEditingController(text: authUserData?.email ?? ''),
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

                            ElevatedButton(
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

                                inspect(map);
//
                                if (accountKey.currentState!.validate()) {
                                  if (imgUrl.value.isNotEmpty) {
                                    ref.read(addAccountInfoProvider.notifier).addAccountInfo(
                                          map: map,
                                          imgUrl: imgUrl.value,
                                        );
                                  } else {
                                    showScaffoldSnackBarMessage(
                                      TextConstant.profilePhotoRequired,
                                      isError: true,
                                    );
                                  }
                                }

                                // );
                              },
                              child: infoState.isLoading
                                  ? SizedBox(
                                      height: 25,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: context.colorScheme.primary,
                                        ),
                                      ),
                                    )
                                  : const Text(TextConstant.submit),
                            ),
                          ].columnInPadding(20),
                        ),
                ].columnInPadding(12),
              ).padAll(20),
            );
          }),
    );
  }
}
