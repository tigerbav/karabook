import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:karabookapp/common/utils/utils.dart';
import 'package:karabookapp/pages/events/presentation/logic/comics/comics_cubit.dart';
import 'package:karabookapp/pages/events/presentation/logic/daily/daily_cubit.dart';
import 'package:karabookapp/pages/events/presentation/widgets/comics_widget.dart';
import 'package:karabookapp/pages/events/presentation/widgets/daily_widget.dart';
import 'package:karabookapp/pages/events/presentation/widgets/events_app_bar.dart';

@RoutePage()
class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});

  @override
  State<EventsScreen> createState() => _EventsScreenViewState();
}

class _EventsScreenViewState extends State<EventsScreen> {
  final _controller = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ComicsCubit, ComicsState>(
          listener: (context, state) {
            if (state.isFailure) Utils.showToast(context, null);
          },
        ),
        BlocListener<DailyCubit, DailyState>(
          listener: (context, state) {
            if (state.isFailure) Utils.showToast(context, null);
          },
        ),
      ],
      child: Scaffold(
        appBar: EventsAppBar(),
        body: ListView(
          controller: _controller,
          children: [
            const DailyWidget(),
            SizedBox(height: 40.sp),
            const ComicsWidget(),
          ],
        ),
      ),
    );
  }
}
