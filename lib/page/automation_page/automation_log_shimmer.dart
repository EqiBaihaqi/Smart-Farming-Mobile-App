import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AutomationLogShimmer extends StatelessWidget {
  const AutomationLogShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    // Widget helper untuk membuat kotak abu-abu sebagai placeholder
    Widget placeholderBox({double? width, double? height}) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color:
              Colors.white, // Warna ini penting agar shimmer bisa 'menimpa'nya
          borderRadius: BorderRadius.circular(4),
        ),
      );
    }

    // Membuat satu template Card untuk placeholder
    final placeholderCard = Card(
      margin: const EdgeInsets.fromLTRB(2, 0, 2, 16),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                placeholderBox(width: 60, height: 12),
                placeholderBox(width: 90, height: 12),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                placeholderBox(width: 160, height: 20),
                placeholderBox(width: 90, height: 32),
              ],
            ),
          ],
        ),
      ),
    );

    // Widget Shimmer sekarang membungkus Column yang berisi 3 Card placeholder
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      enabled: true,
      child: Column(
        children: [placeholderCard, placeholderCard, placeholderCard],
      ),
    );
  }
}
