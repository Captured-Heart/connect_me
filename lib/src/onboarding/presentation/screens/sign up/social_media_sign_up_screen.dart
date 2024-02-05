import 'package:connect_me/app.dart';

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
                //start date
                for (var controller in textEditingControllerList)
                  Row(
                    mainAxisSize: MainAxisSize.min,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return TextConstant.required;
                            } else {
                              return null;
                            }
                          },
                          hintText: 'Link',
                        ),
                      ),
                    ],
                  ),
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
                      inspect(result);
                      ref
                          .read(addSocialMediaProvider.notifier)
                          .addSocialMediaMethod(map: result)
                          .whenComplete(
                            () => ref.invalidate(fetchProfileProvider),
                          );
                    }
                  },
                  child: const Text(TextConstant.save),
                ),
              ].columnInPadding(15),
            ),
          ),
        ),
      ),
    );
  }
}
