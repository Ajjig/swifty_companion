import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swifty_companion/core/theme.dart';
import 'package:swifty_companion/data/models/profile_model.dart';

class ProfilePageView extends StatelessWidget {
  final ProfileModel profile;

  const ProfilePageView({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    print('=====' * 10);
    print(profile.projectsUsers);
    print('=====' * 10);
    return Expanded(
      child: TabBarView(
        physics: const BouncingScrollPhysics(),
        children: [
          (profile.cursusUsers[profile.lastCursusIndex]['skills'] != null &&
                  profile.cursusUsers[profile.lastCursusIndex]['skills']
                          .length >
                      2)
              ? RadarChart(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  RadarChartData(
                    // Add this line to set fixed max value
                    tickCount: 3,
                    ticksTextStyle: const TextStyle(
                      color: Colors.black,
                      fontSize: 5,
                    ),
                    titlePositionPercentageOffset: 0.1,
                    radarBorderData:
                        const BorderSide(color: Colors.black, width: 0.75),
                    tickBorderData: const BorderSide(
                        color: AppTheme.secondaryColor, width: 0.1),
                    getTitle: (index, max) {
                      return RadarChartTitle(
                        text: profile.cursusUsers[profile.lastCursusIndex]
                                ['skills'][index]['name']
                            .toString(),
                      );
                    },
                    radarBackgroundColor: Colors.white,
                    radarShape: RadarShape.polygon,
                    gridBorderData:
                        const BorderSide(color: Colors.grey, width: 0.5),
                    titleTextStyle: const TextStyle(
                      color: AppTheme.secondaryColor,
                      fontSize: 6.5,
                    ),
                    isMinValueAtCenter: false,
                    dataSets: [
                      RadarDataSet(
                        entryRadius: 0,
                        borderWidth: 0,
                        borderColor: Colors.transparent,
                        fillColor: Colors.transparent,
                        dataEntries: [
                          for (final _ in profile
                              .cursusUsers[profile.lastCursusIndex]['skills'])
                            RadarEntry(
                              value: 21,
                            ),
                        ],
                      ),
                      RadarDataSet(
                        entryRadius: 2.5,
                        borderWidth: 1,
                        borderColor: AppTheme.mainColor,
                        dataEntries: [
                          for (final skill in profile
                              .cursusUsers[profile.lastCursusIndex]['skills'])
                            RadarEntry(
                              value: skill['level'] ?? 0,
                            ),
                        ],
                      ),
                    ],
                  ),
                )
              : profile.cursusUsers[profile.lastCursusIndex]['skills'] != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (final skill in profile
                            .cursusUsers[profile.lastCursusIndex]['skills'])
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                skill['name'].toString(),
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                skill['level'].toString(),
                                style: const TextStyle(
                                  color: AppTheme.mainColor,
                                ),
                              ),
                            ],
                          ),
                      ],
                    )
                  : const Center(
                      child: Text(
                        'No skills available',
                        style: TextStyle(
                          color: AppTheme.mainColor,
                        ),
                      ),
                    ),
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
                      (project['status'] ?? 'No status')
                          .toString()
                          .replaceAll('_', ' '),
                      style: const TextStyle(
                        color: AppTheme.mainColor,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      project['status'] != 'finished'
                          ? ''
                          : project['validated?'] == true
                              ? 'Validated with ${project['final_mark'] ?? 0} score'
                              : 'Failed with ${project['final_mark'] ?? 0} score',
                      style: TextStyle(
                        color: project['validated?'] == true
                            ? Colors.green
                            : Colors.redAccent,
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
                  achievement['image']
                      .toString()
                      .replaceFirst('/uploads/', 'https://cdn.intra.42.fr/'),
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
        ],
      ),
    );
  }
}
