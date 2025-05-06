import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smart_farm/constant/constatn_color_text.dart';

class ProfileInformasiAkunDetail extends StatelessWidget {
  const ProfileInformasiAkunDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Akun'),
        toolbarHeight: SizeDevice.getHeight(context) * 0.07,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(15),
          Divider(height: 3, color: greyColor),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Username : Baihaqi',
              style: defaultTextStyle.copyWith(fontSize: 20),
            ),
          ),
          Divider(height: 3, color: greyColor),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Fullname : Al Akbar Baihaqi',
              style: defaultTextStyle.copyWith(fontSize: 20),
            ),
          ),
          Divider(height: 3, color: greyColor),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Email : baihaqi08.aa@gmail.com',
              style: defaultTextStyle.copyWith(fontSize: 20),
            ),
          ),
          Divider(height: 3, color: greyColor),
        ],
      ),
    );
  }
}
