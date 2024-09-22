import 'package:flutter/material.dart';
import 'package:karabookapp/common/app_resources.dart';

class EmptyBanner extends StatelessWidget {
  const EmptyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Image.asset(
        AppResources.bannerImage,
        fit: BoxFit.cover,
      ),
    );
  }
}
