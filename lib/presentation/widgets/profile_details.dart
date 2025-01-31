import 'package:flutter/material.dart';
import 'package:swifty_companion/data/models/profile_model.dart';

class ProfileDetails extends StatelessWidget {
  const ProfileDetails({
    super.key,
    required this.profile,
  });

  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Wallet',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 9,
                color: Colors.white,
              ),
            ),
            Text(
              '₳${profile.wallet}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CP',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 9,
                color: Colors.white,
              ),
            ),
            Text(
              profile.correctionPoint.toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Location',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 9,
                color: Colors.white,
              ),
            ),
            Text(
              profile.location,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: profile.location != 'Not available'
                    ? Colors.green
                    : Colors.deepOrange,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Grade',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 9,
                color: Colors.white,
              ),
            ),
            Text(
              profile.cursusUsers[1]['grade'] ?? 'None',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    );
  }
}
