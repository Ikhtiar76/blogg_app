import 'dart:io';
import 'package:blogg_app/core/error/exceptions.dart';
import 'package:blogg_app/features/blog/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel blogModel);
  Future<String> uploadBlogImage(File image, BlogModel blogModel);
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;
  BlogRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<String> uploadBlogImage(File image, BlogModel blogModel) async {
    try {
      await supabaseClient.storage
          .from('blog_images')
          .upload(blogModel.id, image);
      return supabaseClient.storage
          .from('blog_images')
          .getPublicUrl(blogModel.id);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<BlogModel> uploadBlog(BlogModel blogModel) async {
    try {
      final blogData = await supabaseClient
          .from('blogs')
          .insert(blogModel.toJson())
          .select();
      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final blogs = await supabaseClient
          .from('blogs')
          .select('*, profiles (name)');
      return blogs
          .map(
            (e) => BlogModel.fromJson(
              e,
            ).copyWith(posterName: e['profiles']['name']),
          )
          .toList();
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
