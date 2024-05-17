import 'dart:typed_data';

import 'package:connect_me/app.dart';
import 'package:uuid/v4.dart';

class AddEditContactScreen extends ConsumerStatefulWidget {
  const AddEditContactScreen({
    super.key,
    required this.contact,
  });
  final Contact? contact;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddEditContactScreenState();
}

class _AddEditContactScreenState extends ConsumerState<AddEditContactScreen> {
  late ValueNotifier<String?> nameNotifier;
  late ValueNotifier<String?> workCompanyNameNotifier;
  late ValueNotifier<String?> workTitleoNotifier;
  late ValueNotifier<String?> workLocationNotifier;

  late ValueNotifier<String?> phoneNotifier;
  late ValueNotifier<String?> emailNotifier;
  late ValueNotifier<String?> websiteNotifier;
  late ValueNotifier<Uint8List?> imgUrlNotifier;

  @override
  void initState() {
    Contact? contactInfo = widget.contact;
    Website? website = (contactInfo?.websites != null && contactInfo?.websites.isNotEmpty == true)
        ? contactInfo?.websites.first
        : null;
    Organization? firstOrg =
        (contactInfo?.organizations != null && contactInfo?.organizations.isNotEmpty == true)
            ? contactInfo?.organizations.first
            : null;
    String companyName = firstOrg?.company ?? '';
    String workTitle = '${firstOrg?.title ?? ''} ';
    String workLocation = firstOrg?.officeLocation ?? '';
    Phone? phone = (contactInfo?.phones != null && contactInfo?.phones.isNotEmpty == true)
        ? contactInfo?.phones.first
        : null;

    String email = contactInfo?.emails != null && contactInfo?.emails.isNotEmpty == true
        ? contactInfo!.emails.first.address
        : '';

    nameNotifier = ValueNotifier(contactInfo?.displayName ?? '');
    workCompanyNameNotifier = ValueNotifier(companyName);
    workTitleoNotifier = ValueNotifier(workTitle);
    workLocationNotifier = ValueNotifier(workLocation);
    phoneNotifier = ValueNotifier(phone?.number ?? phone?.normalizedNumber ?? '');
    emailNotifier = ValueNotifier(email);
    websiteNotifier = ValueNotifier(website?.url ?? '');
    imgUrlNotifier = ValueNotifier(contactInfo?.photoOrThumbnail);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Contact newContact = Contact(
      id: widget.contact?.id != null && widget.contact?.id.isNotEmpty == true
          ? widget.contact!.id
          : '',
      displayName: nameNotifier.value != null ? nameNotifier.value! : '',
      emails: [Email(emailNotifier.value != null ? emailNotifier.value! : '')],
      phones: [Phone(phoneNotifier.value != null ? phoneNotifier.value! : '')],
      websites: [Website(websiteNotifier.value != null ? websiteNotifier.value! : '')],
      organizations: [
        Organization(
          company: workCompanyNameNotifier.value != null ? workCompanyNameNotifier.value! : '',
          title: workTitleoNotifier.value != null ? workTitleoNotifier.value! : '',
          officeLocation: workLocationNotifier.value != null ? workLocationNotifier.value! : '',
        ),
      ],
    );

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: CircleChipButton(
                iconData: Icons.delete,
                tooltip: 'delete contact',
                iconColor: context.colorScheme.error,
                onTap: () {
                  ref.read(addEditNotifierProvider.notifier).deleteContact(newContact);
                },
              ),
            ).padSymmetric(vertical: 10),
            Center(
              child: SizedBox(
                height: 80,
                width: 100,
                child: imgUrlNotifier.value != null && imgUrlNotifier.value!.isNotEmpty
                    ? ClipRRect(
                        borderRadius: AppBorderRadius.c12,
                        child: Image.memory(
                          imgUrlNotifier.value!,
                          fit: BoxFit.fill,
                        ),
                      )
                    : CustomPaint(
                        painter: DottedBorderPainter(context),
                        child: const Icon(
                          accountCircleIcon,
                          size: 30,
                        ),
                      ),
              ),
            ),

            // name
            AuthTextFieldWidget(
              initialValue: nameNotifier.value,
              inputFormatters: const [],
              onChanged: (p0) {
                nameNotifier.value = p0;
              },
              labelWidget: Row(
                  children: [
                Icon(
                  Icons.person,
                  color: context.colorScheme.outline,
                  size: 16,
                ),
                Text('Name'.hardCodedString),
              ].rowInPadding(5)), // label: 'Name'.hardCodedString,
              inputBorder: underlineInputBorder(context),
              focusedInputBorder: underlineInputBorder(context, isFocused: true),
            ),
            //work info
            AuthTextFieldWidget(
              initialValue: workCompanyNameNotifier.value,
              inputFormatters: const [],
              onChanged: (p0) {
                workCompanyNameNotifier.value = p0;
              },
              labelWidget: Row(
                  children: [
                Icon(
                  Icons.maps_home_work_outlined,
                  color: context.colorScheme.outline,
                  size: 16,
                ),
                Text('Work info'.hardCodedString),
              ].rowInPadding(5)),
              inputBorder: underlineInputBorder(context),
              focusedInputBorder: underlineInputBorder(context, isFocused: true),
            ),

