import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:modulife_todos/models/folder.dart';
import 'package:modulife_todos/repositories/folder_repository.dart';

part 'folder_event.dart';
part 'folder_state.dart';

class FolderBloc extends Bloc<FolderEvent, FolderState> {
  final FolderRepository folderRepository;

  FolderBloc({required this.folderRepository}) : super(const FolderState()) {
    on<AddFolder>(_onAddFolder);
    on<UpdateFolder>(_onUpdateFolder);
    on<DeleteFolder>(_onDeleteFolder);
    on<LoadFolders>(_onLoadFolder);
  }

  Future<void> _onAddFolder(AddFolder event, Emitter<FolderState> emit) async {
    emit(state.copyWith(status: FolderStatus.loading));

    final List<Folder> updatedFolders = List<Folder>.from(state.allFolders)
      ..add(event.folder);

    emit(state.copyWith(
        allFolders: updatedFolders, status: FolderStatus.success));

    await folderRepository.saveFolders(updatedFolders);
  }

  Future<void> _onUpdateFolder(
      UpdateFolder event, Emitter<FolderState> emit) async {
    emit(state.copyWith(status: FolderStatus.loading));

    final List<Folder> updatedFolders = state.allFolders.map((Folder folder) {
      return folder.id == event.folder.id ? event.folder : folder;
    }).toList();

    emit(state.copyWith(
        allFolders: updatedFolders, status: FolderStatus.success));

    await folderRepository.saveFolders(updatedFolders);
  }

  Future<void> _onDeleteFolder(
      DeleteFolder event, Emitter<FolderState> emit) async {
    emit(state.copyWith(status: FolderStatus.loading));

    final List<Folder> updatedFolders = state.allFolders
        .where((Folder folder) => folder.id != event.folder.id)
        .toList();

    emit(state.copyWith(
        allFolders: updatedFolders, status: FolderStatus.success));

    await folderRepository.saveFolders(updatedFolders);
  }

  Future<void> _onLoadFolder(
      LoadFolders event, Emitter<FolderState> emit) async {
    emit(state.copyWith(status: FolderStatus.loading));

    try {
      final List<Folder> loadedFolders = await folderRepository.loadFolders();
      emit(state.copyWith(
          allFolders: loadedFolders, status: FolderStatus.success));
    } catch (_) {
      emit(state.copyWith(status: FolderStatus.failure));
    }
  }
}
