import 'package:flutter/material.dart';
import 'package:flutter_manajemen_waktu/constants.dart';

class BuildFieldText extends StatefulWidget {
  final String labelText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final String placeholder;
  final Icon? prefix;

  final Function(String) setMethod;

  const BuildFieldText({
    super.key,
    required this.labelText,
    required this.placeholder,
    required this.keyboardType,
    required this.controller,
    required this.setMethod,
    this.prefix,
  });

  @override
  _BuildFieldTextState createState() => _BuildFieldTextState();
}

class _BuildFieldTextState extends State<BuildFieldText> {
  final _formKey = GlobalKey<FormState>();

  bool editable = false;

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      editable = widget.placeholder.isNotEmpty;
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding - 10),
      child: Row(
        children: [
          const Spacer(),
          Expanded(
            flex: 20,
            child: TextField(
              readOnly: true,
              canRequestFocus: false,
              keyboardType: widget.keyboardType,
              decoration: InputDecoration(
                border: const UnderlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(10, 6.6),
                  ),
                  borderSide: BorderSide(
                    color: kButtonPrimaryColor,
                    width: 2.0,
                  ),
                ),
                hintText: widget.placeholder,
                labelText: widget.labelText,
                floatingLabelBehavior: FloatingLabelBehavior.always,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: widget.prefix,
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (builder) {
                          return Form(
                            key: _formKey,
                            child: AlertDialog(
                              title: editable
                                  ? Text("Edit ${widget.labelText}")
                                  : Text("Add ${widget.labelText}"),
                              content: TextFormField(
                                controller: widget.controller,
                                keyboardType: widget.keyboardType,
                                decoration: InputDecoration(
                                  hintText: widget.placeholder,
                                  border: const UnderlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.elliptical(10, 6.6),
                                    ),
                                    borderSide: BorderSide(
                                      color: kButtonPrimaryColor,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      _formKey.currentState!.reset();
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: const Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    final value1 = widget.controller.text;

                                    setState(() {
                                      if (value1.isNotEmpty) {
                                        widget.setMethod(value1);
                                      }

                                      _formKey.currentState!.reset();
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: const Text("Save"),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: Text(
                      editable ? "Edit" : "Add ${widget.labelText}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kButtonPrimaryColor,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 16.0,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
