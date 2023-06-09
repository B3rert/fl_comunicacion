import 'package:fl_comunicacion/themes/app_theme.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.raidus,
    this.color = AppTheme.backroundColorSecondary,
    required this.child,
    this.elevation = 2,
    this.borderColor,
    this.borderWidth = 0,
  }) : super(key: key);

  final double width;
  final double height;
  final double raidus;
  final Color? color;
  final double? elevation;
  final Color? borderColor;
  final Widget child;
  final double? borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: height,
      width: width,
      child: Card(
        color: color,
        shape: borderColor == null
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(raidus),
              )
            : RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(raidus),
                side: BorderSide(
                  color: borderColor!,
                  width: borderWidth!,
                ),
              ),
        clipBehavior: Clip.antiAlias,
        elevation: elevation,
        child: child,
      ),
    );
  }
}
