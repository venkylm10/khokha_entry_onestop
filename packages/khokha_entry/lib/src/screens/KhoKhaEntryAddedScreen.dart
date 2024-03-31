import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../globals/my_colors.dart';

class KhoKhaEntryAddedScreen extends StatelessWidget {
  const KhoKhaEntryAddedScreen({super.key});

  Future<Map<String, dynamic>> getEntryData() async {
    final prefs = await SharedPreferences.getInstance();
    final data = await prefs.getString("entry_data");
    return jsonDecode(data!);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return AlertDialog(
      backgroundColor: kAppBarGrey,
      surfaceTintColor: Colors.transparent,
      content: Center(
        child: FutureBuilder(
            future: getEntryData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator(color: lBlue2);
              }
              final data = snapshot.data!;
              final time = DateTime.parse(data['createdAt']);
              final destination = data['destination'];
              return InkWell(
                onTap: () {},
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    Text("Entry Added at: ${time.hour}: ${time.minute}"),
                    Text("Destination: $destination"),
                  ],
                ),
              );
            }),
      ),
    );
  }
}