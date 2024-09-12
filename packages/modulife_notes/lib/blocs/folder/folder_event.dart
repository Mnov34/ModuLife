part of 'folder_bloc.dart';

sealed class FolderEvent extends Equatable {
  const FolderEvent();

  @override
  List<Object> get props => [];
}

final class AddFolder extends FolderEvent {
  final Folder folder;

  const AddFolder({required this.folder});

  @override
  List<Object> get props => [folder];
}

final class UpdateFolder extends FolderEvent {
  final Folder folder;

  const UpdateFolder({required this.folder});

  @override
  List<Object> get props => [folder];
}

final class DeleteFolder extends FolderEvent {
  final Folder folder;

  const DeleteFolder({required this.folder});

  @override
  List<Object> get props => [folder];
}

final class LoadFolders extends FolderEvent {
  @override
  List<Object> get props => [];
}
