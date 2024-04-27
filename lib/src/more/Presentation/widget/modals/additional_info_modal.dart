// ignore_for_file: public_member_api_docs, sort_constructors_first
// EDUCATION MODEL

import 'package:connect_me/app.dart';

SliverWoltModalSheetPage additionalInfoModal(
  BuildContext modalSheetContext,
  AuthUserModel? authUserModel,
) {
  return WoltModalSheetPage(
    hasSabGradient: true,
    backgroundColor: modalSheetContext.theme.scaffoldBackgroundColor,
    // topBarTitle: Text('Account Information', style: textTheme.titleSmall),
    topBar: Container(
      color: modalSheetContext.theme.cardColor,
      alignment: Alignment.center,
      child: Text(TextConstant.additionalDetails, style: modalSheetContext.textTheme.titleSmall),
    ),
    isTopBarLayerAlwaysVisible: true,
    trailingNavBarWidget: IconButton(
      padding: AppEdgeInsets.eA16,
      icon: const Icon(Icons.close),
      onPressed: Navigator.of(modalSheetContext).pop,
    ).padOnly(right: 10),

    // body
    child: AdditionalInfoModalBody(
      authUserModel: authUserModel ?? const AuthUserModel(),
    ).padAll(15),
  );
}
