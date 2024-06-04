import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomIcon extends StatelessWidget {
  final String assetName;
  final double size;
  final Color color;

  CustomIcon(
      {required this.assetName, this.size = 24.0, this.color = Colors.teal});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetName,
      height: size,
      width: size,
      color: color,
    );
  }
}
