import 'package:doctor_profile_ui/widgets/details_tile.dart';
import 'package:doctor_profile_ui/widgets/main_button.dart';
import 'package:doctor_profile_ui/widgets/profile_header.dart';
import 'package:flutter/material.dart';

class DoctorProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
        ),
        centerTitle: true,
        title: Text(
          'Doctor Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileHeader(),
              SizedBox(height: 20),
              Text(
                'About',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              Text(
                'Professor of Eye Special - Former Head of Department of Eye Special, Cairo University',
              ),
              SizedBox(height: 20),
              _buildLocationUi(),
              Divider(height: 20),
              SizedBox(height: 20),
              _buildContactUi(),
              SizedBox(height: 20),
              MainButton(
                bgColor: Colors.green,
                text: 'Call Doctor',
                onPressed: () {},
              ),
              SizedBox(height: 10),
              MainButton(text: 'Book Appointment', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildLocationUi() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.indigoAccent.withValues(alpha: .2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          DetailsTile(
            icon: Icons.local_hospital,
            label: 'Cairo University Hospital',
          ),
          SizedBox(height: 10),
          DetailsTile(
            icon: Icons.watch_later_rounded,
            label: '12:00 PM - 5:00 PM',
          ),
          SizedBox(height: 10),
          DetailsTile(icon: Icons.location_on_rounded, label: 'Cairo, Egypt'),
        ],
      ),
    );
  }

  Widget _buildContactUi() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Contact Info',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(height: 5),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigoAccent.withValues(alpha: .2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              DetailsTile(icon: Icons.mail, label: 'jVU5o@example.com'),
              SizedBox(height: 10),
              DetailsTile(icon: Icons.call, label: '0100000000'),
              SizedBox(height: 10),
              DetailsTile(icon: Icons.call, label: '012000000'),
            ],
          ),
        ),
      ],
    );
  }
}
