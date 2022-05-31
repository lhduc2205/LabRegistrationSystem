import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lab_registration_management/app/core/value/constants/app_constants.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

class AppTheme {
  static ThemeData basic(BuildContext context) => ThemeData(
        // primaryColorDark: kFontColorPallets[0],
        primaryColorDark: kPrimary,
        // primaryColor: const Color.fromRGBO(128, 109, 255, 1),
        // primaryColor: kFontColorPallets[0],
        primaryColor: kPrimary,
        primaryColorLight: const Color.fromRGBO(159, 84, 252, 1),
        brightness: Brightness.light,
        primaryColorBrightness: Brightness.light,
        primarySwatch: Colors.indigo,
        textTheme:
            GoogleFonts.openSansTextTheme(Theme.of(context).textTheme).apply(
          bodyColor: kFontColorPallets[1],
        ),
        iconTheme: IconThemeData(color: kFontColorPallets[2]),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
                  // primary: const Color.fromRGBO(128, 109, 255, 1),
                  primary: kPrimary)
              .merge(
            ButtonStyle(
              elevation: MaterialStateProperty.all(0),
            ),
          ),
        ),
        // canvasColor: const Color.fromRGBO(31, 29, 44, 1),
        canvasColor: kBgColorPallets[0],
        scaffoldBackgroundColor: kScaffoldColor,
      );
}

TextStyle get headingStyle {
  return GoogleFonts.openSans(
      textStyle: TextStyle(
          fontSize: 25,
          color: kFontColorPallets[0],
          fontWeight: FontWeight.bold));
}

TextStyle get headingStyle2 {
  return GoogleFonts.roboto(
      textStyle: TextStyle(
          fontSize: 20,
          color: kFontColorPallets[0],
          fontWeight: FontWeight.bold));
}

TextStyle get subHeadingStyle {
  return GoogleFonts.roboto(
    textStyle: TextStyle(
      fontSize: 16,
      color: kFontColorPallets[0],
      // fontWeight: FontWeight.w600,
    ),
  );
}

TextStyle get headerTitleRobotoStyle {
  return GoogleFonts.roboto(
    textStyle: TextStyle(
      fontSize: 15,
      color: kFontColorPallets[0],
      fontWeight: FontWeight.w600,
    ),
  );
}

TextStyle get titleRobotoStyle {
  return GoogleFonts.roboto(
    textStyle: TextStyle(
      fontSize: 18,
      color: kFontColorPallets[0],
      fontWeight: FontWeight.w600,
    ),
  );
}

TextStyle get normalHeadingStyle {
  return GoogleFonts.openSans(
    textStyle: TextStyle(
      fontSize: 14,
      color: kFontColorPallets[0],
      fontWeight: FontWeight.w600,
    ),
  );
}

TextStyle get normalStyle {
  return GoogleFonts.roboto(
    textStyle: TextStyle(
      fontSize: 14,
      color: kFontColorPallets[0],
    ),
  );
}

TextStyle get nameAppStyle {
  return GoogleFonts.aclonica(
      textStyle: TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.bold,
    color: kFontColorPallets[0],
  ));
}

TextStyle get errorStyle {
  return GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 16,
      color: kRed,
    ),
  );
}

TextStyle get successStyle {
  return GoogleFonts.roboto(
    textStyle: const TextStyle(
      fontSize: 16,
      color: Colors.green,
    ),
  );
}

Style addHeading1(Workbook workbook) {
  Style heading1 = workbook.styles.add('myHeading1');
  heading1.fontSize = 14;
  heading1.fontName = 'Times New Roman';
  heading1.bold = true;
  heading1.fontColor = '#000000';
  heading1.hAlign = HAlignType.center;
  return heading1;
}

Style addHeading2(Workbook workbook) {
  Style heading2 = workbook.styles.add('myHeading2');
  heading2.fontSize = 13;
  heading2.fontName = 'Times New Roman';
  heading2.bold = true;
  heading2.fontColor = '#000000';
  return heading2;
}

Style addGlobalStyle(Workbook workbook) {
  Style globalStyle = workbook.styles.add('globalStyle');
  globalStyle.fontSize = 13;
  globalStyle.fontName = 'Times New Roman';
  globalStyle.fontColor = '#000000';
  return globalStyle;
}

Style addBlueFontLabel(Workbook workbook) {
  Style blueFontLabel = workbook.styles.add('blueFontLabel');
  blueFontLabel.fontSize = 13;
  blueFontLabel.fontName = 'Times New Roman';
  blueFontLabel.bold = true;
  blueFontLabel.fontColor = '#000080';
  blueFontLabel.fontColorRgb = const Color.fromRGBO(0, 0, 128, 1);
  blueFontLabel.hAlign = HAlignType.center;
  blueFontLabel.vAlign = VAlignType.top;
  blueFontLabel.wrapText = true;
  return blueFontLabel;
}

Style addBlackFontLabel(Workbook workbook) {
  Style blackFontLabel = workbook.styles.add('blackFontLabel');
  blackFontLabel.fontSize = 13;
  blackFontLabel.fontName = 'Times New Roman';
  blackFontLabel.bold = true;
  blackFontLabel.fontColor = '#000000';
  blackFontLabel.hAlign = HAlignType.center;
  blackFontLabel.vAlign = VAlignType.top;
  blackFontLabel.wrapText = true;
  return blackFontLabel;
}

Style addRedFontLabel(Workbook workbook) {
  Style redFontLabel = workbook.styles.add('redFontLabel');
  redFontLabel.fontSize = 13;
  redFontLabel.fontName = 'Times New Roman';
  redFontLabel.bold = true;
  redFontLabel.fontColor = '#ff0000';
  redFontLabel.hAlign = HAlignType.center;
  redFontLabel.vAlign = VAlignType.top;
  redFontLabel.wrapText = true;
  return redFontLabel;
}


// Button Style
ButtonStyle defaultButtonStyle({Color? primaryColor}) {
  return ElevatedButton.styleFrom(
    primary: primaryColor ?? kPrimary,
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 15,
    ),
  );
}
