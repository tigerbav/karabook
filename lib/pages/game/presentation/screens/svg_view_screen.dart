import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/pages/game/presentation/widgets/checkers_paint/checkers_paint.dart';
import 'package:karabookapp/pages/game/presentation/widgets/circle_paint/circle_paint.dart';
import 'package:karabookapp/pages/game/presentation/widgets/color_picker/color_picker.dart';
import 'package:karabookapp/pages/game/presentation/widgets/fade_paint/fade_paint.dart';
import 'package:karabookapp/pages/game/presentation/widgets/help_button.dart';
import 'package:karabookapp/pages/game/presentation/widgets/line_paint/line_paint.dart';
import 'package:karabookapp/pages/game/presentation/widgets/number_painter.dart';
import 'package:karabookapp/pages/game/presentation/widgets/painter_inherited.dart';
import 'package:karabookapp/pages/game/presentation/widgets/reward_button.dart';
import 'package:karabookapp/pages/game/presentation/widgets/shape_painter.dart';
import 'package:karabookapp/pages/game/presentation/widgets/zoom_out_button.dart';

import 'package:karabookapp/services/core/models/coloring_shape.dart';
import 'package:karabookapp/services/core/models/db_models/painter_progress_model.dart';
import 'package:karabookapp/services/core/models/svg_models/svg_line_model.dart';
import 'package:karabookapp/services/core/models/svg_models/svg_shape_model.dart';
import 'package:karabookapp/services/core/painter_tools.dart';
import 'package:karabookapp/services/core/rewards.dart';
import 'package:karabookapp/services/core/toast.dart';
import 'package:karabookapp/services/managers/shared_pref_manager.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:screenshot/screenshot.dart';

@RoutePage()
class SvgViewScreen extends StatefulWidget {
  final PainterProgressModel painterProgressModel;
  final List<SvgShapeModel> svgShapes;
  final List<SvgLineModel> svgLines;
  final Map<Color, List<SvgShapeModel>> sortedShapes;
  final FittedSizes fittedSvgSize;
  const SvgViewScreen({
    required this.painterProgressModel,
    required this.svgShapes,
    required this.svgLines,
    required this.sortedShapes,
    required this.fittedSvgSize,
    Key? key,
  }) : super(key: key);

  @override
  _SvgViewScreenState createState() => _SvgViewScreenState();
}

