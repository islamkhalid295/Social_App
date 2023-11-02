class AppStates  {}

class InitState extends AppStates {}

class LoginSucssesState extends AppStates {}

class LoginErorrState extends AppStates {
  var error;

  LoginErorrState(this.error);
}

class RegisterSucssesState extends AppStates {}

class RegisterErorrState extends AppStates {
  var error;

  RegisterErorrState(this.error);
}

class CreateUserLodingState extends AppStates {}

class CreateUserSucssesState extends AppStates {}

class CreateUserErorrState extends AppStates {
  var error;

  CreateUserErorrState(this.error);
}

class LodingState extends AppStates {}

class LodingGetProfileState extends AppStates {}

class GetProfileDataSucssesState extends AppStates {}

class GetProfileDataErorrState extends AppStates {
  var error;

  GetProfileDataErorrState(this.error);
}

class LodingGetUserState extends AppStates {}

class GetUserDataSucssesState extends AppStates {}

class GetUserDataErorrState extends AppStates {
  var error;

  GetUserDataErorrState(this.error);
}

class NavBarChangeState extends AppStates {}

class updateProfileDataLodingState extends AppStates {}

class updateProfileDataSuccessState extends AppStates {}

class updateProfileDataErrorState extends AppStates {}

class RemovePostImageState extends AppStates {}

class GetPostImageLodingState extends AppStates {}

class GetPostImageSuccessState extends AppStates {}

class GetPostImageErrorState extends AppStates {}

class GetPostsLodingState extends AppStates {}

class GetPostsSuccessState extends AppStates {}

class GetPostsErrorState extends AppStates {}

class GetUsersLodingState extends AppStates {}

class GetUsersSuccessState extends AppStates {}

class GetUsersErrorState extends AppStates {}

class AddNewPostLodingState extends AppStates {}

class AddNewPostSuccessState extends AppStates {}

class AddNewPostErrorState extends AppStates {}

class RefrashImageState extends AppStates {}

class LikePostSuccessState extends AppStates {}

class GetPostLikesSuccessState extends AppStates {}

class AddNewCommentLodingState extends AppStates {}

class AddNewCommentSuccessState extends AppStates {}

class AddNewCommentErrorState extends AppStates {}

class AddMessageLodingState extends AppStates {}

class AddMessageSuccessState extends AppStates {}

class AddMessageErrorState extends AppStates {}

class GetMessageLodingState extends AppStates {}

class GetMessageSuccessState extends AppStates {}

class GetMessageErrorState extends AppStates {}

class GetPostCommentsLodingState extends AppStates {}

class GetPostCommentsSuccessState extends AppStates {}

class GetPostCommentsErrorState extends AppStates {}

