abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class UpdateProfileLoading extends ProfileState {}

class ImagePickedState extends ProfileState {}

class UpdateProfileSuccess extends ProfileState {
  final String message;
  UpdateProfileSuccess({required this.message});
}

class UpdateProfileError extends ProfileState {
  final String message;
  UpdateProfileError({required this.message});
}
