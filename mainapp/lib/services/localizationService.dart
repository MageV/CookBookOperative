
class LocalizationService {
  LocalizationService._privateConstructor();
  static late var defaultLanguage;
  static const allowedLang = ['en_US', 'ru_RU'];

  static Map<String, Map<String, String>> langValues = {
    'en_US': {
      'CatView_header': 'Recipes Category',
      'RecView_header': 'Rec',
      'cat_1': 'Appetizers',
      'cat_2': 'Soups',
      'cat_3': 'Main',
      'cat_4': 'Drinks',
      'cat_5': 'Bakery',
      'cat_6': 'Ice cream',
      'cat_7': 'Sweets',
      'header_1': 'Categories',
      'header_2': 'News',
      'header_3': 'Settings',
      'header_4': 'Search',
      'dialog_item_new_manual': 'Manual',
      'dialog_item_new_camera': 'Camera',
      'dialog_item_new_header': 'Enter recipe',
      'dialog_item_ok': 'OK',
      'dialog_item_cancel': 'Cancel',
      'application_header':'My cookbook',
      'recipe_header':'Recipe',
      'recipe_toc':'Ingredients',
      'recipe desc':'Description',
      'recipe_photo':'Photo',
      'recipe_no_data':'This field must be filled',
      'recipe_cam_step1_title':'Obtain ingredients',
      'recipe_cam_step2_title':'Obtain process',
      'recipe_cam_step3_title':'Obtain picture',
      'recipe_cam_step1_subtitle':'Put ingredients section in camera box \n below and press red button',
      'recipe_cam_step2_subtitle':'Put process description in camera box \n below and press red button',
      'recipe_cam_step3_subtitle':'Put result picture in camera box \n belo and press red button',
    },
    'ru_RU': {
      'CatView_header': 'Категории',
      'cat_1': 'Закуски',
      'cat_2': 'Супы',
      'cat_3': 'Горячее',
      'cat_4': 'Напитки',
      'cat_5': 'Выпечка',
      'cat_6': 'Мороженое',
      'cat_7': 'Сладкое',
      'header_1': 'Категории',
      'header_2': 'Новости',
      'header_3': 'Настройки',
      'header_4': 'Поиск',
      'dialog_item_new_manual': 'Вручную',
      'dialog_item_new_camera': 'Камера',
      'dialog_item_new_header': 'Ввод рецепта',
      'dialog_item_ok': 'OK',
      'dialog_item_cancel': 'Отмена',
      'application_header':'Книга рецептов',
      'recipe_header':'Название',
      'recipe_toc':'Ингредиенты',
      'recipe desc':'Описание',
      'recipe_photo':'Фотография',
      'recipe_no_data':'Поле должно быть заполнено',
      'recipe_cam_step1_title':'Сканирование ингредиентов',
      'recipe_cam_step2_title':'Сканирование процесса приготовления',
      'recipe_cam_step3_title':'Сканирование изображения блюда',
      'recipe_cam_step1_subtitle':'Наведите объектив на перечень ингредиентов \n и нажмите красную кнопку',
      'recipe_cam_step2_subtitle':'Наведите объектив на процесс приготовления \n и нажмите красную кнопку',
      'recipe_cam_step3_subtitle':'Наведите объектив на изображение блюда \n и нажмите красную кнопку',

}
  };
  static final LocalizationService _instance =
      LocalizationService._privateConstructor();

  factory LocalizationService() {
    return _instance;
  }
  void init(String locale) {
    if (allowedLang.contains(locale)) {
      defaultLanguage = locale;
    } else
      defaultLanguage = allowedLang[0];
  }

  String? of(String name) {
    return langValues[defaultLanguage]![name];
  }

  String getDefaultLocale() => defaultLanguage;
}
