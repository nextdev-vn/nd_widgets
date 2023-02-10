import 'package:flutter/material.dart';

import '../../constants/colors/nd_social_color.dart';
import '../../constants/shape/nd_button_shape.dart';
import '../../constants/shape/nd_icon_button_shape.dart';
import '../../constants/size/nd_size.dart';
import '../../constants/types/nd_button_type.dart';
import '../../constants/types/nd_social_type.dart';
import 'nd_button.dart';
import 'nd_icon_button.dart';

class NDSocialButton extends StatelessWidget {
  const NDSocialButton({
    Key? key,
    required this.onPressed,
    required this.type,
    required this.buttonType,
    this.elevation = 0.0,
    this.shape = NDButtonShape.standard,
    this.size = NDSize.MEDIUM,
    this.blockButton,
    this.fullWidthButton,
    this.onLongPress,
  }) : super(key: key);

  final VoidCallback? onPressed;

  final double elevation;

  bool get enabled => onPressed != null;

  final NDButtonShape shape;

  final double size;

  final NDSocialType type;

  final NDSocialButtonType buttonType;

  final bool? blockButton;

  final bool? fullWidthButton;

  final VoidCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    Widget? icon;
    String? text;
    Color? color;
    final double imageSize = (size == NDSize.LARGE)
        ? 30
        : (size == NDSize.MEDIUM)
            ? 25
            : 20;
    switch (type) {
      case NDSocialType.whatsapp:
        icon = Image.asset(
          'icons/whatsapp.png',
          height: imageSize,
          width: imageSize,
          color: (buttonType == NDSocialButtonType.outline ||
                  buttonType == NDSocialButtonType.outline2x ||
                  buttonType == NDSocialButtonType.transparent)
              ? NDSocialColors.WHATSAPP
              : Colors.white,
        );
        text = 'Whatsapp';
        color = NDSocialColors.WHATSAPP;
        break;
      case NDSocialType.facebook:
        icon = Image.asset(
          'icons/facebook.png',
          height: imageSize,
          width: imageSize,
          color: (buttonType == NDSocialButtonType.outline ||
                  buttonType == NDSocialButtonType.outline2x ||
                  buttonType == NDSocialButtonType.transparent)
              ? NDSocialColors.FACEBOOK
              : Colors.white,
        );
        text = 'Facebook';
        color = NDSocialColors.FACEBOOK;
        break;
      case NDSocialType.twitter:
        icon = Image.asset(
          'icons/twitter.png',
          height: imageSize,
          width: imageSize,
          color: (buttonType == NDSocialButtonType.outline ||
                  buttonType == NDSocialButtonType.outline2x ||
                  buttonType == NDSocialButtonType.transparent)
              ? NDSocialColors.TWITTER
              : Colors.white,
        );
        text = 'Twitter';
        color = NDSocialColors.TWITTER;
        break;
      case NDSocialType.google:
        icon = Image.asset(
          'icons/google.png',
          height: imageSize,
          width: imageSize,
          color: (buttonType == NDSocialButtonType.outline ||
                  buttonType == NDSocialButtonType.outline2x ||
                  buttonType == NDSocialButtonType.transparent)
              ? NDSocialColors.GOOGLE
              : Colors.white,
        );
        text = 'Google';
        color = NDSocialColors.GOOGLE;
        break;
      case NDSocialType.youtube:
        icon = Image.asset(
          'icons/youtube.png',
          height: imageSize,
          width: imageSize,
          color: (buttonType == NDSocialButtonType.outline ||
                  buttonType == NDSocialButtonType.outline2x ||
                  buttonType == NDSocialButtonType.transparent)
              ? NDSocialColors.YOUTUBE
              : Colors.white,
        );
        text = 'Youtube';
        color = NDSocialColors.YOUTUBE;
        break;
      case NDSocialType.dribble:
        icon = Image.asset(
          'icons/dribble.png',
          height: imageSize,
          width: imageSize,
          color: (buttonType == NDSocialButtonType.outline ||
                  buttonType == NDSocialButtonType.outline2x ||
                  buttonType == NDSocialButtonType.transparent)
              ? NDSocialColors.DRIBBLE
              : Colors.white,
        );
        text = 'Dribble';
        color = NDSocialColors.DRIBBLE;
        break;
      case NDSocialType.linkedin:
        icon = Image.asset(
          'icons/linkedin.png',
          height: imageSize,
          width: imageSize,
          color: (buttonType == NDSocialButtonType.outline ||
                  buttonType == NDSocialButtonType.outline2x ||
                  buttonType == NDSocialButtonType.transparent)
              ? NDSocialColors.LINKEDIN
              : Colors.white,
        );
        text = 'Linkedin';
        color = NDSocialColors.LINKEDIN;
        break;
      case NDSocialType.pinterest:
        icon = Image.asset(
          'icons/pinterest.png',
          height: imageSize,
          width: imageSize,
          color: (buttonType == NDSocialButtonType.outline ||
                  buttonType == NDSocialButtonType.outline2x ||
                  buttonType == NDSocialButtonType.transparent)
              ? NDSocialColors.PININTEREST
              : Colors.white,
        );
        text = 'Pinterest';
        color = NDSocialColors.PININTEREST;
        break;
      case NDSocialType.slack:
        icon = Image.asset(
          'icons/slack.png',
          height: imageSize,
          width: imageSize,
          color: (buttonType == NDSocialButtonType.outline ||
                  buttonType == NDSocialButtonType.outline2x ||
                  buttonType == NDSocialButtonType.transparent)
              ? NDSocialColors.SLACK
              : Colors.white,
        );
        text = 'Slack';
        color = NDSocialColors.SLACK;
        break;
      case NDSocialType.line:
        icon = Image.asset(
          'icons/line.png',
          height: imageSize,
          width: imageSize,
          color: (buttonType == NDSocialButtonType.outline ||
                  buttonType == NDSocialButtonType.outline2x ||
                  buttonType == NDSocialButtonType.transparent)
              ? NDSocialColors.LINE
              : Colors.white,
        );
        text = 'Line';
        color = NDSocialColors.LINE;
        break;
      case NDSocialType.wechat:
        icon = Image.asset(
          'icons/wechat.png',
          height: imageSize,
          width: imageSize,
          color: (buttonType == NDSocialButtonType.outline ||
                  buttonType == NDSocialButtonType.outline2x ||
                  buttonType == NDSocialButtonType.transparent)
              ? NDSocialColors.WECHAT
              : Colors.white,
        );
        text = 'WeChat';
        color = NDSocialColors.WECHAT;
        break;
    }

