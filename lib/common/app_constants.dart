import 'package:karabookapp/common/app_resources.dart';
import 'package:karabookapp/pages/portfolio/data/models/achievement.dart';

class C {
  static const vip = 'VIP';
  static const gift = 'Gift';
  static const vibration = 'Vibration';
  static const fillAnimation = 'Fill Animation';
  static const fillHint = 'Fill Hint';
  static const helpCounter = 'Help';
  static const locale = 'locale';
  static const defaultLocale = 'en';
  static const image = 'image';

  static const removeAds = 'remove_ads';

  static const googleSignInEmail = 'google_sign_in_email';
  static const appleSignInEmail = 'apple_sign_in_email';
  static const appleLastSignIn = 'apple_last_sign_in';
  static const googleLastSignIn = 'google_last_sign_in';
  static const lastUserId = 'last_user_id';

  /// Category type ids
  static const categoryTypeId = 0;
  static const packTypeId = 1;
  static const paidPackTypeId = 2;

  static const maxBanners = 4;
  static const maxZoom = 2.5;
  static const bannerSecTick = 3;
  static const imageOnPage = 6;
  static const imageForDaily = 7;
  static const vipID = 1000;

  static const support = 'KaraBook support';
  static const email = 'zakra409@gmail.com';

  // hero tags
  static const daily = 'daily';
  static const comics = 'comics';
  static const library = 'library';
  static const portfolio = 'portfolio';

  static final achievementsLocalData = <Achievement>[
    const Achievement(
      icon: AppResources.silver,
      title: "SILVER STAR",
      counter: 5,
      subTitle: "PICTURES DONE",
      category: "PICTURES DONE",
      progress: 0.0,
      current: 0,
    ),
    const Achievement(
      icon: AppResources.gold,
      title: "GOLDEN STAR",
      counter: 10,
      current: 0,
      subTitle: "PICTURES DONE",
      category: "PICTURES DONE",
      progress: 0.0,
    ),
    const Achievement(
      icon: AppResources.platinum,
      title: "PLATINUM STAR",
      counter: 15,
      current: 0,
      subTitle: "PICTURES DONE",
      category: "PICTURES DONE",
      progress: 0.0,
    ),
    const Achievement(
      icon: AppResources.diamond,
      title: "DIAMOND STAR",
      counter: 20,
      current: 0,
      subTitle: "PICTURES DONE",
      category: "PICTURES DONE",
      progress: 0.0,
    ),
    const Achievement(
      icon: AppResources.food,
      title: "FOOD FAN",
      counter: 5,
      current: 0,
      subTitle: "PICS IN FOOD",
      category: "FOOD",
      progress: 0.0,
    ),
    const Achievement(
      icon: AppResources.nature,
      title: "NATURE LOVER",
      counter: 5,
      current: 0,
      subTitle: "PICS IN NATURE",
      category: "NATURE",
      progress: 0.0,
    ),
    const Achievement(
      icon: AppResources.people,
      title: "GREAT PERSONALITY",
      counter: 5,
      current: 0,
      subTitle: "IN PEOPLE",
      category: "PEOPLE",
      progress: 0.0,
    ),
    const Achievement(
      icon: AppResources.fauna,
      title: "FAUNA ADMIRER ",
      counter: 5,
      current: 0,
      subTitle: "IN ANIMALS & BIRDS",
      category: "ANIMALS & BIRDS",
      progress: 0.0,
    ),
    const Achievement(
      icon: AppResources.mandala,
      title: "RELAX LOVER",
      counter: 5,
      current: 0,
      subTitle: "IN MANDALAS",
      category: "MANDALAS",
      progress: 0.0,
    ),
    const Achievement(
      icon: AppResources.transport,
      title: "SPEED LOVER",
      counter: 5,
      current: 0,
      subTitle: "IN CARS & TRANSPORT",
      category: "CARS & TRANSPORT",
      progress: 0.0,
    ),
    const Achievement(
      icon: AppResources.fantasy,
      title: "INSPIRE OTHERS",
      counter: 5,
      current: 0,
      subTitle: "IN FANTASY",
      category: "FANTASY",
      progress: 0.0,
    ),
    const Achievement(
      icon: AppResources.design,
      title: "CREATOR",
      counter: 5,
      current: 0,
      subTitle: "IN DESIGN",
      category: "DESIGN",
      progress: 0.0,
    ),
    const Achievement(
      icon: AppResources.flowers,
      title: "REAL BEAUTY",
      counter: 5,
      current: 0,
      subTitle: "IN FLOWERS",
      category: "FLOWERS",
      progress: 0.0,
    ),
    const Achievement(
      icon: AppResources.butterfly,
      title: "AMAZING CREATIONS LOVER",
      counter: 5,
      current: 0,
      subTitle: "IN BUTTERFLIES",
      category: "BUTTERFLIES",
      progress: 0.0,
    ),
    const Achievement(
      icon: AppResources.cities,
      title: "EXPLORER",
      counter: 5,
      current: 0,
      subTitle: "IN CITIES",
      category: "CITIES",
      progress: 0.0,
    ),
    const Achievement(
      icon: AppResources.vip,
      title: "YOU ARE SIMPLY THE BEST",
      counter: 5,
      current: 0,
      subTitle: "IN VIP",
      category: "VIP",
      progress: 0.0,
    ),
  ];
}
