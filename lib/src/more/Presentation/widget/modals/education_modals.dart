// EDUCATION MODEL
import 'package:connect_me/app.dart';



SliverWoltModalSheetPage educationModal(BuildContext modalSheetContext, TextTheme textTheme) {
  return WoltModalSheetPage(
    hasSabGradient: true,
    backgroundColor: modalSheetContext.theme.scaffoldBackgroundColor,
    // topBarTitle: Text('Account Information', style: textTheme.titleSmall),
    topBar: Container(
      color: modalSheetContext.theme.cardColor,
      alignment: Alignment.center,
      child: Text(TextConstant.education, style: textTheme.titleSmall),
    ),
    isTopBarLayerAlwaysVisible: true,
    trailingNavBarWidget: IconButton(
      padding: AppEdgeInsets.eA16,
      icon: const Icon(Icons.close),
      onPressed: Navigator.of(modalSheetContext).pop,
    ).padOnly(right: 10),

    // body
    child: const EducationModalBody().padAll(15),
  );
}

class EducationModalBody extends StatelessWidget {
  const EducationModalBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AuthTextFieldWidget(
          controller: TextEditingController(),
          hintText: 'Ex: Univeristy of Nigeria',
          label: 'School*',
        ),
        AuthTextFieldWidget(
          controller: TextEditingController(),
          hintText: 'Ex: Bachelor\'s, Phil of Doctor',
          label: 'Degree*',
        ),
        AuthTextFieldWidget(
          controller: TextEditingController(),
          hintText: 'School*',
          label: 'School*',
        ),
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
        const AutoSizeText(
          'End date (or Expected)',
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
        AuthTextFieldWidget(
          controller: TextEditingController(),
          label: 'Grade',
          hintText: 'Ex: First Class Honours',
        ),
        AuthTextFieldWidget(
          controller: TextEditingController(),
          label: 'Activities/Organizations',
          maxLines: 3,
          hintText: 'Ex: Football(sports), Religious socieites etc',
        ),
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