    switch (buttonType) {
      case NDSocialButtonType.solid:
        return socialButtonSolid(icon, text, color);
      case NDSocialButtonType.outline:
        return socialButtonOutlined(icon, text, color);
      case NDSocialButtonType.outline2x:
        return socialButtonOutlined2x(icon, text, color);
      case NDSocialButtonType.transparent:
        return socialButtonTransparent(icon, text, color);
      case NDSocialButtonType.icon:
        return socialButtonIcon(icon, color);
    }
  }

  Widget socialButtonSolid(Widget? icon, String? text, Color color) => NDButton(
        onPressed: onPressed,
        elevation: elevation,
        shape: shape,
        size: size,
        text: text,
        blockButton: blockButton,
        fullWidthButton: fullWidthButton,
        onLongPress: onLongPress,
        icon: icon,
        color: color,
      );

  Widget socialButtonOutlined(Widget? icon, String? text, Color color) =>
      NDButton(
        onPressed: () {},
        type: NDButtonType.outline,
        shape: shape,
        size: size,
        text: text,
        blockButton: blockButton,
        fullWidthButton: fullWidthButton,
        onLongPress: onLongPress,
        icon: icon,
        color: color,
        boxShadow: const BoxShadow(
          color: Colors.black,
          blurRadius: 10,
          spreadRadius: 7,
          offset: Offset(
            5,
            5,
          ),
        ),
      );

  Widget socialButtonOutlined2x(Widget icon, String text, Color color) =>
      NDButton(
        onPressed: () {},
        type: NDButtonType.outline2x,
        shape: shape,
        size: size,
        text: text,
        blockButton: blockButton,
        fullWidthButton: fullWidthButton,
        onLongPress: onLongPress,
        icon: icon,
        color: color,
        boxShadow: const BoxShadow(
          color: Colors.black,
          blurRadius: 10,
          spreadRadius: 7,
          offset: Offset(
            5,
            5,
          ),
        ),
      );

  Widget socialButtonTransparent(Widget icon, String text, Color color) =>
      NDButton(
        onPressed: () {},
        type: NDButtonType.transparent,
        shape: shape,
        size: size,
        text: text,
        blockButton: blockButton,
        fullWidthButton: fullWidthButton,
        onLongPress: onLongPress,
        icon: icon,
        color: color,
        boxShadow: const BoxShadow(
          color: Colors.black,
          blurRadius: 10,
          spreadRadius: 7,
          offset: Offset(
            5,
            5,
          ),
        ),
      );

  Widget socialButtonIcon(Widget? icon, Color color) => Material(
        shape: RoundedRectangleBorder(
          borderRadius: shape == NDButtonShape.pills
              ? BorderRadius.circular(50)
              : BorderRadius.circular(0),
        ),
        elevation: elevation,
        child: NDIconButton(
          onPressed: () {},
          icon: icon!,
          color: color,
          size: size,
          type: NDButtonType.solid,
          shape: shape == NDButtonShape.standard
              ? NDIconButtonShape.standard
              : shape == NDButtonShape.pills
                  ? NDIconButtonShape.circle
                  : NDIconButtonShape.square,
        ),
      );
}
