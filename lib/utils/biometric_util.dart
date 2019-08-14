import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';

class BiometricUtil {

  LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> checkBiometric() async {
    try {
      return await _localAuthentication.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<BiometricType>> getListOfBiometricTypes() async {
    try {
      if(await checkBiometric())
        return await _localAuthentication.getAvailableBiometrics();
      else
        return [];
    } on PlatformException catch (e) {
      print(e);
      return [];
    }

  }

  Future<bool> authorizeNow() async {
    try {
      return await _localAuthentication.authenticateWithBiometrics(
        localizedReason: "Ingreso con huella digital",
        androidAuthStrings: AndroidAuthMessages(
          cancelButton: "Cancelar",
          fingerprintHint: "Confirma tu huella digital",
          fingerprintNotRecognized: "Huella no reconocida",
          signInTitle: "Ingreso con huella digital",
        ),
        iOSAuthStrings: IOSAuthMessages(
            cancelButton: "Cancelar",
            goToSettingsButton: "Configuración",
            goToSettingsDescription: "Confirme su Touch ID.",
            lockOut: "Habilite su Touch ID"),
        useErrorDialogs: true,
        stickyAuth: true,
      );
    } on PlatformException catch (e) {
      print("ERROR: $e");
      return false;
    }
  }

}