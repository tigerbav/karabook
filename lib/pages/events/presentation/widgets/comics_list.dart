import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/pages/events/presentation/logic/comics/comics_cubit.dart';
import 'package:karabookapp/pages/events/presentation/widgets/comics_list_item.dart';
import 'package:karabookapp/services/isar/models/svg_image.dart';

class ComicsList extends StatefulWidget {
  const ComicsList({super.key});

  @override
  State<ComicsList> createState() => _ComicsListState();
}

class _ComicsListState extends State<ComicsList> {
  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox();
    // return BlocBuilder<ComicsCubit, ComicsState>(
    //   // buildWhen: (p, c) => p.comicsPack != c.comicsPack,
    //   builder: (context, state) {
    //     return ListView.separated(
    //       shrinkWrap: true,
    //       itemCount: state.comicsPack.length,
    //       controller: _controller,
    //       physics: const NeverScrollableScrollPhysics(),
    //       separatorBuilder: (_, __) => SizedBox(height: 20.sp),
    //       itemBuilder: (context, index) => _Item(state.comicsPack[index]),
    //     );
    //   },
    // );
  }
}

// class _Item extends StatefulWidget {
//   const _Item(this.imagePack);
//   final List<SvgImage> imagePack;
//
//   @override
//   State<_Item> createState() => _ItemState();
// }
//
// class _ItemState extends State<_Item> {
//   final _controller = ScrollController();
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final imagesPack = widget.imagePack;
//
//     return SizedBox(
//       height: 140.sp,
//       child: Stack(
//         children: [
//           SizedBox(
//             width: double.infinity,
//             child: Image.asset(
//               AppResources.comicsBg,
//               fit: BoxFit.contain,
//             ),
//           ),
//           ListView(
//             controller: _controller,
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             children: [
//               SizedBox(width: 20.sp),
//               Container(
//                 width: 80.sp,
//                 alignment: Alignment.center,
//                 child: Text(
//                   imagesPack.firstOrNull?.subcategories ?? '',
//                   textAlign: TextAlign.center,
//                   style: AppStyles.shared.toast,
//                 ),
//               ),
//               ListView.separated(
//                 itemCount: imagesPack.length,
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 padding: EdgeInsets.all(20.sp),
//                 scrollDirection: Axis.horizontal,
//                 separatorBuilder: (_, __) => SizedBox(width: 16.sp),
//                 itemBuilder: (context, index) {
//                   final isActive = index == 0 ||
//                       (imagesPack[index].complete == 1) ||
//                       imagesPack[index - 1].complete == 1;
//
//                   return ComicsListItem(
//                     image: imagesPack[index],
//                     isActive: isActive,
//                   );
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
