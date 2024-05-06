import '../../../../../app.dart';

final _emailControllerProvider = StateProvider<String>((ref) {
  return '';
});
SliverWoltModalSheetPage deleteAccountModal({
  required BuildContext modalSheetContext,
  required AuthUserModel? authUserModel,
}) {
  // final TextEditingController _emailController = TextEditingController();

  return WoltModalSheetPage(
    hasSabGradient: true,
    backgroundColor: modalSheetContext.theme.scaffoldBackgroundColor,
    // topBarTitle: Text('Account Information', style: textTheme.titleSmall),
    topBar: Container(
      color: AppThemeColorDark.textError,
      alignment: Alignment.center,
      child: Text(
        TextConstant.deleteAccount,
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
      ref.listen(deleteAccountInfoProvider, (previous, next) {
        if (!next.hasError || next.value != null) {
          pop(context);
          pop(context);
        }
        if (next.hasError) {
          pop(context);
          pop(context);
        }
      });
      return Column(
        children: [
          const Text('Read Carefully: '),
          Column(
            children: [
              deleteAccountBulletList(
                context,
                title: 'Data Removal'.hardCodedString,
                subtitle:
                    'Deleting your account will permanently remove all your data associated with the "Connect_Me app", including your profile information, activity history, and any saved preferences or settings.'
                        .hardCodedString,
              ),
              deleteAccountBulletList(
                context,
                title: 'Permanent action'.hardCodedString,
                subtitle:
                    'Please note that deleted accounts cannot be recovered. If you ever wish to use "Connect_Me app" again, you will need to create a new account.'
                        .hardCodedString,
              ),
              const Divider(),
              Text(
                'If you still wish to proceed with deleting your account, please confirm your decision by entering your email below: '
                    .hardCodedString,
                style: context.textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
              AuthTextFieldWidget(
                labelWidget: const Text(TextConstant.email),
                hintText: TextConstant.pleaseEnterEmailAssociated,
                onChanged: (p0) {
                  ref.read(_emailControllerProvider.notifier).update((state) => p0);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return TextConstant.required;
                  } else if (authUserModel?.email?.toLowerCase() != value.toLowerCase()) {
                    return 'email does not match';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                width: context.sizeWidth(1),
                child: ElevatedButton(
                  onPressed: ref.watch(_emailControllerProvider).toLowerCase() !=
                          authUserModel?.email?.toLowerCase()
                      ? null
                      : () {
                          warningDialogs(
                            context: context,
                            dialogModel: DialogModel(
                              title:
                                  'Are you sure you want to delete your account?'.hardCodedString,
                              content: null,
                              onPostiveAction: () {
                                // Navigator.maybePop(context);

                                ref
                                    .read(deleteAccountInfoProvider.notifier)
                                    .deleteAccountPermanently(
                                        email: ref.watch(_emailControllerProvider),
                                        uuid: authUserModel?.docId ?? 'null');

                                // Navigator.maybePop(context);
                                pop(modalSheetContext);

                                // Navigator.maybePop(modalSheetContext);
                              },
                            ),
                          );
                          // pop(modalSheetContext);
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppThemeColorDark.textError,
                    disabledBackgroundColor: context.colorScheme.outline.withOpacity(0.2),
                    foregroundColor: AppThemeColorDark.textDark,
                  ),
                  child: Text('Delete my account'.hardCodedString),
                ).padSymmetric(
                  vertical: 15,
                ),
              ),
            ].columnInPadding(10),
          ),
        ].expand((element) => [element, const Divider()]).toList(),
      ).padAll(15);
    }),
  );
}

RichText deleteAccountBulletList(
  BuildContext context, {
  required String title,
  required String subtitle,
}) {
  return RichText(
    text: TextSpan(
      text: '${TextConstant.bulletList} $title: ',
      style: context.textTheme.bodyMedium?.copyWith(
        fontWeight: AppFontWeight.w600,
      ),
      children: [
        TextSpan(
          text: subtitle,
          style: context.textTheme.bodySmall,
        )
      ],
    ),
  );
}
