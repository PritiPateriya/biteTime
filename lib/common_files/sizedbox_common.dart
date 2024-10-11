import 'package:flutter/material.dart';

class CommonSized extends StatelessWidget {
  final double height;
  CommonSized(this.height);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class CommonWidth extends StatelessWidget {
  final double width;
  CommonWidth(this.width);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
