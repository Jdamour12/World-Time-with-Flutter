import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> data = {}; // Use proper typing for clarity

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    if (route != null && route.settings.arguments is Map<String, dynamic>) {
      data = data.isNotEmpty
          ? data
          : route.settings.arguments as Map<String, dynamic>;
    } else {
      data = {
        'location': 'Loading...',
        'time': '...',
        'isDayTime': true, // Default to daytime if null
        'flag': 'default.png',
      };
      print("Warning: Expected Map arguments not provided or of incorrect type.");
    }

    // Safely extract isDayTime, default to true if null
    bool isDayTime = data['isDayTime'] ?? true;
    String bgImage = isDayTime ? 'day.png' : 'night.png';
    Color bgColor = isDayTime ? Colors.blue : (Colors.indigo[700] ?? Colors.indigo);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async {
                    dynamic result =
                    await Navigator.pushNamed(context, '/location');

                    if (result is Map<String, dynamic>) {
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDayTime': result['isDayTime'],
                          'flag': result['flag'],
                        };
                      });
                    }
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data['location'] ?? 'Loading...',
                      style: const TextStyle(
                        fontSize: 28,
                        letterSpacing: 2.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  data['time'] ?? '...',
                  style: const TextStyle(
                    fontSize: 66.0,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
