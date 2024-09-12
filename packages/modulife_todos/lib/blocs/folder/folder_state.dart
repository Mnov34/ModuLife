part of 'folder_bloc.dart';

enum FolderStatus { initial, loading, success, failure }

final class FolderState extends Equatable {
  final List<Folder> allFolders;
  final FolderStatus status;

  const FolderState({
    this.allFolders = const <Folder>[],
    this.status = FolderStatus.initial,
  });

  FolderState copyWith({
    List<Folder>? allFolders,
    FolderStatus? status,
    bool? isLoading,
    bool? hasError,
  }) {
    return FolderState(
      allFolders: allFolders ?? List.from(this.allFolders),
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [allFolders, status];
}
