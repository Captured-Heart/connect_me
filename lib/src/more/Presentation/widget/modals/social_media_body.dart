import 'package:connect_me/app.dart';

class SocialMediaBody extends ConsumerStatefulWidget {
  const SocialMediaBody({
    super.key,
    required this.socialMediaModel,
    required this.onSubmitSuccessful,
  });
  final MapDynamicString? socialMediaModel;
  final VoidCallback onSubmitSuccessful;

  @override
  ConsumerState<SocialMediaBody> createState() => _SocialMediaBodyState();
}

class _SocialMediaBodyState extends ConsumerState<SocialMediaBody> {
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

  final List<String> items2 = [
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
    ref.listen(fetchProfileProvider, (previous, next) {
      if (next.asData?.value.socialMediaHandles?.isNotEmpty == true &&
          next.value?.socialMediaHandles != null) {
        showScaffoldSnackBarMessage(
          TextConstant.successful,
          duration: 3,
        );
      }
    });

    items.removeWhere((element) => widget.socialMediaModel?.keys.contains(element) ?? false);
    // log(items.toString());

    return Form(
      key: socialKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //start date

          widget.socialMediaModel != null
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.socialMediaModel?.length,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    var socialType = widget.socialMediaModel?.entries.map((e) => e).toList()[index];
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 3,
                          child: AuthTextFieldWidget(
                            readOnly: true,
                            controller: TextEditingController(text: socialType?.key),
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 6,
                          child: AuthTextFieldWidget(
                            contentPadding: AppEdgeInsets.eA18,
                            controller: TextEditingController(text: socialType?.value),
                            maxLines: 1,
                            onChanged: (link) {
                              // controller.link = link;
                            },
                            validator: (p0) {
                              if (p0 == null || p0.isEmpty) {
                                return TextConstant.required;
                              }
                              if (p0.startsWith('http') == false) {
                                return TextConstant.linkMustStartWithHttps;
                              }

                              return null;
                            },
                            // validator: (value) {
                            //   if (value == null || value.isEmpty) {
                            //     return TextConstant.required;
                            //   } else {
                            //     return null;
                            //   }
                            // },
                            hintText: 'Link',
                          ),
                        ),

                        //! delete button
                        Container(
                          padding: AppEdgeInsets.eA4,
                          margin: const EdgeInsets.only(left: 15),
                          decoration: BoxDecoration(
                            border: Border.all(color: context.colorScheme.onSurface),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            deleteIcon,
                            color: context.colorScheme.error,
                            size: 17,
                          ).tooltipWidget(TextConstant.delete).onTapWidget(
                            onTap: () {
                              log('this is the social key tapped on ${socialType!.key}');
                              ref
                                  .read(addSocialMediaProvider.notifier)
                                  .deleteSocialMediaMethod(
                                    socialKey: socialType.key,
                                  )
                                  .whenComplete(
                                () {
                                  widget.onSubmitSuccessful();
                                  ref.invalidate(fetchProfileProvider);
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ).padOnly(bottom: 15);
                  },
                )
              : const SizedBox.shrink(),

          ///! this is the [add new text controller section]
          for (var controller in textEditingControllerList)
            items.isEmpty
                ? const SizedBox.shrink()
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
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
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        flex: 5,
                        child: AuthTextFieldWidget(
                          contentPadding: AppEdgeInsets.eA18,
                          controller: TextEditingController(text: controller.link),
                          maxLines: 1,
                          onChanged: (link) {
                            controller.link = link;
                          },
                          validator: (p0) {
                            if (p0 == null || p0.isEmpty) {
                              return TextConstant.required;
                            }
                            if (p0.startsWith('http') == false) {
                              return TextConstant.linkMustStartWithHttps;
                            }

                            return null;
                          },
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return TextConstant.required;
                          //   } else {
                          //     return null;
                          //   }
                          // },
                          hintText: 'Link',
                        ),
                      ),
                    ],
                  ),
          items.isEmpty
              ? const SizedBox.shrink()
              : TextButton.icon(
                  onPressed: () {
                    textEditingControllerList.add(
                      SocialClass(title: '', link: ''),
                    );

                    setState(() {});
                  },
                  icon: const Icon(addIcon),
                  label: const Text(TextConstant.addNew),
                ),
          // SAVE BUTTON
          Align(
            alignment: Alignment.topRight,
            child: ElevatedButton(
              onPressed: () {
                // if (widget.socialMediaModel?.isEmpty != true) {
                Map<String, String> result = {};
                for (var value in textEditingControllerList) {
                  result[value.title] = value.link;
                }
                if (socialKey.currentState!.validate()) {
                  ref
                      .read(addSocialMediaProvider.notifier)
                      .addSocialMediaMethod(map: result)
                      .whenComplete(
                    () {
                      widget.onSubmitSuccessful();
                      ref.invalidate(fetchProfileProvider);
                    },
                  );
                }
              },
              child: infoState.isLoading == true
                  ? SizedBox(
                      height: 20,
                      width: 30,
                      child: CircularProgressIndicator(
                        backgroundColor: context.colorScheme.surface,
                      ),
                    )
                  : const Text(TextConstant.save),
            ),
          ),
          // infoState.value == null || infoState.hasError
          //     ? const SizedBox.shrink()
          //     : Text(
          //         infoState.hasError
          //             ? infoState.error.toString()
          //             : infoState.valueOrNull.toString(),
          //         style: AppTextStyle.bodyMedium.copyWith(
          //             color: infoState.hasError ? Colors.red : AppThemeColorDark.successColor),
          //       ),
        ].columnInPadding(10),
      ),
    );
  }
}
