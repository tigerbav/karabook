import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/common/cubits/image/painter_progress_cubit.dart';
import 'package:karabookapp/common/utils/utils.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/pages/game_screen/data/datasources/game_datasource.dart';
import 'package:karabookapp/pages/game_screen/domain/repositories/game_repository.dart';
import 'package:karabookapp/pages/game_screen/presentation/logic/color_picker/color_picker_cubit.dart';
import 'package:karabookapp/pages/game_screen/presentation/logic/game/game_cubit.dart';
import 'package:karabookapp/pages/game_screen/presentation/logic/rewards/rewards_cubit.dart';
import 'package:karabookapp/pages/game_screen/presentation/widgets/banner_widget.dart';
import 'package:karabookapp/pages/game_screen/presentation/widgets/checkers_paint/checkers_paint.dart';
import 'package:karabookapp/pages/game_screen/presentation/widgets/circle_paint/circle_paint.dart';
import 'package:karabookapp/pages/game_screen/presentation/widgets/color_picker.dart';
import 'package:karabookapp/pages/game_screen/presentation/widgets/fade_paint/fade_paint.dart';
import 'package:karabookapp/pages/game_screen/presentation/widgets/help_button.dart';
import 'package:karabookapp/pages/game_screen/presentation/widgets/number_painter.dart';
import 'package:karabookapp/pages/game_screen/presentation/widgets/reward_button.dart';
import 'package:karabookapp/pages/game_screen/presentation/widgets/screenshot_widget.dart';
import 'package:karabookapp/pages/game_screen/presentation/widgets/zoom_out_button.dart';
import 'package:karabookapp/pages/portfolio/presentation/logic/portfolio/portfolio_cubit.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_line_model.dart';
import 'package:karabookapp/services/game_core/models/svg_models/svg_shape_model.dart';
import 'package:karabookapp/services/game_core/painter_tools.dart';
import 'package:karabookapp/services/isar/models/painter_progress.dart';

@RoutePage()
class GameScreen extends StatelessWidget {
  const GameScreen({
    super.key,
    required this.sortedShapes,
    required this.allShapes,
    required this.svgLines,
    required this.painterProgress,
    required this.completedIds,
    required this.painterProgressCubit,
    required this.portfolioCubit,
  });

  final Map<Color, List<SvgShapeModel>> sortedShapes;
  final List<SvgShapeModel> allShapes;
  final List<SvgLineModel> svgLines;
  final PainterProgress painterProgress;
  final List<int> completedIds;
  final PainterProgressCubit painterProgressCubit;
  final PortfolioCubit portfolioCubit;

  @override
  Widget build(BuildContext context) {
    final sort = PainterTools.sortBlackFirst(sortedShapes);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GameCubit(
            repository: GameRepository(GameDataSource()),
            sortedShapes: sort,
            allShapes: allShapes,
            svgLines: svgLines,
            painterProgress: painterProgress,
            completedIds: completedIds,
            painterProgressCubit: painterProgressCubit,
            portfolioCubit: portfolioCubit,
          ),
        ),
        BlocProvider(create: (_) => RewardsCubit()),
        BlocProvider(
          create: (_) => ColorPickerCubit(
            sortedShapes: sort,
          ),
        ),
      ],
      child: const _GameView(),
    );
  }
}

class _GameView extends StatefulWidget {
  const _GameView();

  @override
  State<_GameView> createState() => _GameViewState();
}

class _GameViewState extends State<_GameView>
    with SingleTickerProviderStateMixin {
  final _transformationController = TransformationController();
  late final AnimationController _fadeController;
  final _scaleNotifier = ValueNotifier(1.0);

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _transformationController.addListener(() {
      _scaleNotifier.value =
          _transformationController.value.getMaxScaleOnAxis();
    });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _scaleNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameCubit = context.read<GameCubit>();

    return MultiBlocListener(
      listeners: [
        BlocListener<ColorPickerCubit, ColorPickerState>(
          listenWhen: (p, c) =>
              p.selected?.number != c.selected?.number ||
              p.activePickers.length != c.activePickers.length,
          listener: (context, state) async {
            gameCubit.setSelectedShapes(state.selected?.color);
            _fadeController.forward(from: 0.0);

            if (state.activePickers.isEmpty) gameCubit.finishGame();
          },
        ),
        BlocListener<GameCubit, GameState>(
          listener: (context, state) {
            switch (state.status) {
              case GameStatus.shapeTapped:
              case GameStatus.exit:
                Navigator.pop(context);
              case GameStatus.completed:
                Utils.showToast(
                  context,
                  LocaleKeys.congratulations_mission_completed.tr(),
                  isError: false,
                );

              case GameStatus.initial:
              case GameStatus.idle:
              case GameStatus.loading:
                break;
            }
          },
        ),
      ],
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: AppColors.shared.white,
          body: Stack(
            alignment: Alignment.center,
            children: [
              InteractiveViewer(
                transformationController: _transformationController,
                boundaryMargin: EdgeInsets.all(100.sp),
                maxScale: 50,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 1.sw,
                      height: 1.sh,
                      child: const CheckersPaint(),
                    ),
                    SizedBox(
                      width: 1.sw,
                      height: 1.sh,
                      child: const ManyCirclesPaint(),
                    ),
                    SizedBox(
                      width: 1.sw,
                      height: 1.sh,
                      child: FadePaint(_fadeController),
                    ),
                    const ScreenshotWidget(),
                    IgnorePointer(
                      child: SizedBox(
                        width: 1.sw,
                        height: 1.sh,
                        child: ValueListenableBuilder(
                          valueListenable: _scaleNotifier,
                          builder: (_, scale, __) =>
                              BlocBuilder<GameCubit, GameState>(
                            buildWhen: (p, c) =>
                                p.completedIds != c.completedIds,
                            builder: (_, state) {
                              return RepaintBoundary(
                                child: CustomPaint(
                                  painter: NumberPainter(
                                    shapes: gameCubit.state.allShapes,
                                    colors: context
                                        .read<ColorPickerCubit>()
                                        .state
                                        .items,
                                    scale: scale,
                                    completedIds: state.completedIds,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 10,
                left: 10,
                child: IconButton(
                  onPressed: () {
                    context.read<ColorPickerCubit>().resetColor();
                    gameCubit.exit();
                  },
                  icon: SvgPicture.asset(AppResources.back),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).padding.top + 10.sp,
                right: 10.sp,
                child: HelpButton(
                  transformationController: _transformationController,
                ),
              ),
              BlocBuilder<RewardsCubit, RewardsState>(
                buildWhen: (p, c) => p.noAds != c.noAds,
                builder: (context, state) {
                  if (state.noAds == true) return const SizedBox();
                  return const RewardButton();
                },
              ),
              Positioned(
                bottom: 160.sp,
                right: 10.sp,
                child: ZoomOutButton(
                  transformController: _transformationController,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: BlocBuilder<GameCubit, GameState>(
                  buildWhen: (p, c) => p.isCompleted != c.isCompleted,
                  builder: (context, state) {
                    if (state.isCompleted) return const SizedBox();
                    return ColoredBox(
                      color: AppColors.shared.colorPickerBg,
                      child: Column(
                        children: [
                          SizedBox(height: 10.sp),
                          const ColorPicker(),
                          SizedBox(height: 10.sp),
                          const BannerWidget(),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
