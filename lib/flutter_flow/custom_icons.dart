import 'package:flutter/widgets.dart';

class FFIcons {
  FFIcons._();

  static const String _naviconFamily = 'Navicon';
  static const String _icon1Family = 'Icon1';
  static const String _settingFamily = 'Setting';
  static const String _peopleFamily = 'People';
  static const String _profileFamily = 'Profile';
  static const String _icon2Family = 'Icon2';
  static const String _footFamily = 'Foot';
  static const String _playbackFamily = 'Playback';

  // navicon
  static const IconData kclipboard =
      IconData(0xe900, fontFamily: _naviconFamily);
  static const IconData ksetting = IconData(0xe901, fontFamily: _naviconFamily);
  static const IconData khealthcare =
      IconData(0xe902, fontFamily: _naviconFamily);
  static const IconData khome = IconData(0xe903, fontFamily: _naviconFamily);

  // icon1
  static const IconData kbloodPressure =
      IconData(0xe900, fontFamily: _icon1Family);
  static const IconData kbloodSugar =
      IconData(0xe901, fontFamily: _icon1Family);
  static const IconData klamp = IconData(0xe902, fontFamily: _icon1Family);
  static const IconData knotificationBell =
      IconData(0xe903, fontFamily: _icon1Family);
  static const IconData ko2 = IconData(0xe904, fontFamily: _icon1Family);

  // setting
  static const IconData kbubbleChat =
      IconData(0xe900, fontFamily: _settingFamily);
  static const IconData kdocument =
      IconData(0xe901, fontFamily: _settingFamily);
  static const IconData kheart = IconData(0xe902, fontFamily: _settingFamily);
  static const IconData kinsurance =
      IconData(0xe903, fontFamily: _settingFamily);
  static const IconData kmenuButton =
      IconData(0xe904, fontFamily: _settingFamily);
  static const IconData knotification =
      IconData(0xe905, fontFamily: _settingFamily);
  static const IconData kuser = IconData(0xe906, fontFamily: _settingFamily);

  // people
  static const IconData kpeople = IconData(0xe900, fontFamily: _peopleFamily);

  // profile
  static const IconData kold = IconData(0xe900, fontFamily: _profileFamily);
  static const IconData kheight = IconData(0xe901, fontFamily: _profileFamily);
  static const IconData kgenders = IconData(0xe902, fontFamily: _profileFamily);
  static const IconData kweights = IconData(0xe903, fontFamily: _profileFamily);

  // icon2
  static const IconData kthermometer =
      IconData(0xe900, fontFamily: _icon2Family);
  static const IconData kdailyHealthApp =
      IconData(0xe901, fontFamily: _icon2Family);

  // foot
  static const IconData kfootsteps = IconData(0xe900, fontFamily: _footFamily);

  // playback
  static const IconData kprevious =
      IconData(0xe900, fontFamily: _playbackFamily);
  static const IconData knext = IconData(0xe901, fontFamily: _playbackFamily);
}
