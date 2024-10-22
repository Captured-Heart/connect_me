import '../../app.dart';

final dateTimeProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});
void datePicker(
    {required BuildContext context,
    required Function setState,
    required TextEditingControllerClass textController,
    required WidgetRef ref}) {
  showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1920, 1),
      lastDate: DateTime(2078, 12),
      initialDatePickerMode: DatePickerMode.year,
      builder: (context, picker) {
        return Theme(
          data: ThemeData(
            colorScheme: ColorScheme.light(
              primary: context.theme.primaryColor,
              onPrimary: Colors.white,
              surface: context.textTheme.labelLarge!.color!,
              onSurface: context.theme.primaryColor,
            ),
            dialogBackgroundColor: context.theme.scaffoldBackgroundColor,
            dialogTheme: DialogTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                contentTextStyle: context.theme.textTheme.labelLarge,
                actionsPadding: const EdgeInsets.symmetric(horizontal: 30)),
          ),
          child: picker!,
        );
      }).then((selectedDate) {
    if (selectedDate != null) {
      setState(() {
        textController.dobController.text = dateFormatted3(selectedDate).toString();
        ref.read(dateTimeProvider.notifier).update(
            (state) => DateTime.fromMicrosecondsSinceEpoch(selectedDate.microsecondsSinceEpoch));
      });
    }
  });
}

Future<DateTime?> showCupertinoDateWidget({
  required BuildContext context,
  required dynamic Function(DateTime)? onConfirm,
  DateTime? currentTime,
  DateTime? maxTime,
}) async {
  return DatePicker.showDatePicker(
    context,
    theme: DatePickerTheme(
      cancelStyle: context.textTheme.bodyLarge!.copyWith(
        color: context.colorScheme.error,
      ),
      itemStyle: context.textTheme.bodyLarge!,
      backgroundColor: context.colorScheme.background,
    ),
    showTitleActions: true,
    minTime: DateTime(1960, 1, 20),
    maxTime: maxTime ?? DateTime.now(),
    currentTime: currentTime ?? DateTime.now(),
    onConfirm: onConfirm,
  );
}
