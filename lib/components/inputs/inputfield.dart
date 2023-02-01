import 'package:flutter/material.dart';

typedef FieldStateCallBack = void Function(bool state); //call back function

class CustomInputField extends StatefulWidget {
  CustomInputField(
      {Key? key,
      this.textInputtype = TextInputType.text,
      this.icon,
      this.label = '',
      this.errortext = '',
      this.onchange,
      this.fieldkey,
      this.obscuretext = false,
      this.fieldstate,
      this.sufixIcon,
      required this.focus,
      this.initialtext,
      required this.hint,
      this.maxlines = 1,
      this.isdense = true,
      this.size,
      this.showActiveBorder = true,
      this.length,
      this.borderRadius = 4.0,
      this.readOnly = false,
      this.validator,
      this.textController})
      : super(
          key: key,
        );

  final Size? size;
  final TextInputType textInputtype;
  final Widget? icon, sufixIcon;
  final String? initialtext;
  final String label;
  final String errortext, hint;
  final Function(String val)? onchange;
  final Key? fieldkey;
  final bool obscuretext;
  final bool focus, isdense;
  final bool showActiveBorder;
  final FieldStateCallBack? fieldstate;
  final Function(String? val)? validator;
  final int maxlines;
  final int? length;
  final double borderRadius;
  final bool readOnly;
  TextEditingController? textController;

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool fieldValid = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.fieldstate != null ? widget.fieldstate!(false) : null;
    });
  }

  /// ............................................................................
  ///   the Custom UI input text field
  ///
  ///...............................................................................
  @override
  Widget build(BuildContext context) {
    String errorTxt = widget.errortext;
    String displayedError = fieldValid == true ? '' : errorTxt;
    return Container(
      padding: EdgeInsets.only(top: widget.label == '' ? 0 : 28),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          TextFormField(
            key: widget.fieldkey, //field key
            onChanged: widget.onchange == null
                ? (value) {
                    checkField(value); //field validation method
                  }
                : (value) {
                    checkField(value);
                    widget.onchange!(value);
                  },
            validator: (value) =>
                Validator().validateValue(value!, widget.textInputtype),
            maxLength: widget.length,
            autofocus: widget.focus,
            enableSuggestions: false,
            obscureText: widget.obscuretext, readOnly: widget.readOnly,
            keyboardType: widget.textInputtype,
            initialValue:
                widget.textController == null ? widget.initialtext : null,
            controller:
                widget.initialtext == null ? widget.textController : null,

            maxLines: widget.maxlines,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                ?.copyWith(letterSpacing: 1, fontSize: 17),

            decoration: InputDecoration(
              isDense: widget.isdense,
              prefixIcon: widget.icon,
              suffixIcon: widget.sufixIcon,
              hintText: widget.hint,
              errorText: fieldValid == true ? null : displayedError,
              alignLabelWithHint: false,
              errorStyle: widget.errortext == ''
                  ? const TextStyle(
                      fontSize: 0.1,
                      color: Colors.transparent,
                    )
                  : const TextStyle(
                      fontSize: 15,
                    ),
              errorBorder: fieldValid == true
                  ? null
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      borderSide: const BorderSide(
                          width: 0.5, color: Colors.deepOrange)),
              border: const OutlineInputBorder(),
              enabledBorder: OutlineInputBorder(
                  borderSide: widget.showActiveBorder
                      ? const BorderSide(width: 0.8, color: Colors.black45)
                      : BorderSide.none,
                  borderRadius: BorderRadius.circular(widget.borderRadius)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 0.3, color: Colors.cyan),
                  borderRadius: BorderRadius.circular(widget.borderRadius)),
              focusedErrorBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(width: 0.8, color: Colors.deepOrange),
                  borderRadius: BorderRadius.circular(widget.borderRadius)),
            ),
          ),
          if (widget.label != '')
            Positioned(
                top: -27,
                child: Text(
                  widget.label,
                  overflow: TextOverflow.ellipsis,
                )),
        ],
      ),
    );
  }

  checkField(value) {
    if (value.length > 0) {
      var validField =
          ValidateInputField().validateValue(value, widget.textInputtype);

      if (validField == true) {
        setState(() {
          fieldValid = true;
          widget.fieldstate == null ? null : widget.fieldstate!(true);
        });
      } else {
        setState(() {
          fieldValid = false;
          widget.fieldstate == null ? null : widget.fieldstate!(false);
        });
      }

      /// print(validfield);
    } else {
      /// print('not allowed');
      setState(() {
        fieldValid = false;
        widget.fieldstate == null ? null : widget.fieldstate!(false);
      });
    }

    /// print(fieldValid);
  }
}