            //phone
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: AuthTextFieldWidget(
                    initialValue: phoneNotifier.value,
                    onChanged: (p0) {
                      phoneNotifier.value = p0;
                    },
                    keyboardType: TextInputType.number,
                    labelWidget: Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: context.colorScheme.outline,
                          size: 16,
                        ),
                        Text('Phone'.hardCodedString),
                      ].rowInPadding(5),
                    ),
                    inputBorder: underlineInputBorder(context),
                    focusedInputBorder: underlineInputBorder(context, isFocused: true),
                  ),
                ),
                const Icon(
                  Icons.add,
                  color: AppThemeColorDark.successColor,
                  size: 22,
                ).onTapWidget(
                  onTap: () {},
                  tooltip: 'Add phone number'.hardCodedString,
                ),
              ],
            ),

            //email
            AuthTextFieldWidget(
              initialValue: emailNotifier.value,
              onChanged: (p0) {
                emailNotifier.value = p0;
              },
              keyboardType: TextInputType.emailAddress,
              labelWidget: Row(
                  children: [
                Icon(
                  Icons.email,
                  color: context.colorScheme.outline,
                  size: 16,
                ),
                Text('Email'.hardCodedString),
              ].rowInPadding(5)),
              inputBorder: underlineInputBorder(context),
              focusedInputBorder: underlineInputBorder(context, isFocused: true),
            ),

            //website
            AuthTextFieldWidget(
              initialValue: websiteNotifier.value,
              inputFormatters: const [],
              onChanged: (p0) {
                websiteNotifier.value = p0;
              },
              labelWidget: Row(
                  children: [
                Icon(
                  Icons.language,
                  color: context.colorScheme.outline,
                  size: 16,
                ),
                Text('website'.hardCodedString),
              ].rowInPadding(5)),
              inputBorder: underlineInputBorder(context),
              focusedInputBorder: underlineInputBorder(context, isFocused: true),
            ),
            //cancel and save

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                //cancel btn
                TextButton(
                  onPressed: () {
                    pop(context);
                  },
                  child: Text(TextConstant.cancel,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.error,
                      )),
                ),

                //save btn
                TextButton(
                  onPressed: () {
                    widget.contact?.displayName =
                        nameNotifier.value != null ? nameNotifier.value! : '';
                    widget.contact?.emails = [
                      Email(emailNotifier.value != null ? emailNotifier.value! : '')
                    ];
                    widget.contact?.phones = [
                      Phone(phoneNotifier.value != null ? phoneNotifier.value! : '')
                    ];
                    widget.contact?.websites = [
                      Website(websiteNotifier.value != null ? websiteNotifier.value! : '')
                    ];

                    widget.contact?.organizations = [
                      Organization(
                        company: workCompanyNameNotifier.value != null
                            ? workCompanyNameNotifier.value!
                            : '',
                        title: workTitleoNotifier.value != null ? workTitleoNotifier.value! : '',
                        officeLocation:
                            workLocationNotifier.value != null ? workLocationNotifier.value! : '',
                      ),
                    ];

                    inspect(widget.contact);
                    if (widget.contact?.id != null && widget.contact?.id.isNotEmpty == true) {
                      widget.contact?.id =
                          widget.contact?.id != null && widget.contact?.id.isNotEmpty == true
                              ? widget.contact!.id
                              : '';
                      log('i am updating the contact');

                      ref.read(addEditNotifierProvider.notifier).updateContact(widget.contact!);
                    } else {
                      Contact? newContact = Contact()
                        ..displayName = nameNotifier.value != null ? nameNotifier.value! : ''
                        ..emails = [Email(emailNotifier.value != null ? emailNotifier.value! : '')]
                        ..phones = [Phone(phoneNotifier.value != null ? phoneNotifier.value! : '')]
                        ..websites = [
                          Website(websiteNotifier.value != null ? websiteNotifier.value! : '')
                        ]
                        ..organizations = [
                          Organization(
                            company: workCompanyNameNotifier.value != null
                                ? workCompanyNameNotifier.value!
                                : '',
                            title:
                                workTitleoNotifier.value != null ? workTitleoNotifier.value! : '',
                            officeLocation: workLocationNotifier.value != null
                                ? workLocationNotifier.value!
                                : '',
                          ),
                        ];

                      log('i am adding new contact');
                      ref.read(addEditNotifierProvider.notifier).addContact(newContact);
                    }
                  },
                  child: ref.watch(addEditNotifierProvider).isLoading
                      ? const SizedBox.square(
                          dimension: 20,
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          'Save',
                          style: context.textTheme.bodyLarge?.copyWith(
                            color: AppThemeColorDark.successColor,
                          ),
                        ),
                ),
              ],
            ).padOnly(top: 10),
          ].columnInPadding(5),
        ).padAll(20),
      ),
    );
  }

  UnderlineInputBorder underlineInputBorder(
    BuildContext context, {
    bool isFocused = false,
  }) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
          color: isFocused == true ? context.colorScheme.primary : context.colorScheme.onSurface,
          width: isFocused == true ? 0.8 : 0.2,
          strokeAlign: BorderSide.strokeAlignCenter),
    );
  }
}
