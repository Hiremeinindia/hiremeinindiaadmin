class Language {
  final int id;
  final String flag;
  final String langname;
  final String languageCode;

  Language(this.id, this.flag, this.langname, this.languageCode);

  static List<Language> languageList() {
    return <Language>[
      Language(1, "🇦🇫", "தமிழ்", "ta"),
      Language(2, "🇺🇸", "English", "en"),
      Language(3, "🇸🇦", "മലയാളം", "ml"),
      Language(4, "🇮🇳", "हिंदी", "hi")
    ];
  }
}
