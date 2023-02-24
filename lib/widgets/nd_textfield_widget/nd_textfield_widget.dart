import 'package:flutter/material.dart';

class NdTextFieldWidgetColors{
  static const Color borderColor = Color(0xFFDDDDDD);
}

class NdTextFieldWidget extends StatefulWidget {
  const NdTextFieldWidget({
    Key? key,
    this.style,
    this.initialValue,
    this.labelText = '',
    this.maxLines = 1,
    this.onChanged,
    this.keyboardType,
    this.onTap,
    this.isPasswordField = false,
    this.isRequiredField = false,
    this.error,
    this.prefixIcon,
    this.hintText,
    this.prefixImage,
    this.noneBorder,
    this.borderRadius,
    this.borderWidth = 1,
    this.borderColor,
    this.contentPadding,
    this.fontSize,
    this.autoFocus,
    this.txtController,
    this.readonly = false,
    this.noneBorderFocus = false,
    this.floatingLabelBehavior,
    this.validator,
  }) : super(key: key);

  final TextStyle? style;
  final String? initialValue;
  final String labelText;
  final int maxLines;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final TextInputType? keyboardType;
  final bool readonly;
  final bool isPasswordField;
  final bool isRequiredField;
  final String? error;
  final IconData? prefixIcon;
  final String? prefixImage;
  final String? hintText;
  final bool? noneBorder;
  final bool? noneBorderFocus;
  final double borderWidth;
  final Color? borderColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final double? fontSize;
  final bool? autoFocus;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final TextEditingController? txtController;
  final String? Function(String?)? validator;

  @override
  State<NdTextFieldWidget> createState() => _NdTextFieldWidgetState();
}

class _NdTextFieldWidgetState extends State<NdTextFieldWidget> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = true;
  }

  _buildBorder(BuildContext context) {
    return widget.noneBorder == null
        ? OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
      borderSide:
      BorderSide(color: widget.borderColor ?? NdTextFieldWidgetColors.borderColor, width: widget.borderWidth),
    )
        : null;
  }

  _buildBorderFocused(BuildContext context) {
    return widget.noneBorder == null
        ? OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
      borderSide: BorderSide(
          color: (widget.noneBorderFocus == true)
              ? NdTextFieldWidgetColors.borderColor
              : Theme.of(context).primaryColor, width: widget.borderWidth),
    )
        : null;
  }

  _buildErrorBorder(BuildContext context) {
    return widget.noneBorder == null
        ? OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
      borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error, width: widget.borderWidth
      ),
    )
        : null;
  }

  _buildFocusedErrorBorder(BuildContext context) {
    return widget.noneBorder == null
        ? OutlineInputBorder(
      borderRadius: BorderRadius.circular(widget.borderRadius ?? 0),
      borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error, width: widget.borderWidth
      ),
    )
        : null;
  }

  _buildPrefixIcon() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 10),
      child: Icon(
        widget.prefixIcon,
        color: const Color(0xFF9098B1),
        size: 28,
      ),
    );
  }

  _buildPrefixImage() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 10),
      child: Image.asset(
        widget.prefixImage!,
        width: 24,
        height: 24,
      ),
    );
  }

  _buildShowPassword() {
    return IconButton(
      icon: Icon(
        _passwordVisible ? Icons.visibility : Icons.visibility_off,
        color: Colors.grey.shade500,
      ),
      onPressed: () {
        setState(() {
          _passwordVisible = !_passwordVisible;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialValue,
      style: widget.style ?? TextStyle(fontSize: widget.fontSize ?? 14),
      keyboardType: widget.keyboardType ?? TextInputType.text,
      readOnly: widget.readonly,
      decoration: InputDecoration(
        hintText: widget.hintText,
        isDense: true,
        contentPadding: widget.contentPadding ?? const EdgeInsets.symmetric(
            vertical: 17, horizontal: 15),
        floatingLabelBehavior:
        widget.floatingLabelBehavior ?? FloatingLabelBehavior.never,
        labelText:
        widget.isRequiredField ? '${widget.labelText}*' : widget.labelText,
        labelStyle: const TextStyle(color: Color(0xFF9098B1)),
        prefixIcon: widget.prefixIcon != null
            ? _buildPrefixIcon()
            : widget.prefixImage != null
            ? _buildPrefixImage()
            : null,
        suffixIcon:
        widget.isPasswordField == true ? _buildShowPassword() : null,
        errorText: widget.error,
        enabledBorder: _buildBorder(context),
        focusedBorder: _buildBorderFocused(context),
        errorBorder: _buildErrorBorder(context),
        focusedErrorBorder: _buildFocusedErrorBorder(context),
      ),
      obscureText: widget.isPasswordField == true ? _passwordVisible : false,
      maxLines: widget.maxLines,
      onChanged: widget.onChanged,
      onTap: widget.onTap,
      autofocus: widget.autoFocus ?? false,
      controller: widget.txtController,
      validator: widget.validator,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (widget.txtController != null) {
      widget.txtController!.dispose();
    }
  }
}
