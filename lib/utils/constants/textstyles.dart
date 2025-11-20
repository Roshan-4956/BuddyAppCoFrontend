import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

/// ! all the font size present in the design system have been included there shohuldn't be any other size
/// ! incase of additional text size report to design
extension StyleExt on TextStyle {
  TextStyle get size10 =>
      copyWith(fontSize: 11, overflow: TextOverflow.ellipsis);
  TextStyle get size11 =>
      copyWith(fontSize: 11, overflow: TextOverflow.ellipsis);
  TextStyle get size12 =>
      copyWith(fontSize: 12, overflow: TextOverflow.ellipsis);
  TextStyle get size14 =>
      copyWith(fontSize: 14, overflow: TextOverflow.ellipsis);
  TextStyle get size16 =>
      copyWith(fontSize: 16, overflow: TextOverflow.ellipsis);
  TextStyle get size18 =>
      copyWith(fontSize: 18, overflow: TextOverflow.ellipsis);
  TextStyle get size20 =>
      copyWith(fontSize: 20, overflow: TextOverflow.ellipsis);
  TextStyle get size24 =>
      copyWith(fontSize: 24, overflow: TextOverflow.ellipsis);
  TextStyle get size32 =>
      copyWith(fontSize: 32, overflow: TextOverflow.ellipsis);
  TextStyle get size36 =>
      copyWith(fontSize: 36, overflow: TextOverflow.ellipsis);
  TextStyle get size45 =>
      copyWith(fontSize: 45, overflow: TextOverflow.ellipsis);
  TextStyle get colorWhite =>
      copyWith(color: const Color(0xffffffff), overflow: TextOverflow.ellipsis);
  TextStyle get colorBlack =>
      copyWith(color: const Color(0xff000000), overflow: TextOverflow.ellipsis);
  TextStyle withHeight(double x) => copyWith(height: x);
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);
}

extension AddedColor on TextStyle {
  TextStyle get textFaded =>
      copyWith(color: BrandColors.textFaded, overflow: TextOverflow.ellipsis);
  TextStyle get textThatWhite => copyWith(
    color: BrandColors.textThatWhite,
    overflow: TextOverflow.ellipsis,
  );
}

/// Legend for weight
/// 400 - Regular/Normal
/// 600 - Medium
/// 700 - SemiBold
/// 900 - Bold

final w400 = GoogleFonts.inter(
  fontSize: 11,
  color: BrandColors.textThatWhite,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
);

final w500 = GoogleFonts.inter(
  fontSize: 11,
  color: BrandColors.textThatWhite,
  fontWeight: FontWeight.w500,
  fontStyle: FontStyle.normal,
);

final w600 = GoogleFonts.inter(
  fontSize: 11,
  color: BrandColors.textThatWhite,
  fontWeight: FontWeight.w600,
  fontStyle: FontStyle.normal,
);
final w700 = GoogleFonts.inter(
  fontSize: 11,
  color: BrandColors.textThatWhite,
  fontWeight: FontWeight.w700,
  fontStyle: FontStyle.normal,
);

final w800 = GoogleFonts.inter(
  fontSize: 11,
  color: BrandColors.textThatWhite,
  fontWeight: FontWeight.w800,
  fontStyle: FontStyle.normal,
);
final w900 = GoogleFonts.inter(
  fontSize: 11,
  color: BrandColors.textThatWhite,
  fontWeight: FontWeight.w900,
  fontStyle: FontStyle.normal,
);
