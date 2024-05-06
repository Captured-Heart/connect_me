import '../../app.dart';

class CountryCodeCustomWidget extends StatelessWidget {
  const CountryCodeCustomWidget({
    super.key,
    required this.onChanged,
    required this.initialPrefix,
  });

  final Function(CountryCode) onChanged;
  final String initialPrefix;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: CountryCodePicker(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        // barrierColor: Colors.white,
        padding: const EdgeInsets.only(left: 3),
        onChanged: onChanged,
        initialSelection: initialPrefix,
        favorite: const ['+234', 'NG'],
        showCountryOnly: true,
        flagWidth: 19,

        showOnlyCountryWhenClosed: false,
        dialogBackgroundColor: context.theme.scaffoldBackgroundColor,
        dialogTextStyle: context.textTheme.bodyLarge,
        // boxDecoration: BoxDecoration(border: Border.all(color: Colors.red)),
        textStyle: context.textTheme.bodyMedium,
        alignLeft: true,
        flagDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: context.theme.scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
