import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swifty_companion/business_logic/cubit/user_cubit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swifty_companion/core/theme.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Map parseLevel(double? level) {
    level ??= 0;
    final int intLevel = level.toInt();
    final double percentage = (level - intLevel).toDouble();
    final int percantageInt = (percentage * 100).toInt();
    return {
      'level': '$intLevel',
      'percentage': percentage,
      'percentageInt': percantageInt,
    };
  }

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
        profile.projectsUsers
            .removeWhere((element) => element['project']['parent_id'] != null);
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: () => {},
            child: const Icon(
              Icons.search,
              color: AppTheme.mainColor,
            ),
          ),
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
                            Row(
                              children: [
                                Text(
                                  parseLevel(
                                      profile.cursusUsers[1]['level'])['level'],
                                  style: const TextStyle(
                                    color: AppTheme.mainColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 70,
                                  width: 200,
                                  child: LinearPercentIndicator(
                                    lineHeight: 20,
                                    percent: parseLevel(profile.cursusUsers[1]
                                        ['level'])['percentage'],
                                    progressColor: AppTheme.mainColor,
                                    backgroundColor: Colors.white,
                                    animation: true,
                                    animateFromLastPercent: true,
                                    center: Text(
                                      '${parseLevel(profile.cursusUsers[1]['level'])['percentageInt']}%',
                                      style: const TextStyle(
                                        color: AppTheme.secondaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        const TabBar(
                          tabs: [
                            Tab(text: 'Projects'),
                            Tab(text: 'Achievements'),
                          ],
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                        ),
                        Expanded(
                          child: TabBarView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              ListView.builder(
                                itemCount: profile.projectsUsers.length,
                                itemBuilder: (context, index) {
                                  final project = profile.projectsUsers[index];
                                  return ListTile(
                                    title: Text(
                                      project['project']['name'],
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    subtitle: Row(
                                      children: [
                                        Text(
                                          project['status'] ?? 'No status',
                                          style: const TextStyle(
                                            color: AppTheme.mainColor,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          project['validated?'] != null
                                              ? 'Validated with ${project['final_mark'] ?? 0} score'
                                              : 'Not validated',
                                          style: TextStyle(
                                            color: project['validated?'] != null
                                                ? Colors.green
                                                : Colors.orange,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              ListView.builder(
                                itemCount: profile.achievements.length,
                                itemBuilder: (context, index) {
                                  final achievement =
                                      profile.achievements[index];
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
                                      achievement['image']
                                          .toString()
                                          .replaceFirst('/uploads/',
                                              'https://cdn.intra.42.fr/'),
                                      width: 50,
                                      height: 50,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return const Icon(Icons.error);
                                      },
                                      placeholderBuilder: (context) {
                                        return const CircularProgressIndicator();
                                      },
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
