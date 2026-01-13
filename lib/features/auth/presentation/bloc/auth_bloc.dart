import 'package:blogg_app/core/cubits/app_user/app_user_cubit.dart';
import 'package:blogg_app/core/usecase/usecase.dart';
import 'package:blogg_app/core/common/entities/user.dart';
import 'package:blogg_app/features/auth/domain/usecases/current_user.dart';
import 'package:blogg_app/features/auth/domain/usecases/user_login.dart';
import 'package:blogg_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserLogin _userLogin;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserLogin userLogin,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  }) : _userSignUp = userSignUp,
       _userLogin = userLogin,
       _currentUser = currentUser,
       _appUserCubit = appUserCubit,
       super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));
    on<AuthSignUpEvent>(_onAuthSignUp);
    on<AuthLoginEvent>(_onAuthLogin);
    on<AuthIsUserLoggedInEvent>(_isUserLoggedIn);
  }
  void _isUserLoggedIn(
    AuthIsUserLoggedInEvent event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());
    res.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onAuthSignUp(AuthSignUpEvent event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(
      UserSignUpParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    res.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _onAuthLogin(AuthLoginEvent event, Emitter<AuthState> emit) async {
    final res = await _userLogin(
      UserLoginParams(email: event.email, password: event.password),
    );
    res.fold(
      (l) => emit(AuthFailure(message: l.message)),
      (r) => _emitAuthSuccess(r, emit),
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user: user));
  }
}