class ValidateInputField {
  ///this class test for field validity based on below criteria
  validateValue(String value, TextInputType inputType) {
    /// print(value);
    if (inputType == TextInputType.emailAddress && value.isNotEmpty == true) {
      return validateEmail(value);
    } else if (inputType == TextInputType.visiblePassword &&
        value.isNotEmpty == true) {
      /// print('its password');
      return validatPassword(value);
    } else if (inputType == TextInputType.number && value.isNotEmpty == true) {
      return validatnumber(value);
    } else if (inputType == TextInputType.text &&
        value.isNotEmpty == true &&
        value.length > 1) {
      return validatAlphaNumeric(value);
    } else if (inputType == TextInputType.phone &&
        value.isNotEmpty == true &&
        value.length > 1) {
      return validateNGNMobile(value);
    } else {
      /// print('not a type we know');
      return false;
    }
  }

  //setter
  bool validateEmail(String value) {
    RegExp emailRegex = RegExp(
        r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""");
    if (emailRegex.hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }

  bool validatPassword(String password, [int minLength = 8]) {
    if (password.length < minLength || password.isEmpty) {
      return false;
    }
    return true;
    // bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    // bool hasDigits = password.contains(RegExp(r'[0-9]'));
    // bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    // bool hasSpecialCharacters =
    //     password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    // bool hasMinLength = password.length >= minLength;
    //
    // return hasDigits &
    //     hasUppercase &
    //     hasLowercase &
    //     hasSpecialCharacters &
    //     hasMinLength;
  }

  bool validatnumber(String value) {
    RegExp letters = RegExp(r"""^[0-9]+""");
    if (letters.hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }

  // bool validatNGNMobile(String value) {
  //   RegExp letters = RegExp(
  //       r"(^090)|((^070)([1-9]))|((^080)([2-9]))|((^081)([0-9]))(\d{7})");
  //   if (letters.hasMatch(value)) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  bool validateNGNMobile(String value) {
    RegExp letters = RegExp(
        r"(\+234|234|0)(701|702|703|704|705|706|707|708|709|802|803|804|805|806|807|808|809|810|811|812|813|814|815|816|817|818|819|909|908|901|902|903|904|905|906|907)([0-9]{7})");
    if (letters.hasMatch(value)) {
      return true;
    } else {
      return false;
    }
  }

  bool validatAlphaNumeric(String value) {
    // RegExp expression =
    //     RegExp(r"""^[a-zA-Z0-9 _.!#$%&'*+-/=?^_`{|}~()@;'"]*$""");
    // bool hasCharacters = value.contains(expression);

    // return hasCharacters;
    return true;
  }
}

class Validator {
  ///this class test for field validity based on below criteria
  String? validateValue(String value, TextInputType inputType) {
    /// print(value);
    if (inputType == TextInputType.emailAddress && value.isNotEmpty == true) {
      return validateEmail(value);
    } else if (inputType == TextInputType.visiblePassword &&
        value.isNotEmpty == true) {
      /// print('its password');
      return validatePassword(value);
    } else if (inputType == TextInputType.number && value.isNotEmpty == true) {
      return validateNumber(value);
    } else if (inputType == TextInputType.text &&
        value.isNotEmpty == true &&
        value.length > 1) {
      return null;
    } else if (inputType == TextInputType.phone &&
        value.isNotEmpty == true &&
        value.length > 1) {
      return validateNGNMobile(value);
    } else {
      return null;
    }
  }

  //setter
  String? validateEmail(String value) {
    RegExp emailRegex = RegExp(
        r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""");
    if (emailRegex.hasMatch(value)) {
      return null;
    } else {
      return "Enter A valid Email Address";
    }
  }

  String? validatePassword(String password, [int minLength = 8]) {
    if (password.length < minLength || password.isEmpty) {
      return 'Password Must be Greater Than 6';
    }
    return null;
  }

  String? validateNumber(String value) {
    RegExp letters = RegExp(r"""^[0-9]+""");
    if (letters.hasMatch(value)) {
      return null;
    } else {
      return 'Must Contain Only Number';
    }
  }

  String? validateNGNMobile(String value) {
    RegExp letters = RegExp(
        r"(\+234|234|0)(701|702|703|704|705|706|707|708|709|802|803|804|805|806|807|808|809|810|811|812|813|814|815|816|817|818|819|909|908|901|902|903|904|905|906|907|916)([0-9]{7})");
    if (letters.hasMatch(value)) {
      return null;
    } else {
      return 'Not a Valid Nigeria Number';
    }
  }
}
