import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:mail_sender/providers/send_mails/send_mails_provider.dart';
import 'package:mail_sender/ui/widgets/custom_input.dart';
import 'package:mail_sender/utils/color/app_colors.dart';
import 'package:provider/provider.dart';

class SendMailsPage extends StatelessWidget {
  const SendMailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Consumer<SendMailsProvider>(builder: (context, provider, _) {
      return Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withValues(alpha: 0.05),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            padding: EdgeInsets.all(24),
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      "Qabul qiluvchilar",
                      style: textTheme.titleMedium,
                    ),
                    SizedBox(height: 16),
                    Expanded(
                      child: Container(
                        width: 500,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        padding: EdgeInsets.all(8),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Jami: ${provider.selectedRecipients.length}",
                                  ),
                                  Spacer(),
                                  Checkbox(
                                    value: provider.selectedRecipients.isNotEmpty && provider.selectedRecipients.length == provider.recipients.length,
                                    onChanged: (value) {
                                      if (value == true) {
                                        provider.selectedRecipients = List.from(provider.recipients);
                                      } else {
                                        provider.selectedRecipients = [];
                                      }
                                    },
                                  ),
                                  Text(
                                    "Hammasini tanlash",
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: provider.recipients.length,
                                itemBuilder: (context, index) {
                                  bool value = provider.selectedRecipients.contains(provider.recipients[index]);

                                  void onChanged(bool? value) {
                                    if (value == true) {
                                      provider.onSelecteRecipient(provider.recipients[index]);
                                    } else {
                                      provider.onRemoveRecipient(provider.recipients[index]);
                                    }
                                  }

                                  return ListTile(
                                    tileColor: Colors.red, //value ? Colors.grey.shade100 : Colors.white,
                                    onTap: () {
                                      onChanged(!value);
                                    },
                                    leading: Checkbox(
                                      value: value,
                                      onChanged: onChanged,
                                    ),
                                    hoverColor: Colors.grey.shade100,
                                    mouseCursor: WidgetStateMouseCursor.clickable,
                                    title: Text(
                                      provider.recipients[index]['email'],
                                      style: textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          provider.recipients[index]['fio'],
                                          style: textTheme.bodySmall,
                                        ),
                                        Text(
                                          provider.recipients[index]['passport'],
                                          style: textTheme.bodySmall?.copyWith(
                                            color: Colors.grey.shade600,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    trailing: PopupMenuButton(
                                      tooltip: "Tools",
                                      position: PopupMenuPosition.under,
                                      constraints: BoxConstraints(
                                        minWidth: 36,
                                      ),
                                      color: AppColors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(Icons.more_vert_rounded),
                                      itemBuilder: (context) {
                                        return [
                                          PopupMenuItem(
                                            child: Center(child: Icon(Icons.edit_rounded)),
                                            onTap: () {
                                              provider.addRecipient(
                                                context,
                                                recipient: provider.recipients[index],
                                              );
                                            },
                                          ),
                                          PopupMenuItem(
                                            child: Center(
                                                child: Icon(
                                              Icons.delete_rounded,
                                              color: Colors.red,
                                            )),
                                            onTap: () {
                                              provider.onDeleteRecipient(provider.recipients[index]);
                                            },
                                          ),
                                        ];
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                FloatingActionButton(
                                  tooltip: "Qabul qiluvchi qo'shish",
                                  elevation: 0,
                                  onPressed: () {
                                    provider.addRecipient(context);
                                  },
                                  backgroundColor: AppColors.primary,
                                  child: Icon(Icons.add_rounded),
                                ),
                              ],
                            ),
                            // TextButton(
                            //   onPressed: () {
                            //     provider.addRecipient(context);
                            //   },
                            //   style: TextButton.styleFrom(
                            //     backgroundColor: AppColors.primary.withValues(alpha: 0.2),
                            //     foregroundColor: AppColors.primary,
                            //     fixedSize: Size.fromHeight(40),
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(8),
                            //     ),
                            //   ),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       Padding(
                            //         padding: const EdgeInsets.symmetric(horizontal: 16),
                            //         child: Text(
                            //           "Qo'shish",
                            //           style: textTheme.bodyMedium?.copyWith(
                            //             fontWeight: FontWeight.w600,
                            //             color: AppColors.primary,
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "Xat yuborish",
                        style: TextTheme.of(context).titleMedium,
                      ),
                      SizedBox(height: 20),
                      Row(
                        spacing: 4,
                        children: [
                          Expanded(
                            child: CustomInput(
                              size: 45,
                              hint: "Yuboruvchi nomi",
                              controller: provider.addressController,
                            ),
                          ),
                          Expanded(
                            child: CustomInput(
                              size: 45,
                              hint: "Mavzu",
                              controller: provider.subjectController,
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await provider.sendEmail(context);
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: AppColors.white,
                              fixedSize: Size(45, 45),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Icon(
                              Icons.send_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey.shade300,
                            ),
                          ),
                          // padding: EdgeInsets.all(8),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: QuillSimpleToolbar(
                                    controller: provider.controller,
                                    config: QuillSimpleToolbarConfig(
                                      color: AppColors.primary,
                                      showBackgroundColorButton: false,
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.grey.shade100,
                                    ),
                                  ),
                                  child: QuillEditor(
                                    controller: provider.controller,
                                    focusNode: FocusNode(
                                      canRequestFocus: true,
                                      descendantsAreFocusable: true,
                                      descendantsAreTraversable: true,
                                    ),
                                    scrollController: ScrollController(),
                                    config: QuillEditorConfig(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Loader
          if (provider.isLoading)
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),
              ),
              child: Center(
                child: Container(
                  width: 100,
                  height: 120,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox.square(
                          dimension: 36,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          "${provider.sentCount}/${provider.recipients.length}",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}
