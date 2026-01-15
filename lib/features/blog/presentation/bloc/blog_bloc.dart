import 'dart:io';

import 'package:blogg_app/core/usecase/usecase.dart';
import 'package:blogg_app/features/blog/domain/entities/blog.dart';
import 'package:blogg_app/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:blogg_app/features/blog/domain/usecases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final GetAllBlogs _getAllBlogs;
  final UploadBlog _uploadBlog;
  BlogBloc({required UploadBlog uploadBlog, required GetAllBlogs getAllBlogs})
    : _getAllBlogs = getAllBlogs,
      _uploadBlog = uploadBlog,
      super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogFetchAllBlogs>(_onFetchAllBlogs);
  }
  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
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
      (r) => emit(BlogUploadSuccess()),
    );
  }

  void _onFetchAllBlogs(
    BlogFetchAllBlogs event,
    Emitter<BlogState> emit,
  ) async {
    final result = await _getAllBlogs(NoParams());
    result.fold(
      (l) => emit(BlogFailure(message: l.message)),
      (r) => emit(BlogDisplaySuccess(blogs: r)),
    );
  }
}
