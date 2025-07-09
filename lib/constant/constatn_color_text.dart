import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Constant color
Color primaryColor = const Color(0XFF4CAF50);
Color secondaryColor = const Color(0XFFFABE00);
Color aquaGreenColor = const Color(0xff00E676);
Color blueColor = const Color(0XFF2DC5F5);
Color blueGrayColor = const Color(0xff546E7A);
Color darkBlueColor = const Color(0xff0D47A1);
Color indigoColor = const Color(0xff1A237E);
Color softBlue = const Color(0xff007BFF);
Color redColor = const Color(0XFFD04F48);
Color whiteColor = Colors.white;
Color blackColor = Colors.black;
Color greenColor = Colors.green;
Color backgroundColor = const Color(0XFFF6F8FB);
Color greyColor = const Color(0XFF9EABB1);
Color lightGreyColor = const Color(0xffBDBDBD);
Color emeraldGreenColor = const Color(0xFF2ECC71);
Color tealGreenColor = const Color(0xff0A3832);
Color foundationGreyColor = Color(0xff8c8c8c);
Color foundationBlueColor = Color(0xff539df3);

// Constant TextStyle
TextStyle defaultTextStyle = GoogleFonts.poppins();
TextStyle greenTextStyle = GoogleFonts.poppins(color: primaryColor);
TextStyle blackTextStyle = GoogleFonts.poppins(color: blackColor);
TextStyle blueTextStyle = GoogleFonts.poppins(color: blueColor);
TextStyle redTextStyle = GoogleFonts.poppins(color: redColor);
TextStyle whiteTextStyle = GoogleFonts.poppins(color: whiteColor);
TextStyle greyTextStyle = GoogleFonts.poppins(color: greyColor);
TextStyle orangeTextStyle = GoogleFonts.poppins(color: secondaryColor);
TextStyle tealGreenTextstyle = GoogleFonts.poppins(color: tealGreenColor);

class SizeDevice {
  static double getHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }
}
