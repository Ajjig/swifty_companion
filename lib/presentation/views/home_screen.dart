import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swifty_companion/business_logic/cubit/profile_cubit.dart';
import 'package:swifty_companion/business_logic/cubit/user_cubit.dart';
import 'package:swifty_companion/core/theme.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:swifty_companion/presentation/widgets/liquid_painer.dart';
import 'package:swifty_companion/presentation/widgets/profile_details.dart';
import 'package:swifty_companion/presentation/widgets/profile_page_view.dart';

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
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        if (state is! ProfileLoaded) {
          if (state is ProfileError) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_off,
                      color: Colors.red,
                      size: 50,
                    ),
                    Text(
                      state.message.replaceFirst('Exception:', '').trim(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 20,
                          ),
                          label: const Text(
                            'Go back to search',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.mainColor,
                            minimumSize: const Size(220, 40),
                            maximumSize: const Size(220, 40),
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: () {
                            context.read<UserCubit>().logout();
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.redAccent,
                            size: 20,
                          ),
                          label: const Text('Logout',
                              style: TextStyle(color: Colors.redAccent)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            minimumSize: const Size(220, 40),
                            maximumSize: const Size(220, 40),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        }
        final profile = state.profile;
        profile.projectsUsers
            .removeWhere((element) => element['project']['parent_id'] != null);
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
                        Container(
                          decoration: BoxDecoration(
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
                          child: Hero(
                            tag: 'avatar',
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
                                  parseLevel(profile
                                          .cursusUsers[profile.lastCursusIndex]
                                      ['level'])['level'],
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
                                    percent: parseLevel(profile.cursusUsers[
                                            profile.lastCursusIndex]
                                        ['level'])['percentage'],
                                    progressColor: AppTheme.mainColor,
                                    backgroundColor: Colors.white,
                                    animation: true,
                                    animateFromLastPercent: true,
                                    center: Text(
                                      '${parseLevel(profile.cursusUsers[profile.lastCursusIndex]['level'])['percentageInt']}%',
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
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[500],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 60,
                  child: ProfileDetails(profile: profile),
                ),
                DefaultTabController(
                  length: 3,
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const TabBar(
                          tabs: [
                            Tab(text: 'Skills'),
                            Tab(text: 'Projects'),
                            Tab(text: 'Achievements'),
                          ],
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                        ),
                        const SizedBox(height: 10),
                        ProfilePageView(profile: profile)
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
