class localizationService {
  localizationService._privateConstructor();
static late var defaultLanguage;
static Map<String,Map<String,String>> langValues=
{
  'en_US':{
    'CatView_header':'Recipes Category',
    'RecView_header':'Rec',
    'Cat_1': 'Appetizers',
    'Cat_2': 'Soups',
    'Cat_3': 'Main',
    'Cat_4': 'Drinks',
    'Cat_5': 'Bakery',
    'Cat_6': 'Ice cream',
    'Cat_7': 'Sweets'
  },
  'ru_RU':{
    'CatView_header':'Категории',
    'Cat_1': 'Закуски',
    'Cat_2': 'Супы',
    'Cat_3': 'Горячее',
    'Cat_4': 'Напитки',
    'Cat_5': 'Выпечка',
    'Cat_6': 'Мороженое',
    'Cat_7': 'Сладкое'
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
    defaultLanguage=locale;
  }
  String? of(String name)
  {
    return langValues[defaultLanguage]![name];
  }
  String getDefaultLocale()=> defaultLanguage;
}
