import 'package:salesman/app/helper/test_size_helper.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.title,
    this.wrapWords = true,
    this.fontSize = 14,
    this.overflow = TextOverflow.ellipsis,
    this.style,
    this.maxLine = 1,
    this.textColor,
  });

  final String title;
  final bool wrapWords;
  final double fontSize;
  final TextOverflow overflow;
  final TextStyle? style;
  final Color? textColor;
  final int maxLine;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      softWrap: wrapWords,
      maxLines: maxLine,
      overflow: overflow,
      style: style ??
          Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: getFontSize(context, fontSize: fontSize),
              color: Theme.of(context).colorScheme.onPrimary),
    );
  }
}
