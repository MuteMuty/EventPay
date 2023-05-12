part of 'profil_bloc.dart';

@immutable
class ProfilState {
  final bool isLoading;
  final bool initialized;
  final EventPayUser? user;
  final Failure? failure;
  final int ridesNumber;
  final int offersNumber;
  final double rating;

  const ProfilState({
    required this.isLoading,
    required this.initialized,
    required this.user,
    required this.failure,
    required this.ridesNumber,
    required this.offersNumber,
    required this.rating,
  });

  const ProfilState.initial()
      : isLoading = false,
        initialized = false,
        user = null,
        failure = null,
        ridesNumber = 0,
        offersNumber = 0,
        rating = 0.0;

  ProfilState copyWith({
    bool? isLoading,
    bool? initialized,
    EventPayUser? user,
    Failure? failure,
    int? ridesNumber,
    int? offersNumber,
    double? rating,
  }) {
    return ProfilState(
      isLoading: isLoading ?? this.isLoading,
      initialized: initialized ?? this.initialized,
      user: user ?? this.user,
      failure: failure,
      ridesNumber: ridesNumber ?? this.ridesNumber,
      offersNumber: offersNumber ?? this.offersNumber,
      rating: rating ?? this.rating,
    );
  }
}
