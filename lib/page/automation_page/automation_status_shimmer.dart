import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';

class AutomationStatusShimmer extends StatelessWidget {
  const AutomationStatusShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        // Gunakan tinggi dan dekorasi yang SAMA dengan konten asli
        height: SizeDevice.getHeight(context) * 0.06,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: whiteColor, // Warna dasar placeholder
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Placeholder untuk teks
            Container(
              width: 150,
              height: 16,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const Gap(20),
            // Placeholder untuk lingkaran status
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
