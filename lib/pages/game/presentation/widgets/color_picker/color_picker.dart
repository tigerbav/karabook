import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:karabookapp/pages/game/presentation/widgets/color_picker/color_item.dart';
import 'package:karabookapp/pages/game/presentation/widgets/painter_inherited.dart';
import 'package:karabookapp/services/core/models/color_list_model.dart';
import 'package:karabookapp/services/core/models/svg_models/svg_shape_model.dart';
import 'package:karabookapp/services/core/rewards.dart';

class ColorPicker extends StatefulWidget {
  final Map<Color, List<SvgShapeModel>> sortedShapes;
  final ValueChanged<Color> onColorSelect;
  final AnimationController percentController;
  final Rewards rewards;

  const ColorPicker({
    required this.sortedShapes,
    required this.onColorSelect,
    required this.percentController,
    required this.rewards,
    Key? key,
  }) : super(key: key);

  @override
  ColorPickerState createState() => ColorPickerState();
}

class ColorPickerState extends State<ColorPicker>
    with SingleTickerProviderStateMixin {
  final _listKey = GlobalKey<AnimatedListState>();
  late final _colorList = _calcPaintedColors();
  late final _animatedList = ColorListModel<Color>(
    listKey: _listKey,
    initialItems: _colorList,
    removedItemBuilder: _buildRemovedItem,
  );
  late final _sortedShapes =
      Map<Color, List<SvgShapeModel>>.from(widget.sortedShapes);
  Color selectedColor = Colors.transparent;
  double currentPercent = 0;
  double oldPercent = 0;

  @override
  void initState() {
    // _initPurchaseInfo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Future _initPurchaseInfo() async {
  //   PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
  //
  //   if (!mounted) return;
  //
  //   setState(() {
  //     if (purchaserInfo.entitlements.active.containsKey("remove_ads")) {
  //       _isActive = true;
  //       print(
  //           "ACTIVE BANNER:  ${purchaserInfo.entitlements.active.containsKey("remove_ads")}");
  //     } else {
  //       _isActive = false;
  //       print(
  //           "NONACTIVE BANNER:  ${purchaserInfo.entitlements.active.containsKey("remove_ads")}");
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal[50],
      height: 145.sp,
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 80.sp,
            width: MediaQuery.of(context).size.width,
            child: AnimatedList(
              key: _listKey,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              initialItemCount: _animatedList.length,
              itemBuilder: _buildItem,
            ),
          ),
          SizedBox(
            width: widget.rewards.myBanner.size.width.toDouble(),
            height: widget.rewards.myBanner.size.height.toDouble(),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: AdWidget(ad: widget.rewards.myBanner),
            ),
          )
        ],
      ),
    );
  }

  // Remove the selected item from the list model.
  void remove(Color color) {
    final index = _animatedList.indexOf(color);
    _animatedList.removeAt(index);
    setState(() {
      selectedColor = Colors.transparent;
    });
    if (_animatedList.length == 0) {
      //Если в списке кончились цвета, то вызываем коллбэк об окончании раскраски
      PainterInherited.of(context).onComplete();
    }
  }

  void setPercent(double oldPerc, double perc) {
    setState(() {
      oldPercent = oldPerc;
      currentPercent = perc;
    });
  }

  //Составляем список незаврешенных цветов
  List<Color> _calcPaintedColors() {
    final colorsList = <Color>[];
    for (final pair in _sortedShapes.entries) {
      var paintedPair = true;
      for (final shape in pair.value) {
        if (!shape.isPainted) {
          paintedPair = false;
          break;
        }
      }
      if (!paintedPair) {
        colorsList.add(pair.key);
      }
    }
    return colorsList;
  }

  // Used to build list items that haven't been removed.
  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    final currentColor = _animatedList[index];
    final colorIndex = _sortedShapes.keys.toList().indexOf(currentColor);
    final currentShapes = _sortedShapes.values.elementAt(colorIndex);
    final currentPercent =
        currentShapes.where((shape) => shape.isPainted).length /
            currentShapes.length;
    final oldPercent = currentPercent != 0
        ? (currentShapes.where((shape) => shape.isPainted).length - 1) /
            currentShapes.length
        : .0;

    return SizeTransition(
      key: UniqueKey(),
      sizeFactor: animation,
      child: ColorItem(
        percentController: widget.percentController,
        number: colorIndex,
        selected: selectedColor == _sortedShapes.keys.elementAt(colorIndex),
        onTap: () {
          setState(() {
            selectedColor = _sortedShapes.keys.elementAt(colorIndex);
            widget.onColorSelect(selectedColor);
          });
        },
        color: currentColor,
        currentPercent: currentPercent,
        oldPercent: oldPercent,
      ),
    );
  }

  // Used to build an item after it has been removed from the list. This
  // method is needed because a removed item remains visible until its
  // animation has completed (even though it's gone as far this ListModel is
  // concerned). The widget will be used by the
  // [AnimatedListState.removeItem] method's
  // [AnimatedListRemovedItemBuilder] parameter.
  Widget _buildRemovedItem(
    Color color,
    BuildContext context,
    Animation<double> animation,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(animation),
      child: ColorItem(
        number: _sortedShapes.keys.toList().indexOf(color),
        color: color,
        percentController: widget.percentController,
        // No gesture detector here: we don't want removed items to be interactive.
      ),
    );
  }

  /*Future _bannerCheckPurchaserInfo() async {
    if (_offerings != null) {
      final offering = _offerings!.getOffering('remove_ads');
      if (offering != null) {
        final lifetime = offering.lifetime;
        if (lifetime != null) {
          _purchaserInfo = await Purchases.purchasePackage(lifetime);
          setState(() {
            isActive = _purchaserInfo.entitlements.all['remove_ads']!.isActive;
          });
        }
      }
    }
    }*/
}
