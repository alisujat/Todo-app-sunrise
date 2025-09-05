import 'package:flutter/material.dart';

class Height extends StatelessWidget {
  final bool isWidth;
  final double width;
  final double height;
  const Height({super.key, this.width = 16, this.height = 16,  this.isWidth = false, });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: isWidth ? width : 0,
    );
  }
}
