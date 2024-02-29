import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageManager {
  late final FlutterSecureStorage _storage;

  SecureStorageManager() {
    _storage = const FlutterSecureStorage(
      aOptions: AndroidOptions(
        encryptedSharedPreferences: true,
      ),
    );
  }

  Future updateValue(String key, String? value) async {
    await _storage.write(key: key, value: value);
  }

  Future<String?> getValue(String key) async {
    return await _storage.read(key: key);
  }

  Future deleteValue(String key) async {
    return await _storage.delete(key: key);
  }

  Future deleteAll() async {
    return await _storage.deleteAll();
  }
}
