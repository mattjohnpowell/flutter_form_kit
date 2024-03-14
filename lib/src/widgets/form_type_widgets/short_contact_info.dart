import 'package:flutter/material.dart';
import 'package:flutter_form_kit/src/widgets/flutter_form_details.dart';


class ShortContactInfo extends StatefulWidget {
  final Function(List<String>) fields;

  const ShortContactInfo({super.key, required this.fields});

  @override
  State<ShortContactInfo> createState() => _ShortContactInfoState();
}

class _ShortContactInfoState extends State<ShortContactInfo> {
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller4 = TextEditingController(); // Assuming this is the email controller

  // Use ValueNotifier to manage the validation state of the email
  ValueNotifier<bool> isValidEmail = ValueNotifier(true);

  @override
  void dispose() {
    // Dispose controllers and ValueNotifier when the widget is disposed
    controller1.dispose();
    controller4.dispose();
    isValidEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        contactInfoTextField("First name", "Jane", context, controller1),
        contactInfoTextField("Email", "name@example.com", context, controller4, isEmail: true),
      ],
    );
  }

  Widget contactInfoTextField(String label, String hint, BuildContext context, TextEditingController controller, {bool isEmail = false}) {
    final themeColor = FlutterFormDetails.of(context).themeColor;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: ValueListenableBuilder(
        valueListenable: isValidEmail,
        builder: (context, bool isValid, child) {
          return TextField(
            style: textTheme.headlineMedium,
            controller: controller,
            onChanged: (value) {
              if (isEmail) {
                isValidEmail.value = _validateEmail(value);
              }
              widget.fields([
                controller1.text,
                controller4.text,
              ]);
            },
            cursorColor: themeColor,
            decoration: InputDecoration(
              labelText: label,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: textTheme.headlineSmall?.copyWith(color: themeColor),
              floatingLabelAlignment: FloatingLabelAlignment.start,
              hintText: hint,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeColor)
              ),
              fillColor: !isValid && isEmail ? Colors.red.withOpacity(0.2) : null,
              filled: !isValid && isEmail,
            ),
          );
        },
      ),
    );
  }

  bool _validateEmail(String email) {
    // Basic regex for email validation
    final emailRegex = RegExp(r'^\S+@\S+\.\S+$');
    return emailRegex.hasMatch(email);
  }
}