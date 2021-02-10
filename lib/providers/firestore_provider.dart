import 'package:shoppingapp/repository/firestore_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firestoreProvider = Provider((ref) => FirestoreRepository(read : ref.read));

