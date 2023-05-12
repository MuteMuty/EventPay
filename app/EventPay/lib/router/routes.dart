/// Defines all possible routes for EventPay app.
abstract class EPRoute {
  static const String initial = '/';
  static const String signIn = '/signIn';
  static const String registration = '/register';
  static const String root = '/root';
  static const String kartice = '/kartice';
  static const String dogodki = '/dogodki';
  static const String profil = '/profil';
  static const List<String> tabNames = [kartice, dogodki, profil];
  static const String karticaDetailsScreen = '/karticaDetailsScreen';
  static const String dogodkiDetailsScreen = '/dogodkiDetailsScreen';
  static const String fillUpCard = '/card/fillUp';
}
