import 'package:connect_me/app.dart';

class ContactScreen extends ConsumerWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(TextConstant.myConnect),
        // actions: [
        // SizedBox(
        //   width: 100,
        //   height: 250,
        //   child: SearchAnchor.bar(
        //     isFullScreen: false,
        //     viewConstraints: BoxConstraints.expand(height:  150, width: context.sizeWidth(0.7)),
        //     // builder: (context, controller) {
        //     //   return Icon(EvaIcons.search);
        //     // },
        //     suggestionsBuilder: (context, controller) {
        //       return List.generate(
        //         5,
        //         (index) => Text('message'),
        //       );
        //     },
        //     // viewBuilder: (suggestions) {
        //     //   return Text('okay ma');
        //     // },
        //   ),
        // ),
        // ],
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: List.generate(
          20,
          (index) => GestureDetector(
            onTap: () {
              // pop(context);
              // ref.read(bottomNavBarIndexProvider.notifier).update((state) => 1);
              pushAsVoid(
                  context,
                  ProfileScreen(
                    implyLeading: true,
                  ));
            },
            child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ProfilePicWidget(
                    withoutBorder: true,
                  ),
                  AutoSizeText(
                    faker.person.name(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textScaleFactor: 0.9,
                    textAlign: TextAlign.center,
                  )
                ].columnInPadding(3)),
          ),
        ),
      ),
      // Wrap(
      //   children: List.generate(
      //     20,
      //     (index) =>

      //     Column(
      //       mainAxisSize: MainAxisSize.min,
      //       children: [
      //         ProfilePicWidget(
      //           withoutBorder: true,
      //         ),
      //         AutoSizeText(
      //           faker.person.name(),
      //           maxLines: 1,
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
