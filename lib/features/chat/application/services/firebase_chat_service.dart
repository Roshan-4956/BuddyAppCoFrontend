import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../utils/logger.dart';
import '../../../../utils/firebase/firebase_bootstrap.dart';
import '../../../auth/application/repositories/auth_repos.dart';
import '../../../auth/application/services/token_storage_service.dart';
import '../models/chat_models.dart';

part 'firebase_chat_service.g.dart';

@Riverpod(keepAlive: true)
FirebaseChatService firebaseChatService(Ref ref) => FirebaseChatService(ref);

class FirebaseChatService {
  FirebaseChatService(this.ref);

  final Ref ref;
  FirebaseAuth get _auth => FirebaseAuth.instance;
  FirebaseFirestore get _firestore => FirebaseFirestore.instance;

  Future<bool> ensureReady() async {
    final initialized = await FirebaseBootstrap.ensureInitialized();
    if (!initialized) {
      return false;
    }
    await _ensureSignedIn();
    return _auth.currentUser != null;
  }

  Future<void> _ensureSignedIn() async {
    if (_auth.currentUser != null) {
      return;
    }

    String? token;
    try {
      token = await ref.read(tokenStorageServiceProvider).getFirebaseToken();
    } catch (_) {}

    token ??= await _fetchFirebaseToken();
    if (token == null || token.isEmpty) {
      debugLog(DebugTags.firebase, 'Firebase token unavailable');
      return;
    }

    try {
      await _auth.signInWithCustomToken(token);
      debugLog(DebugTags.firebase, 'Firebase auth success');
    } catch (e) {
      errorLog(DebugTags.firebase, 'Firebase auth failed: $e');
      final refreshed = await _fetchFirebaseToken();
      if (refreshed != null && refreshed.isNotEmpty && refreshed != token) {
        try {
          await _auth.signInWithCustomToken(refreshed);
          debugLog(DebugTags.firebase, 'Firebase auth refreshed');
        } catch (err) {
          errorLog(DebugTags.firebase, 'Firebase auth refresh failed: $err');
        }
      }
    }
  }

  Future<String?> _fetchFirebaseToken() async {
    final repo = ref.read(firebaseTokenRepoProvider);
    await repo.execute();
    if (repo.state.isSuccess) {
      return repo.latestValidResult?.firebaseToken;
    }
    return null;
  }

  Stream<List<UserChatEntryModel>> watchUserChats(String userId) async* {
    final ready = await ensureReady();
    if (!ready) {
      yield [];
      return;
    }

    final query = _firestore
        .collection('userChats')
        .doc(userId)
        .collection('chats')
        .orderBy('updated_at', descending: true);

    yield* query.snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => UserChatEntryModel.fromFirestore(doc.id, doc.data()))
          .toList(),
    );
  }

  Stream<FirebaseChatModel?> watchChat(String chatId) async* {
    final ready = await ensureReady();
    if (!ready) {
      yield null;
      return;
    }

    final docRef = _firestore.collection('chats').doc(chatId);
    yield* docRef.snapshots().map(
      (doc) => doc.exists
          ? FirebaseChatModel.fromFirestore(doc.id, doc.data() ?? {})
          : null,
    );
  }

  Stream<List<ChatMessageModel>> watchMessages(
    String chatId, {
    int limit = 50,
  }) async* {
    final ready = await ensureReady();
    if (!ready) {
      yield [];
      return;
    }

    final query = _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('sent_at', descending: true)
        .limit(limit);

    yield* query.snapshots().map(
      (snapshot) => snapshot.docs
          .map((doc) => ChatMessageModel.fromFirestore(doc.id, doc.data()))
          .toList(),
    );
  }

  Future<void> sendMessage({
    required String chatId,
    required String senderId,
    required String text,
  }) async {
    final ready = await ensureReady();
    if (!ready) {
      return;
    }

    final now = DateTime.now();
    final chatRef = _firestore.collection('chats').doc(chatId);
    final messagesRef = chatRef.collection('messages');

    await messagesRef.add({
      'text': text,
      'sender_id': senderId,
      'sent_at': now,
    });

    await chatRef.update({
      'last_message': {'text': text, 'sender_id': senderId, 'sent_at': now},
      'last_message_at': now,
      'updated_at': now,
    });
  }
}
