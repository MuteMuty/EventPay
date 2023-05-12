import 'package:flutter/cupertino.dart';

import '../../screens/tabs/kartice.dart';
import '../../screens/tabs/profil.dart';
import '../../screens/tabs/dogodki.dart';

List<Widget> pageList = const [
  KarticeTab(),
  DogodkiTab(),
  ProfilTab(),
];

final List<GlobalKey<NavigatorState>> keys = [
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>(),
  GlobalKey<NavigatorState>()
];
