import '../../../../../app.dart';

class SocialMediaSignUpScreen extends ConsumerStatefulWidget {
  const SocialMediaSignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SocialMediaSignUpScreenState();
}

class _SocialMediaSignUpScreenState extends ConsumerState<SocialMediaSignUpScreen> {
  final List<SocialClass> textEditingControllerList = [SocialClass(title: '', link: '')];
  final GlobalKey<FormState> socialKey = GlobalKey<FormState>();

  final List<String> items = [
    SocialDropdownEnum.facebook.message,
    SocialDropdownEnum.linkedIn.message,
    SocialDropdownEnum.instagram.message,
    SocialDropdownEnum.youtube.message,
    SocialDropdownEnum.behance.message,
    SocialDropdownEnum.twitter.message,
    SocialDropdownEnum.tiktok.message,
    SocialDropdownEnum.github.message,
    SocialDropdownEnum.whatsapp.message,
    SocialDropdownEnum.snapchat.message,
    SocialDropdownEnum.twitch.message,
    SocialDropdownEnum.discord.message,
    SocialDropdownEnum.gmail.message,
  ];

  @override
  Widget build(BuildContext context) {
    final infoState = ref.watch(addSocialMediaProvider);
    ref.listen(addSocialMediaProvider, (previous, next) {
      if (next.valueOrNull == TextConstant.successful) {
        final refresh = ref.refresh(fetchProfileProvider);
        if (refresh.hasValue) {
          pushReplacement(
            context,
            const SignUpMainScreen(),
            ref: ref,
            routeName: ScreenName.signUpMainScreen,
          );
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          TextConstant.socialMediaHandles,
        ),
      ),
      body: FullScreenLoader(
        isLoading: infoState.isLoading,
        child: SafeArea(
          child: Form(
            key: socialKey,
            child: ListView(
              shrinkWrap: true,
              padding: AppEdgeInsets.eA20,
              children: [
                ...List.generate(
                  textEditingControllerList.length,
                  (index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: LinkAndSocialMediaRowTextField(
                          items: items,
                          controller: textEditingControllerList[index],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            index > 0 ? textEditingControllerList.removeAt(index) : null;
                          });
                          // textEditingControllerList.removeWhere((item) => item.link.isEmpty && index > 0);
                        },
                        icon: const Icon(Icons.remove_circle),
                      )
                    ],
                  ),
                ),
                //start date
                // for (var controller in textEditingControllerList)
                //   LinkAndSocialMediaRowTextField(items: items, controller: controller),

                //  IconButton(
                //       onPressed: () {
                //         textEditingControllerList.removeWhere((item) => item.link.isEmpty);
                //       },
                //       icon: Icon(Icons.remove_circle),
                //     )
                Center(
                  child: TextButton.icon(
                    onPressed: () {
                      textEditingControllerList.add(
                        SocialClass(title: '', link: ''),
                      );

                      setState(() {});
                    },
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: context.colorScheme.onSurface, width: 0.3),
                            borderRadius: AppBorderRadius.c10),
                        padding: AppEdgeInsets.eA16),
                    icon: const Icon(addIcon),
                    label: const Text(TextConstant.addNew),
                  ),
                ),
                // SAVE BUTTON
                ElevatedButton(
                  onPressed: () {
                    Map<String, String> result = {};
                    for (var value in textEditingControllerList) {
                      result[value.title] = value.link;
                    }
                    if (socialKey.currentState!.validate()) {
                      // inspect(result);
                      ref.read(addSocialMediaProvider.notifier).addSocialMediaMethod(map: result);
                    }
                  },
                  child: const Text(TextConstant.save),
                ).padSymmetric(vertical: 20),
              ].columnInPadding(15),
            ),
          ),
        ),
      ),
    );
  }
}

class LinkAndSocialMediaRowTextField extends StatelessWidget {
  const LinkAndSocialMediaRowTextField({
    super.key,
    required this.items,
    required this.controller,
  });

  final List<String> items;
  final SocialClass controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 3,
            child: SizedBox(
              child: MyCustomDropWidgetWithStrings(
                items: items,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return TextConstant.required;
                  } else {
                    return null;
                  }
                },
                onChanged: (title) {
                  controller.title = title;
                  items.remove(title);
                },
              ),
              // DropDownWithLabelWidget(),
            )),
        const SizedBox(
          width: 15,
        ),
        Expanded(
          flex: 5,
          child: AuthTextFieldWidget(
            contentPadding: AppEdgeInsets.eA18,
            controller: TextEditingController(text: controller.link),
            onChanged: (link) {
              controller.link = link;
            },
            inputFormatters: [
              TextFieldFormattersHelper.lowerCaseTextFormatter(),
            ],
            validator: TextFieldFormattersHelper.websiteValidator(),
            hintText: 'Link',
          ),
        ),
      ],
    );
  }
}
