import 'package:connect_me/app.dart';

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
      width: 120,
      child: CountryCodePicker(
        backgroundColor: context.theme.scaffoldBackgroundColor,
        // barrierColor: Colors.white,
        padding: EdgeInsets.zero,
        onChanged: onChanged,
        initialSelection: initialPrefix,
        favorite: const ['+234', 'NG'],
        showCountryOnly: true,
        flagWidth: 23,

        showOnlyCountryWhenClosed: false,
        dialogBackgroundColor: context.theme.scaffoldBackgroundColor,
        dialogTextStyle: context.textTheme.bodyLarge,
        // boxDecoration: BoxDecoration(border: Border.all(color: Colors.red)),
        textStyle: context.textTheme.bodyLarge,
        alignLeft: true,
        flagDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: context.theme.scaffoldBackgroundColor,
        ),
      ),
    );
  }
}
