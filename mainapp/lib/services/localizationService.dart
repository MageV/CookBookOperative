class localizationService {
  localizationService._privateConstructor();
static late var defaultLanguage;
static const allowedLang=['en_US','ru_RU'];
static Map<String,Map<String,String>> langValues=
{
  'en_US':{
    'CatView_header':'Recipes Category',
    'RecView_header':'Rec',
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
    'header_4': 'Search'
  },
  'ru_RU':{
    'CatView_header':'Категории',
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
    'header_4': 'Поиск'
  }
};
  static final localizationService _instance = localizationService
      ._privateConstructor();

  factory localizationService()
  {
    return _instance;
  }
  void init(String locale)
  {
    if(allowedLang.contains(locale)) {
      defaultLanguage = locale;
    }
    else
      defaultLanguage=allowedLang[0];
  }
  String? of(String name)
  {
    return langValues[defaultLanguage]![name];
  }
  String getDefaultLocale()=> defaultLanguage;
}
