// THE BOTTOM SHEET FOR ACCOUNT INFORMATION

// ignore_for_file: depend_on_referenced_packages


import 'package:connect_me/app.dart';

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
