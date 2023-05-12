part of 'profil_bloc.dart';

@immutable
abstract class ProfilEvent {
  const ProfilEvent();
}

class _Initialize extends ProfilEvent {
  const _Initialize();
}

class _ReloadProfilImage extends ProfilEvent {
  const _ReloadProfilImage();
}

class _ReloadUser extends ProfilEvent {
  const _ReloadUser();
}

class _Reset extends ProfilEvent {}
