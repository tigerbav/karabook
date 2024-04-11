import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/common/app_constants.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:percent_indicator/percent_indicator.dart';

@RoutePage()
class AchievementScreen extends StatelessWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: C.achievementsLocalData.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16, left: 20, right: 20),
            child: Container(
                width: double.infinity,
                constraints: const BoxConstraints(maxHeight: double.infinity),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color.fromRGBO(255, 242, 255, 1),
                        Color.fromRGBO(255, 228, 255, 1)
                      ]),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(1),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromRGBO(254, 248, 255, 1),
                              Color.fromRGBO(254, 242, 255, 1)
                            ]),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8, top: 8, left: 18),
                                child: Container(
                                  child: SvgPicture.asset(
                                    C.achievementsLocalData[index].icon,
                                  ),
                                  height: 72,
                                  width: 72,
                                ),
                              )),
                          Expanded(
                              flex: 6,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(left: 16),
                                    child: Text(
                                      C.achievementsLocalData[index].title
                                          .toUpperCase(),
                                      style: AppStyles.shared.packTitles,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, bottom: 2, top: 2),
                                    child: Text(
                                      "${C.achievementsLocalData[index].counter}  ${C.achievementsLocalData[index].subTitle.toUpperCase()}",
                                      style: AppStyles.shared.toast,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Container(
                                      child: LayoutBuilder(
                                          builder: (context, constraints) {
                                        return LinearPercentIndicator(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.64,
                                          animation: true,
                                          animationDuration: 1500,
                                          lineHeight: 2,
                                          percent: C
                                              .achievementsLocalData[index]
                                              .progress,
                                          backgroundColor:
                                              Color.fromRGBO(255, 214, 253, 1),
                                          progressColor:
                                              Color.fromRGBO(189, 0, 255, 1),
                                        );
                                      }),
                                    ),
                                  )
                                ],
                              ))
                        ],
                      ),
                    ))),
          );
        });
  }
}
