import '../../../../app.dart';

class AdditionalInfoListTileWidget extends StatelessWidget {
  const AdditionalInfoListTileWidget({
    super.key,
    required this.keys,
    required this.values,
  });

  final String keys, values;

  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    return values.isEmpty || values == null || keys.isEmpty
        ? const SizedBox.shrink()
        : RichText(
            text: TextSpan(
              text: '$keys: ',
              style: context.textTheme.bodyLarge?.copyWith(
                fontWeight: AppFontWeight.w700,
                fontSize: 11,
              ),
              children: [
                TextSpan(
                  text: values,
                  style: context.textTheme.bodySmall?.copyWith(fontWeight: AppFontWeight.w100),
                ),
              ],
            ),
          ).padOnly(bottom: 3);
  }
}
