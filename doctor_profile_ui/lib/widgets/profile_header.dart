import 'package:doctor_profile_ui/widgets/call_button.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: Image.network(
            'https://static.vecteezy.com/system/resources/thumbnails/046/380/882/small/3d-cute-cartoon-male-doctor-png.png',
            height: 140,
            width: 140,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dr. Ahmed Ali',
              style: TextStyle(
                color: Colors.indigo,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4),
            Text('Dentist', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star_rounded, color: Colors.orange),
                SizedBox(width: 3),
                Text('4.9', style: TextStyle(fontSize: 14)),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                CallButton(text: '1', onTap: () {}),
                SizedBox(width: 10),
                CallButton(text: '2', onTap: () {}),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
