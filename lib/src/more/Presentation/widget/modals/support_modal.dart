// EDUCATION MODEL
import 'package:connect_me/app.dart';

SliverWoltModalSheetPage supportModal(BuildContext modalSheetContext, TextTheme textTheme) {
  return WoltModalSheetPage(
    hasSabGradient: true,
    backgroundColor: modalSheetContext.theme.scaffoldBackgroundColor,
    // topBarTitle: Text('Account Information', style: textTheme.titleSmall),
    topBar: Container(
      color: modalSheetContext.theme.cardColor,
      alignment: Alignment.center,
      child: Text(
        TextConstant.support,
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
    child: const SupportModalBody().padAll(15),
  );
}

class SupportModalBody extends StatelessWidget {
  const SupportModalBody({
    super.key,
    this.onCountryChanged,
    this.onCityChanged,
    this.onStateChanged,
  });
  final Function(String)? onCountryChanged;
  final Function(String?)? onStateChanged;
  final Function(String?)? onCityChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // MoreCustomListTileWidget(title: title)
        MoreCustomListTileWidget(
          title: 'BTC',
          icon: FontAwesome.btc,
          subtitle: 'ssfvsvfsawvaefgeafgfgre',
          trailingWidget: GestureDetector(
            onTap: () {},
            child: const Icon(copyIcon),
          ),
        ),
        const MoreCustomListTileWidget(
          title: 'Buy me a Coffee',
          icon: buymeacoffeeIcon,
          subtitle: 'https://www.buymeacoffee.com/CapturedHeart',
        ),
      ],
    );
  }
}
