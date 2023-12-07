import 'package:connect_me/app.dart';

extension PaddingExtension on Widget {
  Widget padAll(double padding) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: this,
    );
  }

  Widget padSymmetric({double horizontal = 0.0, double vertical = 0.0}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  Widget padOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }
}

extension AlignmentExtension on Widget {
  Widget alignCenterLeft({
    double? widthFactor,
    double? heightFactor,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
    );
  }

  Widget alignCenterRight({
    double? widthFactor,
    double? heightFactor,
  }) {
    return Align(
      alignment: Alignment.centerRight,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
    );
  }

  Widget alignTopLeft({
    double? widthFactor,
    double? heightFactor,
  }) {
    return Align(
      alignment: Alignment.topLeft,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
    );
  }

  Widget alignTopRight({
    double? widthFactor,
    double? heightFactor,
  }) {
    return Align(
      alignment: Alignment.topRight,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
    );
  }

  Widget alignBottomLeft({
    double? widthFactor,
    double? heightFactor,
  }) {
    return Align(
      alignment: Alignment.bottomLeft,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
    );
  }

  Widget alignBottomRight({
    double? widthFactor,
    double? heightFactor,
  }) {
    return Align(
      alignment: Alignment.bottomRight,
      widthFactor: widthFactor,
      heightFactor: heightFactor,
    );
  }
}

extension ColumnChildrenSpacing on List<Widget> {
  List<Widget> columnInPadding(double height) {
    return expand(
      (element) => [
        element,
        SizedBox(
          height: height,
        )
      ],
    ).toList();
  }

  List<Widget> rowInPadding(double width) {
    return expand(
      (element) => [
        element,
        SizedBox(
          width: width,
        )
      ],
    ).toList();
  }
}

extension MediaQuerySizeExtension on BuildContext {
  double sizeWidth(double w) {
    return MediaQuery.of(this).size.width * w;
  }

  double sizeHeight(double h) {
    return MediaQuery.of(this).size.height * h;
  }
}

extension StringExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');

  String toCommaPrices() {
    final formatter = NumberFormat("###,###.#", "en_US");
    if (isEmpty) {
      return '';
    } else {
      final price = formatter.format(isEmpty ? 0.00 : double.parse(this));
      return price;
    }
  }
}

extension LinearGradientExtension on Widget {
  Widget withLinearGradient({
    List<Color>? colors,
    Alignment? begin,
    Alignment? end,
    bool? isLongBTN = true,
  }) {
    return Container(
      decoration: BoxDecoration(
        gradient: orangeGradient(colors: colors, begin: begin, end: end),
      ),

      // orangeGradient(colors : colors, begin: begin, end: end),
      child: this,
    );
  }
}

LinearGradient orangeGradient({
  List<Color>? colors,
  Alignment? begin,
  Alignment? end,
  bool? isLongBTN,
}) {
  return LinearGradient(
    colors: isLongBTN == false
        ? [
            Colors.red.shade400,
            Colors.orange.shade300,
            Colors.orange.shade300,
            Colors.red.shade300,
            Colors.red.shade300,
          ]
        : colors ??
            [
              Colors.red.shade300,
              Colors.red.shade400,
              Colors.redAccent,

              // Colors.red.shade300,
              // Colors.orange.shade800,
              // Colors.red.shade400,
            ],
    begin: begin ?? Alignment.bottomLeft,
    end: end ?? Alignment.topRight,
  );
}

LinearGradient whiteGradient({
  List<Color>? colors,
  Alignment? begin,
  Alignment? end,
  bool? isLongBTN,
  required BuildContext context,
}) {
  return LinearGradient(
    colors: [
      context.colorScheme.onSurface,
      context.colorScheme.surface,
      context.colorScheme.onSurface,
    ],
    begin: begin ?? Alignment.topLeft,
    end: end ?? Alignment.bottomRight,
  );
}
