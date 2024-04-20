import 'package:aescryptojs/aescryptojs.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DataEncrypt {
  static wrappingEncrypted(var data) {
    // Todo: datanin sifrelenmesi islemi
    final unencryptedData = data.toString();
    final key = '${dotenv.env['ENCRYPT_KEY']}';
    final encryptedData = encryptAESCryptoJS(unencryptedData, key);
    return encryptedData;
  }

  static wrappingDecrypted(var data) {
    // Todo: sifrenin cozumlenmesi islemi
    final key = '${dotenv.env['ENCRYPT_KEY']}';
    final decryptedData = decryptAESCryptoJS(data, key);
    return decryptedData;
  }
}
