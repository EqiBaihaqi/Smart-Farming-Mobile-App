import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';

class ControlActuatorCard extends StatelessWidget {
  final String title;
  final String assetIcon;
  final bool boolVariable;
  final ChangeCallback<bool> onChanged;

  const ControlActuatorCard({
    super.key,
    required this.title,
    required this.assetIcon,
    required this.boolVariable,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeDevice.getHeight(context) * 0.3,
      width: SizeDevice.getWidth(context) * 0.45,
      child: Card(
        color: whiteColor,
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: defaultTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(assetIcon)),
                ),
              ),
              AnimatedToggleSwitch<bool>.dual(
                current: boolVariable,
                first: false,
                second: true,
                onChanged: onChanged,
                height: 32,
                spacing: 0,
                style: ToggleStyle(indicatorColor: foundationBlueColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
