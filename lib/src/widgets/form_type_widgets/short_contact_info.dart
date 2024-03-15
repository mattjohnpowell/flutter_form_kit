import 'package:flutter/material.dart';
import 'package:flutter_form_kit/src/widgets/flutter_form_details.dart';

class ShortContactInfo extends StatefulWidget {
  final Function(List<String>) onUpdateFields;
  final Map<String, String>?
      initialDataMap; // Use a map to specify initial data for each field

  const ShortContactInfo({
    Key? key,
    required this.onUpdateFields,
    this.initialDataMap,
  }) : super(key: key);

  @override
  State<ShortContactInfo> createState() => _ShortContactInfoState();
}

class _ShortContactInfoState extends State<ShortContactInfo> {
  late final TextEditingController controllerName;
  late final TextEditingController controllerEmail;
  late final TextEditingController controllerBirthday;
  late final TextEditingController controllerHeight;
  // Declare isValidEmail as a ValueNotifier
  ValueNotifier<bool> isValidEmail = ValueNotifier(true);
  @override
  void initState() {
    super.initState();
    // Initialize controllers with data from initialDataMap
    controllerName =
        TextEditingController(text: widget.initialDataMap?["name"] ?? "");
    controllerEmail =
        TextEditingController(text: widget.initialDataMap?["email"] ?? "");
    controllerBirthday =
        TextEditingController(text: widget.initialDataMap?["birthday"] ?? "");
    controllerHeight =
        TextEditingController(text: widget.initialDataMap?["height"] ?? "");
  }

  @override
  void dispose() {
    controllerName.dispose();
    controllerEmail.dispose();
    controllerBirthday.dispose();
    controllerHeight.dispose();
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
// Invoke onUpdateFields callback with updated field values
              widget.onUpdateFields([
                controllerName.text,
                controllerEmail.text,
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
