part of 'comics_cubit.dart';

enum ComicsStatus { initial, loading, failure, success, idle }

class ComicsState extends Equatable {
  const ComicsState({
    required this.status,
    this.errorMessage,
    required List<Pack> packs,
  }) : _packs = packs;

  final ComicsStatus status;
  final String? errorMessage;
  final List<Pack> _packs;

  List<Pack> get packs => _packs;

  ComicsState copyWith({
    required ComicsStatus status,
    String? errorMessage,
    List<Pack>? packs,
  }) {
    return ComicsState(
      status: status,
      errorMessage: errorMessage ?? this.errorMessage,
      packs: packs ?? _packs,
    );
  }

  @override
  List<Object?> get props => [
        status,
        errorMessage,
        _packs,
      ];
}
