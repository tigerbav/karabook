import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/common/utils/utils.dart';
import 'package:karabookapp/common/widgets/app_popup.dart';
import 'package:karabookapp/common/widgets/checkbox/app_checkbox.dart';
import 'package:karabookapp/common/widgets/checkbox/checkbox_cubit.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/pages/game/data/datasources/game_datasource.dart';
import 'package:karabookapp/pages/game/domain/repositories/game_repository.dart';
import 'package:karabookapp/pages/game/presentation/logic/color_picker/color_picker_cubit.dart';
import 'package:karabookapp/pages/game/presentation/logic/game/game_cubit.dart';
import 'package:karabookapp/pages/game/presentation/logic/rewards/rewards_cubit.dart';
import 'package:karabookapp/pages/game/presentation/widgets/banner_widget.dart';
import 'package:karabookapp/pages/game/presentation/widgets/checkers_paint/checkers_paint.dart';
import 'package:karabookapp/pages/game/presentation/widgets/color_picker.dart';
import 'package:karabookapp/pages/game/presentation/widgets/fade_paint/fade_paint.dart';
import 'package:karabookapp/pages/game/presentation/widgets/help_button.dart';
import 'package:karabookapp/pages/game/presentation/widgets/number_painter.dart';
import 'package:karabookapp/pages/game/presentation/widgets/reward_button.dart';
import 'package:karabookapp/pages/game/presentation/widgets/screenshot_widget.dart';
import 'package:karabookapp/pages/game/presentation/widgets/zoom_out_button.dart';
import 'package:karabookapp/services/isar/models/image_model.dart';
import 'package:karabookapp/services/managers/shared_pref_manager.dart';

@RoutePage()
class GameScreen extends StatelessWidget {
  const GameScreen({
    super.key,
    required this.imageModel,
  });

  final ImageModel imageModel;

  @override
  Widget build(BuildContext context) {
    final repo = GameRepository(GameDataSource());

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => GameCubit(
            repository: repo,
            imageModel: imageModel,
          ),
        ),
        BlocProvider(create: (_) => ColorPickerCubit()),
        BlocProvider(create: (_) => RewardsCubit(repo)),
        BlocProvider(create: (_) => CheckBoxCubit()),
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

  @override
  void initState() {
    super.initState();

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _transformationController.addListener(() {
      final scale = _transformationController.value.getMaxScaleOnAxis();
      context.read<GameCubit>().setScale(scale);
    });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gameCubit = context.read<GameCubit>();
    final colorPickerCubit = context.read<ColorPickerCubit>();

    return MultiBlocListener(
      listeners: [
        BlocListener<ColorPickerCubit, ColorPickerState>(
          listenWhen: (p, c) =>
              p.selected?.color != c.selected?.color || c.activePickers.isEmpty,
          listener: (context, state) {
            gameCubit.setSelectedShapes(state.selected?.color);
            _fadeController.forward(from: 0.0);

            if (state.activePickers.isEmpty) gameCubit.finishGame();
          },
        ),
        BlocListener<GameCubit, GameState>(
          listenWhen: (p, c) => p.status != c.status,
          listener: (context, state) {
            switch (state.status) {
              case GameStatus.completed:
                Utils.showToast(
                  context,
                  LocaleKeys.congratulations_mission_completed.tr(),
                  isError: false,
                );
              //
              case GameStatus.exit:
                Navigator.pop(context);
              //
              case GameStatus.completeInit:
                if (gameCubit.showPopup == false) return;
                Utils.showPopUp(
                  context,
                  BlocProvider.value(
                    value: context.read<CheckBoxCubit>(),
                    child: AppPopup(
                      description:
                          LocaleKeys.some_tiny_parts_of_image_have_painted.tr(),
                      justDescription: true,
                      extraWidget: AppCheckbox(
                        title: LocaleKeys.do_not_show_again.tr(),
                        onTap: context.read<CheckBoxCubit>().toggle,
                      ),
                      onTapYes: () {
                        if (context.read<CheckBoxCubit>().state) {
                          SharedPrefManager.shared.write(
                            C.doNotShowAgain,
                            true,
                          );
                        }
                      },
                    ),
                  ),
                );

              //
              default:
                break;
            }
          },
        ),
      ],
      child: PopScope(
        canPop: false,
        child: OrientationBuilder(
          builder: (context, orientation) {
            return Scaffold(
              backgroundColor: AppColors.shared.white,
              body: BlocConsumer<GameCubit, GameState>(
                listenWhen: (_, c) => c.isCompleteInit,
                listener: (context, state) {
                  colorPickerCubit.initColorPicker(state.sortedShapes);
                },
                buildWhen: (p, c) =>
                    p.isLoading != c.isLoading || p.isSaving != c.isSaving,
                builder: (context, state) {
                  if (state.isLoading || state.isSaving) {
                    return Center(
                      child: Text(
                        state.isSaving
                            ? LocaleKeys.saving_progress.tr()
                            : LocaleKeys.loading.tr(),
                        style: AppStyles.shared.h1Pink,
                      ),
                    );
                  }
                  final width = 1.sw;
                  final height = 1.sh;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      InteractiveViewer(
                        transformationController: _transformationController,
                        boundaryMargin: EdgeInsets.all(100.sp),

                        /// BIG ZOOM CAN BREAK THE APP!!! BE CAREFULLY!!!
                        maxScale: C.maxZoom,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: width,
                              height: height,
                              child: const CheckersPaint(),
                            ),
                            // SizedBox(
                            //   width: 1.sw,
                            //   height: 1.sh,
                            //   child: const ManyCirclesPaint(),
                            // ),
                            SizedBox(
                              width: width,
                              height: height,
                              child: FadePaint(_fadeController),
                            ),
                            ScreenshotWidget(width: width, height: height),
                            IgnorePointer(
                              child: SizedBox(
                                width: width,
                                height: height,
                                child: BlocBuilder<GameCubit, GameState>(
                                  buildWhen: (p, c) =>
                                      p.unPainted != c.unPainted ||
                                      p.zoomScale != c.zoomScale,
                                  builder: (_, state) {
                                    return RepaintBoundary(
                                      child: CustomPaint(
                                        painter: NumberPainter(
                                          shapes: state.unPainted,
                                          colors: colorPickerCubit.state.items,
                                          scale: state.zoomScale.toDouble(),
                                        ),
                                      ),
                                    );
                                  },
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
                            colorPickerCubit.resetColor();
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
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: BlocBuilder<GameCubit, GameState>(
                          buildWhen: (p, c) => p.isCompleted != c.isCompleted,
                          builder: (context, state) {
                            if (state.isCompleted) return const SizedBox();
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ZoomOutButton(
                                  transformController:
                                      _transformationController,
                                ),
                                ColoredBox(
                                  color: AppColors.shared.colorPickerBg,
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10.sp),
                                      const ColorPicker(),
                                      SizedBox(height: 10.sp),
                                      const BannerWidget(),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
