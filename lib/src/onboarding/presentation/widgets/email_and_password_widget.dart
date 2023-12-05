
import 'package:connect_me/app.dart';

class EmailAndPasswordWidget extends StatelessWidget {
  const EmailAndPasswordWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: AppBorderRadius.c12,
        border: Border.all(width: 0.2, color: context.colorScheme.onBackground),
      ),
      child: Column(
        children: [
          //
          //textfields
          authTextFieldWidget(
            hintText: TextConstant.emailAddress,
            fillColor: Colors.transparent,

            // fillColor: context.colorScheme.surface,
            controller: TextEditingController(),
            context: context,
            noBorders: true,
          ).padSymmetric(horizontal: 8, vertical: 2),
          const Divider(thickness: 1.2),

          //textfields
          authTextFieldWidget(
            hintText: TextConstant.password,
            fillColor: Colors.transparent,
            controller: TextEditingController(),
            context: context,
            noBorders: true,
          ).padSymmetric(horizontal: 8, vertical: 2),
        ],
      ),
    );
  }
}
