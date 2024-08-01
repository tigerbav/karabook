import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/common/cubits/image/painter_progress_cubit.dart';
import 'package:karabookapp/common/utils/utils.dart';
import 'package:karabookapp/generated/locale_keys.g.dart';
import 'package:karabookapp/pages/game_screen/data/datasources/game_datasource.dart';
import 'package:karabookapp/pages/game_screen/domain/repositories/game_repository.dart';
import 'package:karabookapp/pages/game_screen/presentation/logic/loading_game/loading_game_cubit.dart';
import 'package:karabookapp/pages/portfolio/presentation/logic/portfolio/portfolio_cubit.dart';
import 'package:karabookapp/services/navigation/app_router.dart';

@RoutePage()
class LoadingGameScreen extends StatelessWidget {
  const LoadingGameScreen({
    super.key,
    required this.svgString,
    required this.id,
    required this.painterProgressCubit,
    required this.portfolioCubit,
  });

  final String svgString;
  final int id;
  final PainterProgressCubit painterProgressCubit;
  final PortfolioCubit portfolioCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => LoadingGameCubit(
        repository: GameRepository(GameDataSource()),
        svgString: svgString,
        id: id,
      ),
      child: _LoadingGameView(painterProgressCubit, portfolioCubit),
    );
  }
}

class _LoadingGameView extends StatelessWidget {
  const _LoadingGameView(this.painterProgressCubit, this.portfolioCubit);

  final PainterProgressCubit painterProgressCubit;
  final PortfolioCubit portfolioCubit;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoadingGameCubit, LoadingGameState>(
      listener: (context, state) {
        late final cubit = context.read<LoadingGameCubit>();

        switch (state.status) {
          case LoadingGameStatus.failure:
            Utils.showToast(context, state.errorMessage);
            Navigator.pop(context);
          case LoadingGameStatus.success:
            context.router.replace(GameRoute(
              sortedShapes: cubit.sortedShapes,
              allShapes: cubit.svgShapes,
              svgLines: cubit.svgLines,
              painterProgress: cubit.painterProgress,
              completedIds: cubit.completedIds,
              painterProgressCubit: painterProgressCubit,
              portfolioCubit: portfolioCubit,
            ));
          case LoadingGameStatus.loading:
          case LoadingGameStatus.initial:
            break;
        }
      },
      child: PopScope(
        canPop: false,
        child: Scaffold(
          body: Center(
            child: Text(
              LocaleKeys.loading.tr(),
              style: AppStyles.shared.h1Pink,
            ),
          ),
        ),
      ),
    );
  }
}
