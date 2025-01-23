import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swifty_companion/business_logic/cubit/profile_cubit.dart';
import 'package:swifty_companion/business_logic/cubit/user_cubit.dart';
import 'package:swifty_companion/data/providers/auth_api_provider.dart';
import 'package:swifty_companion/presentation/views/home_screen.dart';
import 'package:swifty_companion/presentation/views/login_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appLinks = AppLinks();
  appLinks.uriLinkStream.listen((Uri uri) {
    AuthApiProvider.callback(uri);
  });
  await AuthApiProvider.init();

  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(),
        ),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'Swifty companion',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
        },
      ),
    );
  }
}
