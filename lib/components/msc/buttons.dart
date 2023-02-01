import 'package:flutter/material.dart';

typedef Ontapcallback = void Function();

class EvCustomBtn extends StatelessWidget {
  const EvCustomBtn(
      {Key? key,
      this.ontap,
      this.title = 'Ok',
      this.borderColor = Colors.transparent,
      this.bgColor,
      this.textColor = Colors.white,
      this.btnWidth = 70,
      this.btnHeight = 35,
      this.borderRadius = 8,
      this.textSize = 15.0,
      this.loading = false})
      : super(key: key);
  final Ontapcallback? ontap;
  final String title;
  final Color borderColor;
  final Color textColor;
  final Color? bgColor;
  final double textSize;
  final double btnWidth;
  final double btnHeight, borderRadius;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return AnimatedContainer(
      height: btnHeight,
      width: btnWidth,
      decoration: BoxDecoration(
        color: bgColor ?? theme.primaryColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      duration: const Duration(milliseconds: 420),
      child: RawMaterialButton(
        onPressed: ontap ?? () {},
        highlightColor: Colors.blueGrey.withOpacity(0.2),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.button?.copyWith(
                fontSize: textSize,
                color: bgColor == Colors.transparent
                    ? theme.primaryColor
                    : textColor),
          ),
        ),
      ),
    );
  }
}
