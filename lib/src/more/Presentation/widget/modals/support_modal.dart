// ignore_for_file: public_member_api_docs, sort_constructors_first
// EDUCATION MODEL

import '../../../../../app.dart';

SliverWoltModalSheetPage supportModal({
  required BuildContext modalSheetContext,
  required AppDataModel? appDataModel,
}) {
  return WoltModalSheetPage(
    hasSabGradient: true,
    backgroundColor: modalSheetContext.theme.scaffoldBackgroundColor,
    // topBarTitle: Text('Account Information', style: textTheme.titleSmall),
    topBar: Container(
      color: modalSheetContext.theme.cardColor,
      alignment: Alignment.center,
      child: Text(
        TextConstant.donate,
        style: modalSheetContext.textTheme.titleSmall,
      ),
    ),
    isTopBarLayerAlwaysVisible: true,
    trailingNavBarWidget: IconButton(
      padding: AppEdgeInsets.eA16,
      icon: const Icon(Icons.close),
      onPressed: Navigator.of(modalSheetContext).pop,
    ).padOnly(right: 10),

    // body
    child: SupportModalBody(
      appDataModel: appDataModel,
    ).padAll(15),
  );
}

class SupportModalBody extends StatefulWidget {
  const SupportModalBody({
    super.key,
    this.onCountryChanged,
    this.onStateChanged,
    this.onCityChanged,
    this.appDataModel,
  });
  final Function(String)? onCountryChanged;
  final Function(String?)? onStateChanged;
  final Function(String?)? onCityChanged;
  final AppDataModel? appDataModel;

  @override
  State<SupportModalBody> createState() => _SupportModalBodyState();
}

class _SupportModalBodyState extends State<SupportModalBody> {
  final ValueNotifier<bool> isCopiedNotifier = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: isCopiedNotifier,
        builder: (context, isCopied, _) {
          return Column(
            children: [
              // MoreCustomListTileWidget(title: title)
              MoreCustomListTileWidget(
                title: 'BTC (BEP20)',
                icon: FontAwesome.btc,
                subtitle: widget.appDataModel?.btcAddress
                    ?.replaceRange(6, 25, '****************')
                    .replaceRange(29, 33, '****'),
                onTap: () {
                  FlutterClipboard.controlC(
                    widget.appDataModel?.btcAddress ?? TextConstant.currentlyUnavailable,
                  ).then(
                    (value) => isCopiedNotifier.value = value,
                  );
                },
                trailingWidget: GestureDetector(
                  onTap: () {
                    FlutterClipboard.controlC(
                      widget.appDataModel?.btcAddress ?? TextConstant.currentlyUnavailable,
                    ).then(
                      (value) => isCopiedNotifier.value = value,
                    );
                  },
                  child: Icon(
                    isCopied == true ? checkCircleIcon : copyIcon,
                    color: isCopied == true ? AppThemeColorDark.successColor : null,
                  ),
                ),
              ),
              MoreCustomListTileWidget(
                title: 'Buy me a Coffee',
                icon: buymeacoffeeIcon,
                subtitle: widget.appDataModel?.buyMeCoffee,
                onTap: () {
                  UrlOptions.launchWeb(
                    widget.appDataModel?.buyMeCoffee ?? TextConstant.currentlyUnavailable,
                    launchModeEXT: true,
                  );
                },
              ),
            ],
          );
        });
  }
}
