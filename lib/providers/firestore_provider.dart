import 'package:shoppingapp/repository/firestore_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shoppingapp/repository/firestore_storage.dart';

final firestoreProvider = Provider((ref) => FirestoreRepository(read : ref.read));

final storageProvider = Provider((ref) => StorageRepository(read : ref.read));