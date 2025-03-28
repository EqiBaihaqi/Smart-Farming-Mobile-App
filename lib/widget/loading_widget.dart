import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';

class LoadingWidget {
  // Show dialog
  static void showLoadingDialog() {
    Get.dialog(
      PopScope(
        canPop: false, // Mencegah tombol back untuk menutup loading
        child: AlertDialog(
          backgroundColor: Colors.transparent,
          content: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(color: primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false, // Prevents dismissing by tapping outside
      barrierColor: blackColor.withValues(alpha: 0.5),
    );
  }

  // Hide loading
  static void hideLoadingDialog() {
    if (Get.isDialogOpen!) {
      Get.back(); // Closes the dialog
    }
  }
}
