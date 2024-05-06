import '../../../../app.dart';

class QrCodeShareState extends Equatable {
  final bool? isLoading;
  final bool? isCompleted;
  final String? errorMessage;
  final String? successMessage;
  final Object? data;

  const QrCodeShareState({
    this.isLoading,
    this.isCompleted,
    this.errorMessage,
    this.successMessage,
    this.data,
  });

  @override
  List<Object?> get props => [
        isLoading,
        isCompleted,
        errorMessage,
        successMessage,
        data,
      ];
}
