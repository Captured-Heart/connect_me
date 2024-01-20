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
    return values.isEmpty || values == null
        ? const SizedBox.shrink()
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '$keys: ',
                textScaleFactor: 0.9,
              ),
              Expanded(
                child: AutoSizeText(
                  values,
                  style: context.textTheme.labelMedium,
                  textScaleFactor: 0.9,
                ),
              ),
            ],
          );
  }
}
