import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:teste_fingerprint/details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  authenticate() async {
    if (await _isBiometricAvailable()) {
      await _getListOfBiometricTypes();
      await _authenticateUser();
    }
  }

  Future<bool> _isBiometricAvailable() async {
    bool isAvailable = await _localAuthentication.canCheckBiometrics;
    return isAvailable;
}

  Future<void> _getListOfBiometricTypes() async {
     await _localAuthentication.getAvailableBiometrics();
}

  Future<void> _authenticateUser() async {
    bool isAuthenticated =
      await _localAuthentication.authenticate(
    biometricOnly: true,
    localizedReason: "Use a digital",
  );

      if (!isAuthenticated) return;
        Navigator.of(context).push(
          MaterialPageRoute(builder: ((context) => const DetailsPage()
        )
      )
    );
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body:  Center(
        child: ElevatedButton(onPressed: authenticate,
          child: const Text("Entrar"))
      )
    );
  }
}