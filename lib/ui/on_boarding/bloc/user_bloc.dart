import 'dart:math';

import 'package:ecommerce/data/remote/helpers/api_helpers.dart';
import 'package:ecommerce/domain/constants/app_constants.dart';
import 'package:ecommerce/domain/constants/app_urls.dart';
import 'package:ecommerce/ui/on_boarding/bloc/user_event.dart';
import 'package:ecommerce/ui/on_boarding/bloc/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/remote/models/user_model.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  ApiHelpers apiHelpers;

  UserBloc({required this.apiHelpers}) : super(UserInitialState()) {


    on<LoginUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        dynamic data = await apiHelpers.postApi(
          isAuth: true,
          url: AppUrls.URL_LOGIN,
          mBodyParams: {"email": event.email, "password": event.password},
        );
        if (data['status']) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(AppConstants.PREF_TOKEN_KEY, data['tokan']);
          emit(UserSuccessState());
        } else {
          emit(UserFailureState(errorMsg: data['message']));
        }
      } catch (e) {
        emit(UserFailureState(errorMsg: e.toString()));
      }
    });

    on<RegisterUserEvent>((event, emit) async {
      emit(UserLoadingState());
      try {
        dynamic data = await apiHelpers.postApi(
          isAuth: true,
          url: AppUrls.URL_SIGNUP,
          mBodyParams: {
            "name": event.name,
            "mobile_number": event.mobNo,
            "email": event.email,
            "password": event.password,
          },
        );
        if (data['status']) {
          emit(UserSuccessState());
        } else {
          emit(UserFailureState(errorMsg: data['message']));
        }
      } catch (e) {
        emit(UserFailureState(errorMsg: e.toString()));
      }
    });

    on<FetchUserDetails>((event, emit) async {
      emit(UserLoadingState());
      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? token = prefs.getString(AppConstants.PREF_TOKEN_KEY);

        if (token != null && token.isNotEmpty) {
          dynamic data = await apiHelpers.postApi(
            url: AppUrls.URL_PROFILE,
          );
          if (data['status'] == true || data['status'] == 'true') {
            var userData = data['data'] ?? data['user'] ?? data;
            UserModel user = UserModel.fromJson(userData);
            emit(UserSuccessState(userModel: user));
          } else {
            emit(UserFailureState(errorMsg: data['message'] ?? 'Failed to fetch user profile'));
          }
        } else {
          emit(
            UserFailureState(errorMsg: 'No User Found!, Please Login again.'),
          );
        }
      } catch (e) {
        emit(UserFailureState(errorMsg: e.toString()));
      }
    });
  }
}
