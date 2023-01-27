import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';


import '../screens/landing_screen.dart';

class VendorAuth extends StatefulWidget {
  const VendorAuth({Key? key}) : super(key: key);

  @override
  State<VendorAuth> createState() => _VendorAuthState();
}

class _VendorAuthState extends State<VendorAuth> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      // If the user is already signed-in, use it as initial data
      initialData: FirebaseAuth.instance.currentUser,
      builder: (context, snapshot) {
        // User is not signed in
        if (!snapshot.hasData) {
          return  const SignInScreen(
              providerConfigs: [
                EmailProviderConfiguration(),
                GoogleProviderConfiguration(clientId: '1:252432202808:android:bd49e2b8d28d311c1abacd'),
                PhoneProviderConfiguration(),
              ]
          );
        }

        // Render your application if authenticated
        return const LandingScreen();
      },
    );
  }
}
