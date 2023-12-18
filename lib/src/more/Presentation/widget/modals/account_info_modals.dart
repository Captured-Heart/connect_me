// THE BOTTOM SHEET FOR ACCOUNT INFORMATION
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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AddProfilePictureWidget(),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: AuthTextFieldWidget(
                controller: TextEditingController(),
                labelMaterial: 'first name',
                hintText: 'Ex: Endo',
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: AuthTextFieldWidget(
                controller: TextEditingController(),
                labelMaterial: 'last name',
                hintText: 'Ex: Trent',
              ),
            ),
          ],
        ),
        AuthTextFieldWidget(
          controller: TextEditingController(text: 'captured@gmail.com'),
          labelMaterial: 'email',
          readOnly: true,
        ),

        //USE COUNTRY CODE WIDGET HERE

        AuthTextFieldWidget(
          controller: TextEditingController(),
          labelMaterial: 'Phone',
          prefixIcon: CountryCodeCustomWidget(
            onChanged: (value) {},
          ),
          // prefixIcon: Align(
          //   alignment: Alignment.centerLeft,
          //     child: Text(
          //   '+234',
          //   textAlign: TextAlign.end,
          // )),
        ),
        AuthTextFieldWidget(
          controller: TextEditingController(),
          labelMaterial: 'website',
          hintText: 'https://connectme.com',
        ),
        AuthTextFieldWidget(
          controller: TextEditingController(),
          labelMaterial: 'bio',
          hintText: '''
Ex: I am an experienced tailor and social worker.

NB: This is diplayed in your Qr_Code card and is visible to all''',
          maxLength: 200,
          maxLines: 4,
        ),
        Align(
          alignment: Alignment.topRight,
          child: ElevatedButton(
            onPressed: () {},
            child: const Text(TextConstant.save),
          ),
        ),
      ].columnInPadding(15),
    ).padAll(15),
  );
}
