// EDUCATION MODEL

import '../../../../../app.dart';

SliverWoltModalSheetPage educationListTile(
  BuildContext modalSheetContext, {
  required ValueNotifier<int> pageIndexNotifier,
}) {
  return WoltModalSheetPage(
    hasSabGradient: true,
    backgroundColor: modalSheetContext.theme.scaffoldBackgroundColor,
    // topBarTitle: Text('Account Information', style: textTheme.titleSmall),
    topBar: Container(
      color: modalSheetContext.theme.cardColor,
      alignment: Alignment.center,
      child: Text(TextConstant.education, style: modalSheetContext.textTheme.titleSmall),
    ),
    isTopBarLayerAlwaysVisible: true,
    trailingNavBarWidget: IconButton(
      padding: AppEdgeInsets.eA16,
      icon: const Icon(Icons.close),
      onPressed: Navigator.of(modalSheetContext).pop,
    ).padOnly(right: 10),

    // body
    child: Consumer(builder: (context, ref, _) {
      final educationListAsync = ref.watch(fetchEducationListProvider(''));
      var educationList = educationListAsync.valueOrNull;
      return FullScreenLoader(
        isLoading: educationListAsync.isLoading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextButton.icon(
              onPressed: () {
                pageIndexNotifier.value = pageIndexNotifier.value + 2;
              },
              icon: const Icon(addIcon),
              label: const Text(TextConstant.addNew),
            ),
            ...List.generate(
              educationList?.length ?? 1,
              (index) => GestureDetector(
                onTap: () {
                  ref.read(educationIndexNotifier.notifier).update((state) => index);
                  pageIndexNotifier.value = pageIndexNotifier.value + 1;
                },
                child: Card(
                  color: modalSheetContext.colorScheme.surface,
                  child: ListTile(
                    dense: true,
                    leading: CircleAvatar(
                      backgroundColor: modalSheetContext.colorScheme.primaryContainer,
                      radius: 15,
                      child: Text(
                        '${index + 1}',
                        style: modalSheetContext.textTheme.labelLarge,
                      ),
                    ),
                    title: Text(educationList?[index].school?.toTitleCase() ?? ''),
                    subtitle: Text(educationList?[index].degree?.toTitleCase() ?? ''),
                    trailing: Container(
                      padding: AppEdgeInsets.eA4,
                      decoration: BoxDecoration(
                        border: Border.all(color: modalSheetContext.colorScheme.onSurface),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        deleteIcon,
                        color: modalSheetContext.colorScheme.error,
                        size: 17,
                      ).onTapWidget(
                        onTap: () {
                          ref
                              .read(addEducationInfoProvider.notifier)
                              .deleteEducationMethod(docId: educationList?[index].docId ?? '')
                              .whenComplete(
                            () {
                              ref.invalidate(
                                fetchEducationListProvider(''),
                              );
                            },
                          );
                          Navigator.of(modalSheetContext).pop;
                        },
                        tooltip: TextConstant.delete,
                      ),
                    ),
                  ).padOnly(bottom: 1, top: 1),
                ),
              ),
            ),
          ].columnInPadding(5),
        ).padSymmetric(horizontal: 7, vertical: 1),
      );
    }),
  );
}

SliverWoltModalSheetPage educationModal(
  BuildContext modalSheetContext,
  TextTheme textTheme, {
  VoidCallback? onPop,
  bool isEditMode = false,
  // List<EducationModel>? educationModel,
  required ValueNotifier<int> pageIndexNotifier,
}) {
  return WoltModalSheetPage(
    hasSabGradient: true,
    backgroundColor: modalSheetContext.theme.scaffoldBackgroundColor,
    // topBarTitle: Text('Account Information', style: textTheme.titleSmall),
    leadingNavBarWidget: onPop == null
        ? const SizedBox.shrink()
        : IconButton(
            padding: AppEdgeInsets.eA16,
            icon: const Icon(Icons.arrow_back),
            onPressed: onPop,
          ).padOnly(left: 10),
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
    child: Consumer(builder: (context, ref, _) {
      final educationIndex = ref.watch(educationIndexNotifier);
      final educationList = ref.watch(fetchEducationListProvider('')).valueOrNull;

      return EducationModalBody(
        educationModel: isEditMode == true || educationList?.isEmpty == true
            ? null
            : educationList?[educationIndex],
        pageIndexNotifier: pageIndexNotifier,
      ).padAll(15);
    }),
  );
}
