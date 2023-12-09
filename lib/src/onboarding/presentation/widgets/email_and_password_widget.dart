// import 'package:connect_me/app.dart';

// class EmailAndPasswordWidget extends StatefulWidget {
//   const EmailAndPasswordWidget({
//     super.key,
//   });

//   @override
//   State<EmailAndPasswordWidget> createState() => _EmailAndPasswordWidgetState();
// }

// class _EmailAndPasswordWidgetState extends State<EmailAndPasswordWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: AppBorderRadius.c12,
//         border: Border.all(width: 0.2, color: context.colorScheme.onBackground),
//       ),
//       child: Column(
//         children: [
//           //
//           //textfields
//           AuthTextFieldWidget(
//             hintText: TextConstant.emailAddress,
//             fillColor: Colors.transparent,

//             // fillColor: context.colorScheme.surface,
//             controller: TextEditingController(),
//             // context: context,
//             noBorders: true,
//           ).padSymmetric(horizontal: 8, vertical: 2),
//           const Divider(thickness: 1.2),

//           //textfields
//           AuthTextFieldWidget(
//             hintText: TextConstant.password,
//             fillColor: Colors.transparent,
//             controller: TextEditingController(),
//             // context: context,
//             noBorders: true,
//           ).padSymmetric(horizontal: 8, vertical: 2),
//         ],
//       ),
//     );
//   }
// }
