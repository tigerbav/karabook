import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/common/widgets/arrow_back.dart';
import 'package:karabookapp/common/widgets/images_grid.dart';
import 'package:karabookapp/common/widgets/primary_button.dart';
import 'package:karabookapp/pages/library/data/datasources/library_datasource.dart';
import 'package:karabookapp/pages/library/domain/repositories/library_repository.dart';
import 'package:karabookapp/pages/library/presentation/logic/vip/vip_cubit.dart';

// @RoutePage()
// class VipScreen extends StatelessWidget {
//   const VipScreen({
//     super.key,
//     required this.pack,
//   });
//
//   final Pack pack;
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (ctx) => VipCubit(
//         repository: LibraryRepository(LibraryDataSource()),
//         pack: pack,
//       ),
//       child: const _VipScreen(),
//     );
//   }
// }
//
// class _VipScreen extends StatelessWidget {
//   const _VipScreen();
//
//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<VipCubit>();
//
//     return Scaffold(
//       appBar: AppBar(
//         leading: const ArrowBack(),
//         scrolledUnderElevation: 0,
//       ),
//       body: SafeArea(
//         child: ListView(
//           children: [
//             Container(
//               width: double.infinity,
//               padding: EdgeInsets.symmetric(horizontal: 20.sp),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.all(Radius.circular(16.sp)),
//                 child: Image.memory(
//                   const Base64Decoder().convert(cubit.pack.packIcon),
//                   fit: BoxFit.cover,
//                   gaplessPlayback: true,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20.sp),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.sp),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: Text(
//                       cubit.pack.packName,
//                       style: AppStyles.shared.packTitles,
//                     ),
//                   ),
//                   PrimaryButton(
//                     text: '\$39.9',
//                     action: () {},
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20.sp),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.sp),
//               child: Text(
//                 cubit.pack.packDescription,
//                 style: AppStyles.shared.packDescription,
//               ),
//             ),
//             SizedBox(height: 20.sp),
//             BlocBuilder<VipCubit, VipState>(
//               buildWhen: (p, c) => p.images != c.images,
//               builder: (context, state) {
//                 return ImagesGrid(state.images);
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
