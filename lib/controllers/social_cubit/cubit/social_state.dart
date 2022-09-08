part of 'social_cubit.dart';

abstract class SocialState {}

class SocialInitial extends SocialState {}

class SocialGetUserLoadingState extends SocialState {}

class SocialGetUserSuccessState extends SocialState {}

class SocialGetUserErrorState extends SocialState {
  final String error;
  SocialGetUserErrorState(this.error);
}

class SocialupdateUserSuccessState extends SocialState {}

class SocialUpdateUserErrorState extends SocialState {
  final String error;
  SocialUpdateUserErrorState(this.error);
}

//
class SocialBottomNavBar extends SocialState {}

class AddPostState extends SocialState {}

class ImagePickerState extends SocialState {}

class ImageLoadingState extends SocialState {}

//post
class CreatPostLoadingState extends SocialState {}

class PostSuccessState extends SocialState {}

class ErrorPostState extends SocialState {}

//get posts
class GetPostsLoadingState extends SocialState {}

class GetPostsSuccessState extends SocialState {}

class GetPostsErrorState extends SocialState {
  final String error;
  GetPostsErrorState(this.error);
}

class LikePostState extends SocialState {}

class LikePostError extends SocialState {
  final String error;
  LikePostError(this.error);
}

class GetUsersLoadingState extends SocialState {}

class GetUsersState extends SocialState {}
class GetMessagesSuccessState extends SocialState {}
class GetaMessagesErrorsState extends SocialState {}
class SendMessageSuccessState extends SocialState {}
class SendMessageErrorState extends SocialState {}