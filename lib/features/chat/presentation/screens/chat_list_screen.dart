import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/application/services/token_storage_service.dart';
import '../../application/services/firebase_chat_service.dart';
import '../../application/models/chat_models.dart';

class ChatListScreen extends ConsumerStatefulWidget {
  const ChatListScreen({super.key});

  @override
  ConsumerState<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends ConsumerState<ChatListScreen> {
  late Future<bool> _initFuture;
  late Future<String?> _userIdFuture;

  @override
  void initState() {
    super.initState();
    _initFuture = ref.read(firebaseChatServiceProvider).ensureReady();
    _userIdFuture = ref.read(tokenStorageServiceProvider).getUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: FutureBuilder<bool>(
        future: _initFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == false) {
            return const Center(child: Text('Firebase not configured.'));
          }

          return FutureBuilder<String?>(
            future: _userIdFuture,
            builder: (context, userSnapshot) {
              if (!userSnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final userId = userSnapshot.data;
              if (userId == null || userId.isEmpty) {
                return const Center(child: Text('User not authenticated.'));
              }

              return StreamBuilder<List<UserChatEntryModel>>(
                stream: ref
                    .read(firebaseChatServiceProvider)
                    .watchUserChats(userId),
                builder: (context, chatsSnapshot) {
                  final chats = chatsSnapshot.data ?? [];
                  if (chatsSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (chats.isEmpty) {
                    return const Center(child: Text('No chats yet.'));
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: chats.length,
                    separatorBuilder: (_, __) => const Divider(height: 16),
                    itemBuilder: (context, index) {
                      final chat = chats[index];
                      return ListTile(
                        title: Text(chat.chatId),
                        subtitle: Text(chat.chatType.apiValue),
                        trailing: chat.unreadCount > 0
                            ? CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.redAccent,
                                child: Text(
                                  '${chat.unreadCount}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              )
                            : null,
                        onTap: () {
                          context.go('/chats/${chat.chatId}');
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
