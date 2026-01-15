import 'dart:io';

import 'package:blogg_app/core/error/failures.dart';
import 'package:blogg_app/core/usecase/usecase.dart';
import 'package:blogg_app/features/blog/domain/entities/blog.dart';
import 'package:blogg_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements Usecase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;
  UploadBlog({required this.blogRepository});
  @override
  Future<Either<Failure, Blog>> call(UploadBlogParams params) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      title: params.title,
      content: params.content,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final String posterId;
  final String title;
  final String content;
  final List<String> topics;
  final File image;

  UploadBlogParams({
    required this.posterId,
    required this.title,
    required this.content,
    required this.topics,
    required this.image,
  });
}
