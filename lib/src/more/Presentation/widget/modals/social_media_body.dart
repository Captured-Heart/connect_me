import '../../../../../app.dart';

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
  final List<SocialClass> textEditingControllerList = [];
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
  // final SocialClass controller = SocialClass(link: '', title: '');
  List<Map<String, dynamic>> fetchedResultList = [];

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
    fetchedResultList.add(widget.socialMediaModel ?? {});
    items.removeWhere((element) => widget.socialMediaModel?.keys.contains(element) ?? false);

    return Form(
      key: socialKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //start date

          widget.socialMediaModel != null
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: fetchedResultList[0].entries.length,
                  // widget.socialMediaModel?.length,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemBuilder: (context, index) {
                    var socialType = widget.socialMediaModel?.entries.map((e) => e).toList()[index];
                    // var fetchResultType = fetchedResult.entries.map((e) => e).toList()[index];
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
                              // log('this is the fetched result list: ${fetchedResultList[0][socialType?.key]}');
                              fetchedResultList[0][socialType!.key] = link;
                              // fetchedResultList[0][index][socialType?.value] = link;
                            },
                            inputFormatters: [
                              TextFieldFormattersHelper.lowerCaseTextFormatter(),
                            ],
                            validator: TextFieldFormattersHelper.websiteValidator(),
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
                          ).onTapWidget(
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
                            tooltip: TextConstant.delete,
                          ),
                        ),
                      ],
                    ).padOnly(bottom: 15);
                  },
                )
              : const SizedBox.shrink(),

//! the added new text field
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

                //delete
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
                  ).onTapWidget(
                    onTap: () {
                      setState(() {
                        index >= 0 ? textEditingControllerList.removeAt(index) : null;
                      });
                    },
                    tooltip: TextConstant.delete,
                  ),
                ),
              ],
            ),
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
                Map<String, String> resultTwo = {};

                for (var value in textEditingControllerList) {
                  result[value.title] = value.link;
                }

                for (var value in fetchedResultList[0].entries.toList()) {
                  resultTwo[value.key] = value.value;
                }

                Map<String, dynamic> combinedMap = {...result, ...resultTwo};

                log('this is the result: $result \n\n this is the result two: $combinedMap');
                if (socialKey.currentState!.validate()) {
                  ref
                      .read(addSocialMediaProvider.notifier)
                      .addSocialMediaMethod(map: combinedMap)
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
