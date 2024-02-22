import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:karabookapp/common/app_colors.dart';
import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/common/app_styles.dart';
import 'package:karabookapp/pages/portfolio/data/models/achievements.dart';
import 'package:percent_indicator/percent_indicator.dart';

@RoutePage()
class AchievementScreen extends StatelessWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Achievements> achievementsLocalData = <Achievements>[
      const Achievements(
          icon: AppResources.silver,
          title: "SILVER STAR",
          counter: 5,
          subTitle: "PICTURES DONE",
          category: "PICTURES DONE",
          progress: 0.0,
          current: 0),
      const Achievements(
          icon: AppResources.gold,
          title: "GOLDEN STAR",
          counter: 10,
          current: 0,
          subTitle: "PICTURES DONE",
          category: "PICTURES DONE",
          progress: 0.0),
      const Achievements(
          icon: AppResources.platinum,
          title: "PLATINUM STAR",
          counter: 15,
          current: 0,
          subTitle: "PICTURES DONE",
          category: "PICTURES DONE",
          progress: 0.0),
      const Achievements(
          icon: AppResources.diamond,
          title: "DIAMOND STAR",
          counter: 20,
          current: 0,
          subTitle: "PICTURES DONE",
          category: "PICTURES DONE",
          progress: 0.0),
      const Achievements(
          icon: AppResources.food,
          title: "FOOD FAN",
          counter: 5,
          current: 0,
          subTitle: "PICS IN FOOD",
          category: "FOOD",
          progress: 0.0),
      const Achievements(
          icon: AppResources.nature,
          title: "NATURE LOVER",
          counter: 5,
          current: 0,
          subTitle: "PICS IN NATURE",
          category: "NATURE",
          progress: 0.0),
      const Achievements(
          icon: AppResources.people,
          title: "GREAT PERSONALITY",
          counter: 5,
          current: 0,
          subTitle: "IN PEOPLE",
          category: "PEOPLE",
          progress: 0.0),
      const Achievements(
          icon: AppResources.fauna,
          title: "FAUNA ADMIRER ",
          counter: 5,
          current: 0,
          subTitle: "IN ANIMALS & BIRDS",
          category: "ANIMALS & BIRDS",
          progress: 0.0),
      const Achievements(
          icon: AppResources.mandala,
          title: "RELAX LOVER",
          counter: 5,
          current: 0,
          subTitle: "IN MANDALAS",
          category: "MANDALAS",
          progress: 0.0),
      const Achievements(
          icon: AppResources.transport,
          title: "SPEED LOVER",
          counter: 5,
          current: 0,
          subTitle: "IN CARS & TRANSPORT",
          category: "CARS & TRANSPORT",
          progress: 0.0),
      const Achievements(
          icon: AppResources.fantasy,
          title: "INSPIRE OTHERS",
          counter: 5,
          current: 0,
          subTitle: "IN FANTASY",
          category: "FANTASY",
          progress: 0.0),
      const Achievements(
          icon: AppResources.design,
          title: "CREATOR",
          counter: 5,
          current: 0,
          subTitle: "IN DESIGN",
          category: "DESIGN",
          progress: 0.0),
      const Achievements(
          icon: AppResources.flowers,
          title: "REAL BEAUTY",
          counter: 5,
          current: 0,
          subTitle: "IN FLOWERS",
          category: "FLOWERS",
          progress: 0.0),
      const Achievements(
          icon: AppResources.butterfly,
          title: "AMAZING CREATIONS LOVER",
          counter: 5,
          current: 0,
          subTitle: "IN BUTTERFLIES",
          category: "BUTTERFLIES",
          progress: 0.0),
      const Achievements(
          icon: AppResources.cities,
          title: "EXPLORER",
          counter: 5,
          current: 0,
          subTitle: "IN CITIES",
          category: "CITIES",
          progress: 0.0),
      const Achievements(
          icon: AppResources.vip,
          title: "YOU ARE SIMPLY THE BEST",
          counter: 5,
          current: 0,
          subTitle: "IN VIP",
          category: "VIP",
          progress: 0.0),
    ];
    return ListView.builder(
        itemCount: achievementsLocalData.length,
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
                                    achievementsLocalData[index].icon,
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
                                      achievementsLocalData[index]
                                          .title
                                          .toUpperCase(),
                                      style: AppStyles.shared.packTitles,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, bottom: 2, top: 2),
                                    child: Text(
                                      "${achievementsLocalData[index].counter}  ${achievementsLocalData[index].subTitle.toUpperCase()}",
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
                                          percent: achievementsLocalData[index]
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
