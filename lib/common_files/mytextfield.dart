import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'fs_dimens.dart';
import 'styles.dart';

class AllInputDesign extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final Set<void> Function() onEditingComplete;
  final controller;
  final textInputAction;
  final focusNode;
  final prefixText;
  final enabled;
  final hintText;
  final inputHeaderName;
  final prefixStyle;
  final validator;
  final errorText;
  final keyBoardType;
  final validatorFieldValue;
  final List<TextInputFormatter> inputFormatterData;
  final FormFieldSetter<String> onSaved;
  final obsecureText;
  final suffixIcon;
  final prefixIcon;

  const AllInputDesign(
      {Key key,
      this.controller,
      this.enabled,
      this.prefixText,
      this.prefixStyle,
      this.keyBoardType,
      this.obsecureText,
      this.suffixIcon,
      this.prefixIcon,
      this.hintText,
      this.inputHeaderName,
      this.validatorFieldValue,
      this.inputFormatterData,
      this.validator,
      this.onSaved,
      this.errorText,
      this.onChanged,
      this.textInputAction,
      this.focusNode,
      this.onEditingComplete})
      : super(key: key);

  @override
  _AllInputDesignState createState() => _AllInputDesignState();
}

class _AllInputDesignState extends State<AllInputDesign> {
  // var cf = CommonFunctions();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          (widget.inputHeaderName != null) ? widget.inputHeaderName : '',
          style: labelHintFontStyle,
        ),
        SizedBox(
          height: FsDimens.space8,
        ),
        TextFormField(
          cursorColor: Colors.grey,
          onSaved: widget.onSaved,
          textInputAction: widget.textInputAction,
          onEditingComplete: widget.onEditingComplete,
          focusNode: widget.focusNode,
          style: TextStyle(
            color: Color(0xFF1F2D3D),
            fontSize: 18,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.8,
          ),
          keyboardType: widget.keyBoardType,
          validator: (val) => widget.validator(val, widget.validatorFieldValue),
          controller: widget.controller,
          enabled: widget.enabled,
          inputFormatters: widget.inputFormatterData,
          obscureText:
              widget.obsecureText != null ? widget.obsecureText : false,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
              filled: true,
              fillColor: Color(0XFFFFFFFF),
              hintText: (widget.hintText != null) ? widget.hintText : '',
              hintStyle: TextStyle(
                  color: Colors.black54,
                  fontSize: 18,
                  fontFamily: sourceSansPro,
                  fontWeight: FontWeight.w800),

              // suffixIcon: Padding(
              //     padding: const EdgeInsets.only(right: 10.0),
              //     child:
              //         widget.suffixIcon != null ? widget.suffixIcon : Text('')),
              // prefixText: (widget.prefixText != null) ? widget.prefixText : '',
              // prefixStyle: widget.prefixStyle,
              errorText: widget.errorText,
              errorStyle: TextStyle(
                  /*fontFamily: monsterdRegular*/),
              contentPadding: const EdgeInsets.only(left: 8, top: 20),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.black54, width: 0.2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.black54, width: 0.2),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.black54, width: 0.2))),
        ),
      ],
    );
  }
}

class AllInputDesignProfile extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final Set<void> Function() onEditingComplete;
  final controller;
  final textInputAction;
  final focusNode;
  final prefixText;
  final enabled;
  final hintText;
  final inputHeaderName;
  final prefixStyle;
  final validator;
  final errorText;
  final keyBoardType;
  final validatorFieldValue;
  final List<TextInputFormatter> inputFormatterData;
  final FormFieldSetter<String> onSaved;
  final obsecureText;
  final suffixIcon;
  final prefixIcon;

  const AllInputDesignProfile(
      {Key key,
      this.controller,
      this.enabled,
      this.prefixText,
      this.prefixStyle,
      this.keyBoardType,
      this.obsecureText,
      this.suffixIcon,
      this.prefixIcon,
      this.hintText,
      this.inputHeaderName,
      this.validatorFieldValue,
      this.inputFormatterData,
      this.validator,
      this.onSaved,
      this.errorText,
      this.onChanged,
      this.textInputAction,
      this.focusNode,
      this.onEditingComplete})
      : super(key: key);

  @override
  _AllInputDesignProfileState createState() => _AllInputDesignProfileState();
}

class _AllInputDesignProfileState extends State<AllInputDesignProfile> {
  // var cf = CommonFunctions();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          (widget.inputHeaderName != null) ? widget.inputHeaderName : '',
          style: labelHintFontStyle,
        ),
        SizedBox(
          height: FsDimens.space8,
        ),
        TextFormField(
          cursorColor: Colors.grey,
          onSaved: widget.onSaved,
          textInputAction: widget.textInputAction,
          onEditingComplete: widget.onEditingComplete,
          focusNode: widget.focusNode,
          style: TextStyle(
              color: Color(0xFF1F2D3D),
              fontSize: 18,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.8,
              fontFamily: sourceSansPro),
          keyboardType: widget.keyBoardType,
          validator: (val) => widget.validator(val, widget.validatorFieldValue),
          controller: widget.controller,
          enabled: widget.enabled,
          inputFormatters: widget.inputFormatterData,
          obscureText:
              widget.obsecureText != null ? widget.obsecureText : false,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
              filled: true,
              fillColor: Color(0XFFFFFFFF),
              hintText: (widget.hintText != null) ? widget.hintText : '',
              hintStyle: TextStyle(
                  color: Colors.black45,
                  fontSize: 18,
                  // fontFamily: sansSemiBold,
                  fontWeight: FontWeight.w800),
              // suffixIcon: Padding(
              //     padding: const EdgeInsets.only(right: 10.0),
              //     child:
              //         widget.suffixIcon != null ? widget.suffixIcon : Text('')),
              // prefixText: (widget.prefixText != null) ? widget.prefixText : '',
              // prefixStyle: widget.prefixStyle,
              errorText: widget.errorText,
              errorStyle: TextStyle(
                  /*fontFamily: monsterdRegular*/
                  ),
              contentPadding: const EdgeInsets.only(left: 8, top: 20),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.black54, width: 0.2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide(color: Colors.black54, width: 0.2),
              ),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: Colors.black54, width: 0.2))),
        ),
      ],
    );
  }
}
