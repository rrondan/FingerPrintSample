import 'package:biometrics_sample/utils/biometric_util.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter/services.dart';


class BiometricScreen extends StatefulWidget {
  @override
  _BiometricScreenState createState() => _BiometricScreenState();
}

class _BiometricScreenState extends State<BiometricScreen> {

  bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  BiometricUtil _biometricUtil;
  String _authorized = 'Not Authorized';

  void _checkBiometrics() async{
    _canCheckBiometrics = await _biometricUtil.checkBiometric();
    setState((){});
  }

  void _getAvailableBiometrics() async{
    _availableBiometrics = await _biometricUtil.getListOfBiometricTypes();
    setState(() {});
  }

  void _authenticate() async{
    bool authenticated = await _biometricUtil.authorizeNow();
    setState(() {
      _authorized = authenticated ? 'Authorized' : 'Not Authorized';
    });
  }


  @override
  void initState() {
    _biometricUtil = new BiometricUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometrics Sample'),
      ),
      body: ConstrainedBox(
          constraints: const BoxConstraints.expand(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Can check biometrics: $_canCheckBiometrics'),
                RaisedButton(
                  child: const Text('Check biometrics'),
                  onPressed: _checkBiometrics,
                ),
                SizedBox(height: 24.0,),
                Text('Available biometrics: $_availableBiometrics'),
                RaisedButton(
                  child: const Text('Get available biometrics'),
                  onPressed: _getAvailableBiometrics,
                ),
                SizedBox(height: 24.0,),
                Text('Current State: $_authorized'),
                RaisedButton(
                  child: const Text('Authenticate'),
                  onPressed: _authenticate,
                )
              ])),
    );
  }
}
