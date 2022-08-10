import 'package:adaptive_app/src/adaptive.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/googleapis_auth.dart'; // Add this line
import 'package:provider/provider.dart';

import 'src/adaptive_login.dart';                     // Add this line
import 'src/app_state.dart';

// From https://developers.google.com/youtube/v3/guides/auth/installed-apps#identify-access-scopes
final scopes = [
  'https://www.googleapis.com/auth/youtube.readonly',
];

// TODO: Replace with your Client ID and Client Secret for Desktop configuration
final clientId = ClientId(
  'TODO-Client-ID.apps.googleusercontent.com',
  'TODO-Client-secret',
);
// To this line

void main() {
  runApp(ChangeNotifierProvider<AuthedUserPlaylists>(        // Modify this line
    create: (context) => AuthedUserPlaylists(), // Modify this line
    child: const PlaylistsApp(),
  ));
}

class PlaylistsApp extends StatelessWidget {
  const PlaylistsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your Playlists',            // Change FlutterDev to Your
      theme: FlexColorScheme.light(scheme: FlexScheme.red).toTheme,
      darkTheme: FlexColorScheme.dark(scheme: FlexScheme.red).toTheme,
      themeMode: ThemeMode.dark, // Or ThemeMode.System if you'd prefer
      debugShowCheckedModeBanner: false,
      // Modify from here
      home: AdaptiveLogin(
        builder: (context, authClient) {
          context.read<AuthedUserPlaylists>().authClient = authClient;
          return const AdaptivePlaylists();
        },
        clientId: clientId,
        scopes: scopes,
        loginButtonChild: const Text('Login to YouTube'),
      ),
    );
  }
}