class _SvgViewScreenState extends State<SvgViewScreen>
    with TickerProviderStateMixin {
  final _offsetNotifier = ValueNotifier(Offset.zero);
  final _scaleNotifier = ValueNotifier(1.0);

  final List<ColoringShape> _selectedColoringShapes = [];

  final _colorListKey = GlobalKey<ColorPickerState>();

  late final _fadeController = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  late final _percentController = AnimationController(
    duration: const Duration(milliseconds: 300),
    vsync: this,
  );

  final _transformationController = TransformationController();

  final _rewards = Rewards();

  final _zoomKey = GlobalKey<ZoomOutButtonState>();

  bool isInit = false;

  FToast? _currentToast;

  List<SvgShapeModel> _selectedShapes = [];
  SvgShapeModel _selectedShape = SvgShapeModel.epmty();

  Color? _selectedColor;

  final _screenShotController = ScreenshotController();

  var _millisecondsAnimation = 0;

  @override
  void dispose() {
    _fadeController.dispose();
    _offsetNotifier.dispose();
    _transformationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _isAnimatedPaint();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _transformationController.value = Matrix4Transform()
          .scale(1.15,
              origin: Offset(widget.fittedSvgSize.destination.width / 2,
                  widget.fittedSvgSize.destination.height / 2))
          .matrix4;
    });

    _transformationController.addListener(() {
      _scaleNotifier.value =
          _transformationController.value.getMaxScaleOnAxis();
    });
    _rewards.createRewardedAd();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body:
          // Этот виджет нужен для переброса данных в другие виджеты
          //c помощью PainterInherited.of(context)
          PainterInherited(
        painterProgress: widget.painterProgressModel,
        svgShapes: widget.svgShapes,
        selectedShapes: _selectedShapes,
        onComplete: () => setState(
          () {
            _zoomKey.currentState!.animateResetInitialize();
            widget.painterProgressModel.isCompleted = true;
            PainterTools.dbProvider.updatePainter(widget.painterProgressModel);
            Toasts.showCompleteToast(context, 10);
          },
        ),
        rewardCallback: () => setState(() {}),
        child: Stack(
          children: [
            OrientationBuilder(
              builder: (context, orientation) {
                return InteractiveViewer(
                  transformationController: _transformationController,
                  onInteractionUpdate: (details) {
                    _scaleNotifier.value =
                        _transformationController.value.getMaxScaleOnAxis();
                  },
                  minScale: 0.1,
                  maxScale: 100.0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: size.width,
                        height: size.height,
                        child: const CheckersPaint(),
                      ),
                      SizedBox(
                        width: size.width,
                        height: size.height,
                        child: ManyCirclesPaint(
                          notifier: _offsetNotifier,
                          selectedColoredShapes: _selectedColoringShapes,
                          percentController: _percentController,
                          colorListKey: _colorListKey,
                          millisecondsAnimation: _millisecondsAnimation,
                          onEndCircle: () => setState(() {
                            _screenShotProgressColoring();
                            _vibrationEndColor();
                          }),
                        ),
                      ),
                      SizedBox(
                        width: size.width,
                        height: size.height,
                        child: FadePaint(
                          fadeController: _fadeController,
                          selectedSvgShapes: _selectedShapes,
                        ),
                      ),
                      Screenshot(
                        controller: _screenShotController,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: size.width,
                              height: size.height,
                              child: Listener(
                                onPointerUp: (e) => _onTapUp(e, context),
                                child: CustomPaint(
                                  isComplex: true,
                                  painter: ShapePainter(
                                    notifier: _offsetNotifier,
                                    shapes: widget.svgShapes,
                                    selectedShapes: _selectedShapes,
                                    lines: widget.svgLines,
                                    sortedShapes: widget.sortedShapes,
                                    selectedColor: _selectedColor,
                                    isInit: isInit,
                                    center: Offset(
                                      size.width / 2,
                                      size.height * 0.85 / 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            IgnorePointer(
                              child: SizedBox(
                                width: size.width,
                                height: size.height,
                                child: LinePaint(svgLines: widget.svgLines),
                              ),
                            ),
                          ],
                        ),
                      ),
                      IgnorePointer(
                        child: SizedBox(
                          width: size.width,
                          height: size.height,
                          //С помощью этого виджета слушаем изменения при зуме
                          child: ValueListenableBuilder(
                            valueListenable: _scaleNotifier,
                            builder: (context, scale, child) {
                              return RepaintBoundary(
                                child: CustomPaint(
                                  painter: NumberPainter(
                                    shapes: widget.svgShapes,
                                    scale: scale,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              bottom: 200,
              right: 10,
              child: ZoomOutButton(
                key: _zoomKey,
                transformController: _transformationController,
              ),
            ),
            Visibility(
              visible: !widget.painterProgressModel.isCompleted,
              child: Positioned(
                top: MediaQuery.of(context).padding.top + 10,
                right: 10,
                child: HelpButton(
                  transformationController: _transformationController,
                  selectedShapes: _selectedShapes,
                  rewards: _rewards,
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).padding.top + 10,
              left: 10,
              child: IconButton(
                onPressed: context.router.pop,
                icon: SvgPicture.asset(AppResources.back),
              ),
            ),
            Visibility(
              visible: !widget.painterProgressModel.isCompleted,
              child: RewardButton(rewards: _rewards),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Visibility(
                visible: !widget.painterProgressModel.isCompleted,
                child: ColorPicker(
                  key: _colorListKey,
                  percentController: _percentController,
                  sortedShapes: widget.sortedShapes,
                  onColorSelect: _callBackIndexColorOfColorPicker,
                  rewards: _rewards,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onTapUp(PointerUpEvent e, BuildContext context) {
    if (_selectedColor != null) {
      for (final shape in _selectedShapes) {
        if (shape.transformedPath!.contains(e.localPosition)) {
          if (_selectedShape != shape && !shape.isPainted) {
            _offsetNotifier.value = e.localPosition;
            setState(() {
              _selectedShape = shape;
              _selectedColoringShapes.add(ColoringShape(
                circlePosition: e.localPosition,
                shape: shape,
              ));
            });
            break;
          }
        }
      }
    } else {
      _showPickToast(context);
    }
  }

  void _showPickToast(BuildContext context) {
    if (_currentToast == null && !widget.painterProgressModel.isCompleted) {
      _currentToast = Toasts.showPickColorToast(context, 10);
      Future<void>.delayed(const Duration(seconds: 5), () {
        _currentToast?.removeCustomToast();
        _currentToast = null;
      });
    }
  }

  void _callBackIndexColorOfColorPicker(Color selectedColor) {
    if (_selectedColor != selectedColor) {
      _selectedColoringShapes.clear();
      _selectedColor = selectedColor;
      _selectedShapes = widget.sortedShapes[selectedColor]!;
      for (final shape in widget.svgShapes) {
        shape.isPicked = shape.fill == _selectedColor;
      }
      setState(() {});
      _fadeController.forward(from: 0.0);
    }
    debugPrint('_callBackIndexColorOfColorPicker: $_selectedColor');
  }

  void _screenShotProgressColoring() async {
    widget.painterProgressModel.screenProgress =
        await _screenShotController.capture();

    await PainterTools.dbProvider.updatePainter(widget.painterProgressModel);
  }

  Future<void> _vibrationEndColor() async {
    final isVibrate = await SharedPrefManager.share.get(C.vibration);
    if (isVibrate is bool && isVibrate == true) Vibrate.vibrate();
  }

  Future<void> _isAnimatedPaint() async {
    final isAnimated = await SharedPrefManager.share.get(C.fillAnimation);
    if (isAnimated is bool && isAnimated == true) {
      _millisecondsAnimation = 400;
      return;
    }
    _millisecondsAnimation = 0;
  }
}
