import 'package:flutter/material.dart';
import 'package:yummy_app/post_section_screen/components/post_card.dart';
import 'package:yummy_app/models/models.dart';

class PostSection extends StatelessWidget {
  final List<Post> posts;
  const PostSection({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 16.0, bottom: 8.0),
            child: Text(
              "Friend's Activity",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ListView.separated(
              primary: false,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return PostCard(post: posts[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 1.0,
                );
              },
              itemCount: posts.length),
        ],
      ),
    );
  }
}
