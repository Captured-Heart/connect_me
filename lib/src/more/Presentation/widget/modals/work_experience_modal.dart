// EDUCATION MODEL

import '../../../../../app.dart';

SliverWoltModalSheetPage workExperienceListTile(
  BuildContext modalSheetContext, {
  required ValueNotifier<int> pageIndexNotifier,
}) {
  return WoltModalSheetPage(
    hasSabGradient: true,
    backgroundColor: modalSheetContext.theme.scaffoldBackgroundColor,

    topBar: Container(
      color: modalSheetContext.theme.cardColor,
      alignment: Alignment.center,
      child: Text(TextConstant.workExperience, style: modalSheetContext.textTheme.titleSmall),
    ),
    isTopBarLayerAlwaysVisible: true,
    trailingNavBarWidget: IconButton(
      padding: AppEdgeInsets.eA16,
      icon: const Icon(Icons.close),
      onPressed: Navigator.of(modalSheetContext).pop,
    ).padOnly(right: 10),

    // body
    child: Consumer(builder: (context, ref, _) {
      final workExperienceListAsync = ref.watch(fetchWorkListProvider(''));
      var workExperienceList = workExperienceListAsync.valueOrNull;
      return FullScreenLoader(
          isLoading: workExperienceListAsync.isLoading,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton.icon(
                onPressed: () {
                  pageIndexNotifier.value = pageIndexNotifier.value + 2;
                },
                icon: const Icon(addIcon),
                label: const Text(TextConstant.addNew),
              ),
              ...List.generate(
                workExperienceList?.length ?? 1,
                (index) => GestureDetector(
                  onTap: () {
                    ref.read(workExpIndexNotifier.notifier).update((state) => index);
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
                      title: Text(workExperienceList?[index].title?.toTitleCase() ?? ''),
                      subtitle: Text(workExperienceList?[index].companyName?.toTitleCase() ?? ''),
                      trailing: GestureDetector(
                        onTap: () {},
                        child: Container(
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
                                  .read(addWorkExperienceProvider.notifier)
                                  .deleteWorkExperienceMethod(
                                      docId: workExperienceList?[index].docId ?? '')
                                  .whenComplete(
                                () {
                                  ref.invalidate(fetchWorkListProvider(''));
                                },
                              );
                              Navigator.of(modalSheetContext).pop;
                            },
                            tooltip: TextConstant.delete,
                          ),
                        ),
                      ),
                    ).padSymmetric(vertical: 1),
                  ),
                ),
              ),
            ].columnInPadding(5),
          ).padSymmetric(horizontal: 12, vertical: 10));
    }),
  );
}

//0113343316
SliverWoltModalSheetPage workExperienceModal(
  BuildContext modalSheetContext,
  TextTheme textTheme, {
  VoidCallback? onPop,
  // List<WorkExperienceModel>? workExperienceList,
  required ValueNotifier<int> pageIndexNotifier,
  bool isEditMode = false,
}) {
  return WoltModalSheetPage(
    hasSabGradient: true,
    backgroundColor: modalSheetContext.theme.scaffoldBackgroundColor,
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
      child: Text(TextConstant.workExperience, style: textTheme.titleSmall),
    ),
    isTopBarLayerAlwaysVisible: true,
    trailingNavBarWidget: IconButton(
      padding: AppEdgeInsets.eA16,
      icon: const Icon(Icons.close),
      onPressed: Navigator.of(modalSheetContext).pop,
    ).padOnly(right: 10),

    // body
    child: Consumer(
      builder: (context, ref, _) {
        final workIndex = ref.watch(workExpIndexNotifier);
        final workExperienceList = ref.watch(fetchWorkListProvider('')).valueOrNull;

        return WorkExperienceBody(
          pageIndexNotifier: pageIndexNotifier,
          workExpModel: isEditMode == true || workExperienceList?.isEmpty == true
              ? null
              : workExperienceList?[workIndex],
        ).padAll(15);
      },
    ),
  );
}
