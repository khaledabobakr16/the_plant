
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hidden_drawer/flutter_hidden_drawer.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// ignore: unnecessary_import
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';
import 'ui/features/auth/register/agree_terms_provider.dart';
import 'ui/features/onboarding/onboarding_provider.dart';
import 'ui/features/splash/splash_screen.dart';
import 'utils/theme.dart';
int? initScreen;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
    _setInitScreen();
     SystemChrome.setEnabledSystemUIMode(
        SystemUiMode.edgeToEdge,
    );
    //  await Firebase.initializeApp();
    await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness:Brightness.dark,
    statusBarColor: Colors.transparent,
    ));
  // runApp(const CleanHouseApp());
    runApp( const CleanHouseApp());
}

class CleanHouseApp extends StatelessWidget {
  const CleanHouseApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => OnboardingProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AgreeTermsProvider(),
        ),
           ChangeNotifierProvider(
          create: (context) => DrawerMenuState(),
        ),
      ],

      child:const StartApp(), 
    );
  }
}
class StartApp extends StatelessWidget {
  const StartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
    localizationsDelegates: const [
      S.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
      ],
      title: 'The Plant',
      theme:Themes.light,
      home:  const SplashScreen(),
    );
 
  }
}


void _setInitScreen() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
}
