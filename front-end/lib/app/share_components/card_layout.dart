import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';

class CardLayout extends StatelessWidget {
  const CardLayout({
    Key? key,
    required this.title,
    required this.content,
    this.subTitle,
    this.action,
  }) : super(key: key);

  final Widget title;
  final Widget content;
  final String? subTitle;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: kSpacing,
      ),
      decoration: BoxDecoration(
        // color: kBgColorPallets[1].withOpacity(0.7),
        color: kWhite,
        borderRadius: BorderRadius.circular(kBorderRadius),
        border: Border.all(
          color: kDeepBlue.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 10),
          content,
        ],
      ),
    );
  }

  Row _buildHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title,
            const SizedBox(height: 1),
            subTitle != null
                ? Text(
                    subTitle!,
                    style: _subTitleStyle(),
                    maxLines: 2,
                  )
                : const SizedBox(),
          ],
        ),
        action ?? const SizedBox()
      ],
    );
  }

  TextStyle _subTitleStyle() {
    return GoogleFonts.roboto(
      textStyle: TextStyle(
        fontSize: 14,
        fontStyle: FontStyle.italic,
        color: kFontColorPallets[1],
      ),
    );
  }
}
