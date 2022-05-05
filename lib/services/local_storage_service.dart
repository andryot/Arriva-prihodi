import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/logger.dart';

class LocalStorageService {
  final SharedPreferences sharedPreferences;
  static LocalStorageService? _instance;
  static LocalStorageService get instance => _instance!;

  LocalStorageService._({required this.sharedPreferences});

  factory LocalStorageService(SharedPreferences _sharedPreferences) {
    if (_instance != null) {
      throw StateError('LocalStorageService already created');
    }

    _instance = LocalStorageService._(sharedPreferences: _sharedPreferences);
    return _instance!;
  }

  static const String _profileImage = 'profile_image';
  Future<String> get _imagesPath async =>
      '${(await getApplicationDocumentsDirectory()).path}/images';

  Future<Uint8List?> readProfileImage(String userId) async {
    try {
      final File f = File(
        '${await _imagesPath}${Platform.pathSeparator}$userId',
      );
      final Uint8List image = await f.readAsBytes();
      Logger.instance.info(
        'LocalStorageService.readProfileImage',
        'profile image read   $userId',
      );
      return image;
    } catch (_) {
      return null;
    }
  }
}
