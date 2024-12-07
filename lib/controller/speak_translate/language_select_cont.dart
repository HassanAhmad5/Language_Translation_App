import 'package:get/get.dart';

class LanguageSelectController extends GetxController {
  // List of available languages with codes
  final List<Map<String, String>> languages = [
    {'language': 'English', 'countryCode': 'US', 'languageCode': 'en'},
    {'language': 'Spanish', 'countryCode': 'ES', 'languageCode': 'es'},
    {'language': 'French', 'countryCode': 'FR', 'languageCode': 'fr'},
    {'language': 'German', 'countryCode': 'DE', 'languageCode': 'de'},
    {'language': 'Italian', 'countryCode': 'IT', 'languageCode': 'it'},
    {'language': 'Portuguese', 'countryCode': 'PT', 'languageCode': 'pt'},
    {'language': 'Chinese', 'countryCode': 'CN', 'languageCode': 'zh'},
    {'language': 'Japanese', 'countryCode': 'JP', 'languageCode': 'ja'},
    {'language': 'Russian', 'countryCode': 'RU', 'languageCode': 'ru'},
    {'language': 'Arabic', 'countryCode': 'SA', 'languageCode': 'ar'},
    {'language': 'Hindi', 'countryCode': 'IN', 'languageCode': 'hi'},
    {'language': 'Bengali', 'countryCode': 'BD', 'languageCode': 'bn'},
    {'language': 'Punjabi', 'countryCode': 'IN', 'languageCode': 'pa'},
    {'language': 'Korean', 'countryCode': 'KR', 'languageCode': 'ko'},
    {'language': 'Vietnamese', 'countryCode': 'VN', 'languageCode': 'vi'},
    {'language': 'Turkish', 'countryCode': 'TR', 'languageCode': 'tr'},
    {'language': 'Polish', 'countryCode': 'PL', 'languageCode': 'pl'},
    {'language': 'Dutch', 'countryCode': 'NL', 'languageCode': 'nl'},
    {'language': 'Swedish', 'countryCode': 'SE', 'languageCode': 'sv'},
    {'language': 'Finnish', 'countryCode': 'FI', 'languageCode': 'fi'},
    {'language': 'Norwegian', 'countryCode': 'NO', 'languageCode': 'no'},
    {'language': 'Danish', 'countryCode': 'DK', 'languageCode': 'da'},
    {'language': 'Greek', 'countryCode': 'GR', 'languageCode': 'el'},
    {'language': 'Czech', 'countryCode': 'CZ', 'languageCode': 'cs'},
    {'language': 'Hungarian', 'countryCode': 'HU', 'languageCode': 'hu'},
    {'language': 'Romanian', 'countryCode': 'RO', 'languageCode': 'ro'},
    {'language': 'Thai', 'countryCode': 'TH', 'languageCode': 'th'},
    {'language': 'Indonesian', 'countryCode': 'ID', 'languageCode': 'id'},
    {'language': 'Ukrainian', 'countryCode': 'UA', 'languageCode': 'uk'},
    {'language': 'Swahili', 'countryCode': 'KE', 'languageCode': 'sw'},
    {'language': 'Malay', 'countryCode': 'MY', 'languageCode': 'ms'},
    {'language': 'Tamil', 'countryCode': 'IN', 'languageCode': 'ta'},
    {'language': 'Telugu', 'countryCode': 'IN', 'languageCode': 'te'},
    {'language': 'Marathi', 'countryCode': 'IN', 'languageCode': 'mr'},
    {'language': 'Gujarati', 'countryCode': 'IN', 'languageCode': 'gu'},
    {'language': 'Serbian', 'countryCode': 'RS', 'languageCode': 'sr'},
    {'language': 'Croatian', 'countryCode': 'HR', 'languageCode': 'hr'},
    {'language': 'Slovak', 'countryCode': 'SK', 'languageCode': 'sk'},
    {'language': 'Bulgarian', 'countryCode': 'BG', 'languageCode': 'bg'},
    {'language': 'Lithuanian', 'countryCode': 'LT', 'languageCode': 'lt'},
    {'language': 'Latvian', 'countryCode': 'LV', 'languageCode': 'lv'},
    {'language': 'Estonian', 'countryCode': 'EE', 'languageCode': 'et'},
    {'language': 'Maltese', 'countryCode': 'MT', 'languageCode': 'mt'},
    {'language': 'Georgian', 'countryCode': 'GE', 'languageCode': 'ka'},
    {'language': 'Albanian', 'countryCode': 'AL', 'languageCode': 'sq'},
    {'language': 'Armenian', 'countryCode': 'AM', 'languageCode': 'hy'},
    {'language': 'Urdu', 'countryCode': 'PK', 'languageCode': 'ur'},
    {'language': 'Kazakh', 'countryCode': 'KZ', 'languageCode': 'kk'},
    {'language': 'Azerbaijani', 'countryCode': 'AZ', 'languageCode': 'az'},
    {'language': 'Tajik', 'countryCode': 'TJ', 'languageCode': 'tg'},
    {'language': 'Uzbek', 'countryCode': 'UZ', 'languageCode': 'uz'},
    {'language': 'Macedonian', 'countryCode': 'MK', 'languageCode': 'mk'},
    {'language': 'Icelandic', 'countryCode': 'IS', 'languageCode': 'is'},
    {'language': 'Belarusian', 'countryCode': 'BY', 'languageCode': 'be'},
    {'language': 'Afrikaans', 'countryCode': 'ZA', 'languageCode': 'af'},
  ];

  // Reactive properties
  RxString leftLanguage = 'English'.obs;
  RxString rightLanguage = 'Spanish'.obs;

  // Swap the selected languages
  void swapLanguages() {
    String temp = leftLanguage.value;
    leftLanguage.value = rightLanguage.value;
    rightLanguage.value = temp;
  }

  RxList<Map<String, String>> filteredLanguages = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredLanguages.value = languages;
  }

  void filterLanguages(String query) {
    if (query.isEmpty) {
      filteredLanguages.value = languages;
    } else {
      filteredLanguages.value = languages
          .where((lang) => lang['language']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  void updateLeftLanguage(String language) {
    leftLanguage.value = language;
  }

  void updateRightLanguage(String language) {
    rightLanguage.value = language;
  }

  String? getCountryCode(String language) {
    final languageEntry = languages.firstWhere(
          (element) => element['language']?.toLowerCase() == language.toLowerCase(),
      orElse: () => {},
    );

    return languageEntry['countryCode'];
  }
}
