import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swifty_companion/business_logic/cubit/user_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swifty_companion/core/theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        final profile = state.profile;
        return Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                CustomPaint(
                  painter: LiquidPainter(),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20, left: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Positioned(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                profile.image['versions']['medium'] ??
                                    profile.image['versions']['small'] ??
                                    profile.image['link'] ??
                                    'https://img.freepik.com/free-psd/3d-render-avatar-character_23-2150611765.jpg',
                              ),
                              radius: 45,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${profile.firstName} ${profile.lastName}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black26,
                                    blurRadius: 2,
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Container(
                              height: 70,
                              width: 200,
                              child: LinearPercentIndicator(
                                lineHeight: 20,
                                percent: profile.cursusUsers[0]['level'] / 100,
                                progressColor: AppTheme.mainColor,
                                backgroundColor: Colors.white,
                                animation: true,
                                animateFromLastPercent: true,
                                center: Text(
                                  '${profile.cursusUsers[0]['level']}%',
                                  style: const TextStyle(
                                    color: AppTheme.secondaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: profile.achievements.length,
                    itemBuilder: (context, index) {
                      final achievement = profile.achievements[index];
                      return ListTile(
                        title: Text(
                          achievement['name'],
                          style: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        subtitle: Text(
                          achievement['description'],
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        leading: SvgPicture.network(
                          achievement['image'].toString().replaceFirst(
                              '/uploads/', 'https://cdn.intra.42.fr/'),
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.error);
                          },
                          placeholderBuilder: (context) {
                            return const CircularProgressIndicator();
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LiquidPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = const LinearGradient(
        colors: [AppTheme.mainColor, Color(0xFF5FC6FF)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path()
      ..lineTo(0, size.height * 0.8)
      ..cubicTo(
        size.width * 0.25,
        size.height * 0.65,
        size.width * 0.25,
        size.height * 0.35,
        size.width * 0.5,
        size.height * 0.5,
      )
      ..cubicTo(
        size.width * 0.75,
        size.height * 0.65,
        size.width * 0.75,
        size.height * 0.35,
        size.width,
        size.height * 0.5,
      )
      ..lineTo(size.width, 0)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
