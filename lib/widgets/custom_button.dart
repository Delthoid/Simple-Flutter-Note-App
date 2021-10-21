import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:notes_app_delthoid/themes/palette.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    Color? color,
    required this.title,
    required this.action,
    required this.icon,
  }) : super(key: key);

  final String title;
  final Function() action;
  final Icon icon;

  static ButtonStyle flatButtonStyle = TextButton.styleFrom(
    primary: Colors.black87,
    backgroundColor: Colors.transparent,
    minimumSize: const Size(88, 42),
    elevation: 0,
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: action,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: icon,
          ),
          Text(title),
        ],
      ),
      style: flatButtonStyle,
    );
  }
}
