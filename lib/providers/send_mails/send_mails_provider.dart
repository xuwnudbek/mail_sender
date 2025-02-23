
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/utils.dart';
import 'package:mail_sender/services/mail_sender.dart';
import 'package:mail_sender/services/storage_service.dart';
import 'package:mail_sender/ui/widgets/custom_snackbars.dart';
import 'package:mail_sender/utils/extension/main_extensions.dart';
import 'package:vsc_quill_delta_to_html/vsc_quill_delta_to_html.dart';

class SendMailsProvider extends ChangeNotifier {
  final TextEditingController searchController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  QuillController controller = QuillController.basic();

  List recipients = [];

  /*
  "xuwnudbek266@gmail.com",
  "vizzanoerp@gmail.com",
  "aliyevjamkhan499@gmail.com",
  "abdurakhmanov1602@gmail.com",
  "gvedmanul@gmail.com",
  "qodirxonyusufjanov5@gmail.com",
  */

  List _selectedRecipients = [];
  List get selectedRecipients => _selectedRecipients;
  set selectedRecipients(value) {
    _selectedRecipients = value;
    notifyListeners();
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  int _sentCount = 0;
  int get sentCount => _sentCount;
  set sentCount(value) {
    _sentCount = value;
    notifyListeners();
  }

  SendMailsProvider() {
    getAllRecipients();
  }

  Future<void> sendEmail(BuildContext context) async {
    String html = QuillDeltaToHtmlConverter(controller.document.toDelta().toJson()).convert();

    if (selectedRecipients.isEmpty) {
      CustomSnackbars.warning(context, "Birorta ham qabul qiluvchi tanlanmagan!");
      return;
    }

    if (subjectController.text.isEmpty) {
      CustomSnackbars.warning(context, "Mavzu kiritilmagan!");
      return;
    }

    if (html.isEmpty) {
      CustomSnackbars.warning(context, "Matn kiritilmagan!");
      return;
    }

    isLoading = true;

    Stream mailStream = Stream.fromFutures(
      recipients.map((e) async {
        String htmlFoo = html;

        htmlFoo = htmlFoo.insertPropertiesToString(
          email: e["email"],
          fio: e["fio"],
          passport: e["passport"],
        );

        return MailSender.sendEmail(
          recipients: [e["email"]],
          address: addressController.text,
          subject: subjectController.text,
          html: htmlFoo,
          text: controller.document.toDelta().toString(),
        );
      }),
    );

    mailStream.listen(
      (event) {
        sentCount++;
      },
      onDone: () {
        CustomSnackbars.success(context, "Email muvaffaqiyatli yuborildi!");
        sentCount = 0;
        isLoading = false;
      },
    );
  }

  Future<void> addRecipient(
    BuildContext context, {
    Map? recipient,
  }) async {
    TextEditingController recipientController = TextEditingController();
    TextEditingController fioController = TextEditingController();
    TextEditingController passportController = TextEditingController();

    if (recipient != null) {
      recipientController.text = recipient["email"];
      fioController.text = recipient["fio"];
      passportController.text = recipient["passport"];
    }

    var res = await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return AlertDialog.adaptive(
            title: Text("Qabul qiluvchi qo'shish"),
            content: SizedBox(
              width: 300,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: recipientController,
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      enabledBorder: UnderlineInputBorder(),
                    ),
                  ),
                  TextField(
                    controller: fioController,
                    decoration: InputDecoration(
                      hintText: "F.I.O",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      enabledBorder: UnderlineInputBorder(),
                    ),
                  ),
                  // uppercase
                  TextField(
                    textCapitalization: TextCapitalization.sentences,
                    controller: passportController,
                    style: TextStyle(),
                    decoration: InputDecoration(
                      hintText: "Passport",
                      hintStyle: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      enabledBorder: UnderlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Bekor qilish"),
              ),
              TextButton(
                onPressed: () {
                  if (recipientController.text.isEmpty || fioController.text.isEmpty || passportController.text.isEmpty) {
                    CustomSnackbars.warning(context, "Barcha maydonlar to'ldirilishi shart!");
                    return;
                  }

                  if (recipientController.text.isEmail == false) {
                    CustomSnackbars.warning(context, "Email noto'g'ri kiritildi!");
                    return;
                  }

                  if (recipients.contains(recipientController.text)) {
                    CustomSnackbars.warning(context, "Bu email allaqachon qo'shilgan!");
                    return;
                  }

                  Navigator.pop(context, true);
                },
                child: Text("Qo'shish"),
              ),
            ],
          );
        });
      },
    );

    if (res == true) {
      if (recipient != null) {
        recipients.remove(recipient);
      }

      recipients.insert(0, {
        "email": recipientController.text,
        "fio": fioController.text,
        "passport": passportController.text,
      });
      StorageService.write("recipients", recipients);
      notifyListeners();
    }
  }

  void getAllRecipients() {
    StorageService.clear();

    recipients = StorageService.read("recipients") ?? recipients;
    notifyListeners();
  }

  void onSelecteRecipient(recipient) {
    selectedRecipients.add(recipient);
    notifyListeners();
  }

  void onRemoveRecipient(recipient) {
    selectedRecipients.remove(recipient);
    notifyListeners();
  }

  void onDeleteRecipient(recipient) {
    recipients.remove(recipient);
    StorageService.write("recipients", recipients);
    notifyListeners();
  }
}
