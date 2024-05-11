import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/services/core/models/db_models/painter_progress_model.dart';
import 'package:karabookapp/services/core/models/svg_models/svg_line_model.dart';
import 'package:karabookapp/services/core/models/svg_models/svg_shape_model.dart';
import 'package:karabookapp/services/core/painter_tools.dart';

@RoutePage()
class LoadingScreen extends StatefulWidget {
  final String svgString;
  final int id;

  const LoadingScreen({
    required this.svgString,
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late final _painterProgress = PainterProgressModel.fromScratch(
    id: widget.id,
    shapes: _svgShapes.join(' '),
    isCompleted: false,
  );

  final _svgShapes = <SvgShapeModel>[];
  final _svgLines = <SvgLineModel>[];
  final _sortedShapes = <Color, List<SvgShapeModel>>{};
  var _fittedSvgSize = const FittedSizes(Size.zero, Size.zero);

  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(milliseconds: 300), _initPainter).then(
    //   (_) => context.router.replace(
    //     // SvgViewRoute(
    //     //   painterProgressModel: _painterProgress,
    //     //   svgShapes: _svgShapes,
    //     //   svgLines: _svgLines,
    //     //   sortedShapes: _sortedShapes,
    //     //   fittedSvgSize: _fittedSvgSize,
    //     // ),
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          LocaleKeys.loading.tr(),
          style: const TextStyle(fontSize: 17, color: Colors.red),
        ),
      ),
    );
  }

  Future<void> _initPainter() async {
    _fittedSvgSize = PainterTools.getFittedSize(context, widget.svgString);
    PainterTools.setLinesAndShapes(
      context,
      widget.svgString,
      _svgShapes,
      _svgLines,
      _fittedSvgSize,
    );

    await PainterTools.getDbPainter(widget.id, _svgShapes, _painterProgress)
        .then((_) {
      _sortedShapes.addAll(PainterTools.setSortedShapes(_svgShapes));
    });
  }
}
