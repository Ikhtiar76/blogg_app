import 'dart:io';

import 'package:blogg_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  BlogBloc({required UploadBlog uploadBlog})
    : _uploadBlog = uploadBlog,
      super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<UploadBlogEvent>(_onBlogUpload);
  }
  void _onBlogUpload(UploadBlogEvent event, Emitter<BlogState> emit) async {
    final result = await _uploadBlog(
      UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        topics: event.topics,
        image: event.image,
      ),
    );
    result.fold(
      (l) => emit(BlogFailure(message: l.message)),
      (r) => emit(BlogSuccess()),
    );
  }
}
