import 'package:connect_me/app.dart';

SliverWoltModalSheetPage viewContactsModal({
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
        TextConstant.theme,
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
    child: Consumer(builder: (context, ref, _) {
      final themeMode = ref.read(themeProvider);
      return Column(
              children: [
        //Light mode
        MoreCustomListTileWidget(
          title: 'Light Mode'.hardCodedString,
          icon: Icons.sunny,
          onTap: () {
            ref.read(themeProvider.notifier).setThemeMode(ThemeMode.light);
            pop(context);
          },
          trailingWidget: Radio(
            value: ThemeMode.light,
            groupValue: themeMode,
            onChanged: (value) {
              ref.read(themeProvider.notifier).setThemeMode(value as ThemeMode);
              pop(context);
            },
          ),
        ),

        // dark mode
        MoreCustomListTileWidget(
          title: 'Dark Mode'.hardCodedString,
          icon: Icons.dark_mode,
          onTap: () {
            ref.read(themeProvider.notifier).setThemeMode(ThemeMode.dark);
            pop(context);
          },
          trailingWidget: Radio(
            value: ThemeMode.dark,
            groupValue: themeMode,
            onChanged: (value) {
              ref.read(themeProvider.notifier).setThemeMode(ThemeMode.dark);
              pop(context);
            },
          ),
        ),

        // system mode
        MoreCustomListTileWidget(
          title: 'System Mode'.hardCodedString,
          icon: Icons.sunny_snowing,
          onTap: () {
            ref.read(themeProvider.notifier).setThemeMode(ThemeMode.system);
            pop(context);
          },
          trailingWidget: Radio(
            value: ThemeMode.system,
            groupValue: themeMode,
            onChanged: (value) {
              ref.read(themeProvider.notifier).setThemeMode(ThemeMode.system);
              pop(context);
            },
          ),
        ),
      ].expand((element) => [element, const Divider()]).toList())
          .padAll(15);
    }),
  );
}
