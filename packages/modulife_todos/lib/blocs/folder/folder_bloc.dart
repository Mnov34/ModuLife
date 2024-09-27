import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:modulife_todos/models/folder.dart';
import 'package:modulife_todos/repositories/folder_repository.dart';
import 'package:modulife_utils/modulife_utils.dart';

part 'folder_event.dart';
part 'folder_state.dart';

class FolderBloc extends Bloc<FolderEvent, FolderState> {
  final FolderRepository folderRepository;

  FolderBloc({required this.folderRepository}) : super(const FolderState()) {
    on<AddFolder>(_onAddFolder);
    on<UpdateFolder>(_onUpdateFolder);
    on<DeleteFolder>(_onDeleteFolder);
    on<LoadFolders>(_onLoadFolder);

    LogService.i('FolderBloc initialized');
  }

  Future<void> _onAddFolder(AddFolder event, Emitter<FolderState> emit) async {
    LogService.d('AddFolder event triggered: ${event.folder}');
    emit(state.copyWith(status: FolderStatus.loading));

    final List<Folder> updatedFolders = List<Folder>.from(state.allFolders)
      ..add(event.folder);

    emit(state.copyWith(
        allFolders: updatedFolders, status: FolderStatus.success));

    await _saveFolders(updatedFolders);
  }

  Future<void> _onUpdateFolder(
      UpdateFolder event, Emitter<FolderState> emit) async {
    LogService.d('UpdateFolder event triggered: ${event.folder}');
    emit(state.copyWith(status: FolderStatus.loading));

    final List<Folder> updatedFolders = state.allFolders.map((Folder folder) {
      return folder.id == event.folder.id ? event.folder : folder;
    }).toList();

    emit(state.copyWith(
        allFolders: updatedFolders, status: FolderStatus.success));

    await _saveFolders(updatedFolders);
  }

  Future<void> _onDeleteFolder(
      DeleteFolder event, Emitter<FolderState> emit) async {
    LogService.d('DeleteFolder event triggered: ${event.folder}');
    emit(state.copyWith(status: FolderStatus.loading));

    final List<Folder> updatedFolders = state.allFolders
        .where((Folder folder) => folder.id != event.folder.id)
        .toList();

    emit(state.copyWith(
        allFolders: updatedFolders, status: FolderStatus.success));

    await _saveFolders(updatedFolders);
  }

  Future<void> _onLoadFolder(
      LoadFolders event, Emitter<FolderState> emit) async {
    LogService.d('LoadFolder event triggered');
    emit(state.copyWith(status: FolderStatus.loading));

    try {
      final List<Folder> loadedFolders = await folderRepository.loadFolders();
      emit(state.copyWith(
          allFolders: loadedFolders, status: FolderStatus.success));
      LogService.i(
          'Folders loaded successfully. Total folders: ${loadedFolders.length}');
    } catch (e, stackTrace) {
      emit(state.copyWith(status: FolderStatus.failure));
      LogService.e('Failed to load folders', e, stackTrace);
    }
  }

  /// Helper method to save folders and log the result
  Future<void> _saveFolders(List<Folder> folders) async {
    try {
      await folderRepository.saveFolders(folders);
      LogService.i(
          'Folders saved successfully. Total folders: ${folders.length}');
    } catch (e, stackTrace) {
      LogService.e('Failed to save folders', e, stackTrace);
    }
  }
}
