import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/constants.dart';
import 'simple_data.dart';

class SharedPreferencesImpl implements SimpleData {
  final SharedPreferences _instance;

  SharedPreferencesImpl(this._instance);

  @override
  Future<bool> getFirstAccess() async {
    return _instance.getBool(Constants.firstAccessKey) ?? true;
  }

  @override
  Future<bool> setFirstAccess(bool value) async {
    return _instance.setBool(Constants.firstAccessKey, value);
  }
}
