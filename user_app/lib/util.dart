import 'package:encrypt/encrypt.dart';
import 'dart:convert';

class AESUtil {
  static final key = Key.fromUtf8("1234567890abcdef"); // 16 bytes
  static final iv = IV.fromUtf8("abcdef1234567890");  // 16 bytes

  static String encrypt(String plainText) {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    return base64Encode(encrypted.bytes); // base64 encoded
  }
}