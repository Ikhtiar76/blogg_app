import 'package:blogg_app/core/error/exceptions.dart';
import 'package:blogg_app/core/error/failures.dart';
import 'package:blogg_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blogg_app/features/auth/data/model/user_model.dart';
import 'package:blogg_app/features/auth/domain/entities/user.dart';
import 'package:blogg_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource});
  @override
  Future<Either<Failure, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> signUpWithNameEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userId = await authRemoteDataSource.signUpWithNameEmailPassword(
        name: name,
        email: email,
        password: password,
      );
      return right(userId);
    } on ServerException catch (e) {
      return left(Failure(message: e.message));
    }
  }
}
