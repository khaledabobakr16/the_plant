import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    this.margin = const EdgeInsets.symmetric(horizontal: 0),
    this.onpressed,
    this.child,
    this.color,
  });
  final Widget? child;
  final void Function()? onpressed;
  final EdgeInsetsGeometry margin;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: double.infinity,
      margin: margin,
      child: MaterialButton(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onPressed: onpressed,
        child: child,
      ),
    );
  }
}
