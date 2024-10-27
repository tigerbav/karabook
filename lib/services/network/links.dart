class Links {
  static const _baseUrl = 'http://185.65.244.209:1974';

  static const instagram = 'https://www.instagram.com/karabookcolor/';

  static const privacy =
      'https://www.privacypolicies.com/live/e6ecf303-92af-4de5-9b66-c1b7b4d9a9ab';

  static const locale = '$_baseUrl/api/text/locale/get/all';

  //text
  static const serverText = '$_baseUrl/api/text/i18n/get/all';
  static const serverTextByLocale = '$_baseUrl/api/text/i18n/get/all/ByLocale/';
  static const serverTextByTextKey =
      '$_baseUrl/api/text/i18n/get/all/ByTextKey';

  //category
  static const categoryGetAll = '$_baseUrl/api/category/get/all';

  //images
  static const _imageGetAll = '$_baseUrl/api/image/get/all';
  static const modifiedImage = '$_imageGetAll/ByModifiedDate';
  static const imageByIds = '$_imageGetAll/ByIds/';

  //user
  static const userAdd = '$_baseUrl/api/user/add';
  static const userDelete = '$_baseUrl/api/user/delete/byId';
  static const userByEmail = '$_baseUrl/api/user/get/all/ByUserEmail/';
  static const userPatch = '$_baseUrl/api/user/update/hintsAmount/';

  // progress
  static const progressByUser =
      '$_baseUrl/api/image/progress/get/all/ByUserId/';
  static const progressAdd = '$_baseUrl/api/image/progress/add';
  static const progressUpdate = '$_baseUrl/api/image/progress/update';
  static const deleteByUserAndImage =
      '$_baseUrl/api/image/progress/delete/ByUserIdAndImageId';

  // achievements
  static const achievementAll = '$_baseUrl/api/achivement/get/all';
  static const achievementProgressAll =
      '$_baseUrl/api/achivements-progress/get/byUserId';
}
