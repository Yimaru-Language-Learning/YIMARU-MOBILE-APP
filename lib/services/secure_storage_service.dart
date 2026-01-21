import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

extension BoolParsing on String {
  bool parseBool() {
    if (toLowerCase() == 'true') {
      return true;
    } else if (toLowerCase() == 'false') {
      return false;
    }

    throw '"$this" can not be parsed to boolean.';
  }
}

class SecureStorageService {
  // Create storage

  late final FlutterSecureStorage _storage;

  SecureStorageService() {
    _storage = Platform.isAndroid
        ? const FlutterSecureStorage(
            aOptions: AndroidOptions(
              encryptedSharedPreferences: true,
            ),
          )
        : const FlutterSecureStorage(
            iOptions: IOSOptions(),
          );
  }

  Future<void> clear() async {
    _storage.deleteAll();
  }

  Future<bool?> getBool(String key) async {
    String? result = await _storage.read(key: key);
    return result?.parseBool();
  }

  Future<String?> getString(String key) async {
    return await _storage.read(key: key);
  }

  Future<int?> getInt(String key) async {
    return await _storage.read(key: key) == null
        ? null
        : int.parse(await _storage.read(key: key) ?? '0');
  }

  Future<void> setString(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future<void> setInt(String key, int value) async {
    await _storage.write(key: key, value: value.toString());
  }

  Future<void> setBool(String key, bool value) async {
    await _storage.write(key: key, value: value.toString());
  }
}
