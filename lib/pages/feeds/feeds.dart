import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:timeago/timeago.dart' as timeago;
import '../feeds/post_widget.dart';
import 'package:url_launcher/url_launcher.dart'; // Import this package

class FeedsPage extends StatelessWidget {
  final String email;

  const FeedsPage({super.key, required this.email});

  Future<Map<String, dynamic>> fetchUserData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:5000/api/users?email=$email'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load user data');
    }
  }

  Future<List<dynamic>> fetchPosts() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:5000/api/posts'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  }

  String formatPostDate(String createdAt) {
    DateTime postTime = DateTime.parse(createdAt);
    return timeago.format(postTime); // Converts the DateTime to "2 days ago", "3 hours ago", etc.
  }

  Future<void> _launchURL() async {
    const url = 'http://10.0.2.2:5000/hello.html'; // Adjust the URL to your needs
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<Map<String, dynamic>>(
          future: fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            } else if (snapshot.hasError) {
              return const Text('Error loading user data');
            } else if (snapshot.hasData) {
              final userData = snapshot.data!;
              return Row(
                children: [
                  Expanded(
                    child: Text(userData['name'] ?? 'User'),
                  ),
                  IconButton(
                    icon: const Icon(Icons.camera_alt),
                    onPressed: _launchURL, // Calls the _launchURL method when clicked
                  ),
                ],
              );
            } else {
              return const Text('No user data found.');
            }
          },
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: fetchPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final posts = snapshot.data!;
            return Column(
              children: [
                if (posts.isNotEmpty)
                  Expanded(
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        final user = post['userId']; // Get user details populated with the post
                        return PostWidget(
                          profileImage: user['profileImage'] ?? 'http://10.0.2.2:5000${post['photo']}',
                          name: user['name'] ?? 'Unknown',  // Display the user's name based on userId
                          postDate: formatPostDate(post['createdAt']),  // Format the post date using timeago
                          postImage: post['photo'] != null
                              ? 'http://10.0.2.2:5000${post['photo']}'
                              : 'https://via.placeholder.com/600x400',
                          description: post['caption'] ?? 'No description available.',
                        );
                      },
                    ),
                  ),
              ],
            );
          } else {
            return const Center(child: Text('No posts found.'));
          }
        },
      ),
    );
  }
}
