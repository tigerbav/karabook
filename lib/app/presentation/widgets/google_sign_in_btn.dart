// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:karabookapp/app/presentation/logic/settings/settings_cubit.dart';
// import 'package:karabookapp/common/app_colors.dart';
// import 'package:karabookapp/common/app_resources.dart';
// import 'package:karabookapp/generated/locale_keys.g.dart';
//
// class GoogleSignInButton extends StatelessWidget {
//   const GoogleSignInButton({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         border: Border.all(
//           color: AppColors.shared.black,
//           width: 1.sp,
//         ),
//         borderRadius: BorderRadius.all(Radius.circular(6.sp)),
//       ),
//       padding: EdgeInsets.symmetric(vertical: 8.5.sp, horizontal: 8.sp),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           SvgPicture.asset(
//             AppResources.google,
//             width: 20.sp,
//             height: 20.sp,
//           ),
//           SizedBox(width: 4.sp),
//           GestureDetector(
//             onTap: context.read<SettingsCubit>().googleSignIn,
//             child: Text(
//               LocaleKeys.sign_in_with_google.tr(),
//               style: TextStyle(
//                 fontSize: 19,
//                 color: AppColors.shared.black,
//                 fontFamily: '.SF Pro Text',
//                 letterSpacing: -0.41,
//                 inherit: false,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/app/presentation/logic/settings/settings_cubit.dart';
import 'package:karabookapp/common/app_resources.dart';

const _appleIconSizeScale = 28 / 44;

class GoogleSignInButton extends StatelessWidget {
  const GoogleSignInButton({
    super.key,
    this.text = 'Sign in with Google',
    this.height = 44,
    this.style = SignInWithAppleGoogleStyle.whiteOutlined,
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.iconAlignment = IconAlignment.center,
  });

  final String text;
  final double height;
  final SignInWithAppleGoogleStyle style;
  final BorderRadius borderRadius;
  final IconAlignment iconAlignment;

  Color get _backgroundColor {
    switch (style) {
      case SignInWithAppleGoogleStyle.black:
        return Colors.black;
      case SignInWithAppleGoogleStyle.white:
      case SignInWithAppleGoogleStyle.whiteOutlined:
        return Colors.white;
    }
  }

  Color get _contrastColor {
    switch (style) {
      case SignInWithAppleGoogleStyle.black:
        return Colors.white;
      case SignInWithAppleGoogleStyle.white:
      case SignInWithAppleGoogleStyle.whiteOutlined:
        return Colors.black;
    }
  }

  Decoration? get _decoration {
    switch (style) {
      case SignInWithAppleGoogleStyle.black:
      case SignInWithAppleGoogleStyle.white:
        return null;

      case SignInWithAppleGoogleStyle.whiteOutlined:
        return BoxDecoration(
          border: Border.all(width: 1, color: _contrastColor),
          borderRadius: borderRadius,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = height * 0.43;

    final textWidget = Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        inherit: false,
        fontSize: fontSize,
        color: _contrastColor,
        fontFamily: '.SF Pro Text',
        letterSpacing: -0.41,
      ),
    );

    final appleIcon = Container(
      width: _appleIconSizeScale * height,
      height: _appleIconSizeScale * height + 2,
      padding: EdgeInsets.only(
        bottom: (4 / 44) * height,
      ),
      child: Center(
        child: SizedBox(
          width: fontSize * (25 / 31),
          height: fontSize,
          child: SvgPicture.asset(
            AppResources.google,
            width: 20.sp,
            height: 20.sp,
          ),
        ),
      ),
    );

    var children = <Widget>[];

    switch (iconAlignment) {
      case IconAlignment.center:
        children = [
          appleIcon,
          Flexible(
            child: textWidget,
          ),
        ];
        break;
      case IconAlignment.left:
        children = [
          appleIcon,
          Expanded(
            child: textWidget,
          ),
          SizedBox(
            width: _appleIconSizeScale * height,
          ),
        ];
        break;
    }

    return SizedBox(
      height: height,
      child: SizedBox.expand(
        child: CupertinoButton(
          borderRadius: borderRadius,
          padding: EdgeInsets.zero,
          color: _backgroundColor,
          onPressed: context.read<SettingsCubit>().googleSignIn,
          child: Container(
            decoration: _decoration,
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}

enum SignInWithAppleGoogleStyle {
  black,
  white,
  whiteOutlined,
}

enum IconAlignment {
  center,
  left,
}
