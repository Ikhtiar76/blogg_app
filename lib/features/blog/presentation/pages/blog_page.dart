import 'package:blogg_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => const BlogPage());
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Blog Page'),
        actions: [
          IconButton(
            icon: Icon(CupertinoIcons.add_circled),
            onPressed: () {
              Navigator.push(context, AddNewBlogPage.route());
            },
          ),
        ],
      ),
    );
  }
}
