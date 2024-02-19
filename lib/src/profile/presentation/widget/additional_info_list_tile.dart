import 'package:connect_me/app.dart';

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
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '$keys: ',
                textScaleFactor: 0.7,
                style: context.textTheme.bodyLarge?.copyWith(fontWeight: AppFontWeight.w700),
              ),
              Expanded(
                child: AutoSizeText(
                  values,
                  style: context.textTheme.bodySmall?.copyWith(fontWeight: AppFontWeight.w100),
                  textScaleFactor: 0.9,
                ),
              ),
            ],
          ).padOnly(bottom: 5);
  }
}
