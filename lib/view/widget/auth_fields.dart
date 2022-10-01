import 'package:air_tinder/constant/color.dart';
import 'package:flutter/material.dart';

class AuthFields extends StatefulWidget {
  AuthFields({
    Key? key,
    this.controller,
    this.onChanged,
    this.hintText = '',
    this.labelText = '',
    this.isObSecure = false,
    this.isPasswordField = false,
  }) : super(key: key);

  TextEditingController? controller;
  ValueChanged<String>? onChanged;
  String? labelText, hintText;
  bool? isObSecure, isPasswordField;

  @override
  State<AuthFields> createState() => _AuthFieldsState();
}

class _AuthFieldsState extends State<AuthFields> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: TextFormField(
        textInputAction: TextInputAction.next,
        controller: widget.controller,
        onChanged: widget.onChanged,
        cursorColor: kPrimaryColor,
        cursorWidth: 1.0,
        obscuringCharacter: '*',
        obscureText: widget.isObSecure!,
        style: TextStyle(
          fontSize: 16,
          color: kPrimaryColor,
          fontWeight: FontWeight.w300,
        ),
        decoration: InputDecoration(
          suffixIcon: widget.isPasswordField!
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.isObSecure = !widget.isObSecure!;
                        });
                      },
                      child: Icon(
                        widget.isObSecure!
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: kSecondaryColor,
                      ),
                    ),
                  ],
                )
              : null,
          labelText: widget.labelText,
          labelStyle: TextStyle(
            fontSize: 16,
            color: kPrimaryColor,
            fontWeight: FontWeight.w300,
          ),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 16,
            color: kPrimaryColor,
            fontWeight: FontWeight.w300,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: kPrimaryColor,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: kSecondaryColor,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
