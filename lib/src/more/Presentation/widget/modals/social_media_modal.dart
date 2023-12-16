// EDUCATION MODEL
import 'package:connect_me/app.dart';

SliverWoltModalSheetPage socialMediaModal(BuildContext modalSheetContext, TextTheme textTheme) {
  return WoltModalSheetPage(
    hasSabGradient: true,
    backgroundColor: modalSheetContext.theme.scaffoldBackgroundColor,
    // topBarTitle: Text('Account Information', style: textTheme.titleSmall),
    topBar: Container(
      color: modalSheetContext.theme.cardColor,
      alignment: Alignment.center,
      child: Text(TextConstant.socialMediaHandles, style: textTheme.titleSmall),
    ),
    isTopBarLayerAlwaysVisible: true,
    trailingNavBarWidget: IconButton(
      padding: AppEdgeInsets.eA16,
      icon: const Icon(Icons.close),
      onPressed: Navigator.of(modalSheetContext).pop,
    ).padOnly(right: 10),

    // body
    child: const SocialMediaBody().padAll(15),
  );
}

//
class SocialMediaBody extends StatelessWidget {
  const SocialMediaBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title
        AuthTextFieldWidget(
          controller: TextEditingController(),
          hintText: 'Ex: Software developer',
          label: 'Title*',
        ),

        //employment type
        AuthTextFieldWidget(
          controller: TextEditingController(),
          label: 'Employment type*',
        ),

        // company name
        AuthTextFieldWidget(
          controller: TextEditingController(),
          hintText: 'Ex: Google',
          label: 'Company Name',
        ),

        //location
        AuthTextFieldWidget(
          controller: TextEditingController(),
          hintText: 'Ex: Kaduna, Nigeria',
          label: 'Location',
        ),

        //location type
        AuthTextFieldWidget(
          controller: TextEditingController(),
          label: 'Location type',
        ),

// check box of you currently working here
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox.adaptive(
              value: true,
              onChanged: (value) {},
            ),
            const Expanded(
                child: AutoSizeText(
              'i am currently working in this role',
              maxLines: 1,
              minFontSize: 9,
            ))
          ],
        ),

        //start date
        const AutoSizeText(
          'Start date',
          maxLines: 1,
          textScaleFactor: 0.9,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: AuthTextFieldWidget(
                controller: TextEditingController(),
                hintText: 'Month',
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: AuthTextFieldWidget(
                controller: TextEditingController(),
                hintText: 'Year',
              ),
            ),
          ],
        ),

        //TODO: IF THE USER IS CURRENTLY WORKING HERE, HIDE THE END DATE
        const AutoSizeText(
          'End date',
          maxLines: 1,
          textScaleFactor: 0.9,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: AuthTextFieldWidget(
                controller: TextEditingController(),
                hintText: 'Month',
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: AuthTextFieldWidget(
                controller: TextEditingController(),
                hintText: 'Year',
              ),
            ),
          ],
        ),
// SAVE BUTTON
        Align(
          alignment: Alignment.topRight,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text(TextConstant.save),
          ),
        ),
      ].columnInPadding(15),
    );
  }
}
