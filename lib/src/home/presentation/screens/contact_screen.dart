import 'package:connect_me/app.dart';

class ContactScreen extends ConsumerWidget {
  const ContactScreen({
    super.key,
    required this.connectsList,
  });

  final List<dynamic> connectsList;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts = ref.watch(fetchListProfileProvider(connectsList));

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
        body: contacts.when(
          data: (data) {
            return GridView.count(
              crossAxisCount: 3,
              children: List.generate(
                data.length,
                (index) {
                  var contacts = data[index];

                  return GestureDetector(
                    onTap: () async {
                      // log(contacts.toString());
                      pushAsVoid(
                          context,
                          ProfileScreenOthers(
                            uuid: contacts.docId,
                          ));
                    },
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ProfilePicWidget(
                            withoutBorder: true,
                            authUserModel: data[index],
                          ),
                          AutoSizeText(
                            contacts.username ?? faker.person.name(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textScaleFactor: 0.9,
                            textAlign: TextAlign.center,
                          )
                        ].columnInPadding(3)),
                  );
                },
              ),
            );
          },
          error: (error, _) {
            return Text('data');
          },
          loading: () => CircularProgressIndicator.adaptive(),
        )

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
