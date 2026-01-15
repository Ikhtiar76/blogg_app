import 'package:blogg_app/core/error/failures.dart';
import 'package:blogg_app/core/usecase/usecase.dart';
import 'package:blogg_app/features/blog/domain/entities/blog.dart';
import 'package:blogg_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements Usecase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;
  GetAllBlogs({required this.blogRepository});
  @override
  Future<Either<Failure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
