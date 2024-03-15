import 'package:flutter/material.dart';
import 'package:flutter_form_kit/src/widgets/flutter_form_details.dart';

class ShortContactInfo extends StatefulWidget {
  final Function(List<String>) fields;
  final List<String>? initialData; // Add this line to accept initial data

  const ShortContactInfo({
    Key? key,
    required this.fields,
    this.initialData, // Include initialData in the constructor
  }) : super(key: key);

  @override
  State<ShortContactInfo> createState() => _ShortContactInfoState();
}

class _ShortContactInfoState extends State<ShortContactInfo> {
  late final TextEditingController controllerName;
  late final TextEditingController controllerEmail;
  late final TextEditingController controllerBirthday;
  late final TextEditingController controllerHeight;
  // Use ValueNotifier to manage the validation state of the email
  ValueNotifier<bool> isValidEmail = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    // Initialize controllers with initial data if provided, else with empty strings
    controllerName = TextEditingController(text: widget.initialData?[0] ?? "");
    controllerEmail = TextEditingController(text: widget.initialData?[1] ?? "");
    controllerBirthday =
        TextEditingController(text: widget.initialData?[2] ?? "");
    controllerHeight =
        TextEditingController(text: widget.initialData?[3] ?? "");
  }

  @override
  void dispose() {
    controllerName.dispose();
    controllerEmail.dispose();
    controllerBirthday.dispose();
    controllerHeight.dispose();
    isValidEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        contactInfoTextField("First name", "Jane", context, controllerName),
        contactInfoTextField(
            "Email", "name@example.com", context, controllerEmail,
            isEmail: true),
        GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
            child: contactInfoTextField("Birthday", "Select your birthday",
                context, controllerBirthday),
          ),
        ),
        contactInfoTextField(
            "Height (cm)", "Enter your height", context, controllerHeight,
            isNumber: true),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        controllerBirthday.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  Widget contactInfoTextField(String label, String hint, BuildContext context,
      TextEditingController controller,
      {bool isEmail = false, bool isNumber = false}) {
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
              // Update fields for the ShortContactInfo widget
              widget.fields([
                controllerName.text,
                controllerEmail.text,
                // Include new controllers' values
                controllerBirthday.text,
                controllerHeight.text,
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
                  borderSide: BorderSide(color: themeColor)),
              fillColor:
                  !isValid && isEmail ? Colors.red.withOpacity(0.2) : null,
              filled: !isValid && isEmail,
            ),
            keyboardType: isNumber
                ? TextInputType.numberWithOptions(decimal: true)
                : TextInputType.text,
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
