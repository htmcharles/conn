import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart'; // For storing user data locally

class FeedsPage extends StatefulWidget {
  const FeedsPage({super.key});

  @override
  _FeedsPageState createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {
  List<dynamic> _feeds = []; // List to hold the fetched feeds
  final ImagePicker _picker = ImagePicker();
  String? _userToken; // Store user token locally

  @override
  void initState() {
    super.initState();
    _loadUserToken();
    _fetchFeeds(); // Fetch existing feeds when the page loads
  }

  // Load user token from local storage
  Future<void> _loadUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userToken = prefs.getString('userToken'); // Assume the token is saved as 'userToken'
    });
  }

  // Fetch existing feeds
  Future<void> _fetchFeeds() async {
    final response = await http.get(
      Uri.parse('http://10.0.2.2:5000/api/feeds'), // Update with your backend URL
      headers: {
        'Authorization': 'Bearer $_userToken', // Include the token in the request header
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        _feeds = json.decode(response.body); // Decode the JSON response
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to load feeds')),
      );
    }
  }

  // Upload image and associate it with the logged-in user
  Future<void> _uploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:5000/api/feeds'), // Update with your backend URL
      );

      // Add the image file to the request
      request.files.add(await http.MultipartFile.fromPath('image', image.path));

      // Add the user token to authenticate the request
      request.headers['Authorization'] = 'Bearer $_userToken'; // Include the token in the headers

      // Send the request
      final response = await request.send();

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Feed uploaded successfully!')),
        );
        _fetchFeeds(); // Refresh the feeds after uploading
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to upload feed')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feeds'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_a_photo),
            onPressed: _uploadImage, // Open image picker when tapped
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _feeds.length,
        itemBuilder: (context, index) {
          final feed = _feeds[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.network(feed['imageUrl']), // Replace with the actual field for image URL
                const SizedBox(height: 8),
                Text(feed['userName']), // Replace with the actual field for user name
                const SizedBox(height: 4),
                Text(feed['description'] ?? 'No description'), // Replace with the actual field for description
              ],
            ),
          );
        },
      ),
    );
  }
}
