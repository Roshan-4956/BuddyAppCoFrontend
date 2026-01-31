import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/application/services/token_storage_service.dart';
import '../../application/services/firebase_chat_service.dart';
import '../../application/models/chat_models.dart';

class ChatThreadScreen extends ConsumerStatefulWidget {
  final String chatId;
  const ChatThreadScreen({super.key, required this.chatId});

  @override
  ConsumerState<ChatThreadScreen> createState() => _ChatThreadScreenState();
}

class _ChatThreadScreenState extends ConsumerState<ChatThreadScreen> {
  late Future<bool> _initFuture;
  late Future<String?> _userIdFuture;
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initFuture = ref.read(firebaseChatServiceProvider).ensureReady();
    _userIdFuture = ref.read(tokenStorageServiceProvider).getUserId();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage(String senderId) async {
    final text = _messageController.text.trim();
    if (text.isEmpty) return;
    _messageController.clear();
    await ref
        .read(firebaseChatServiceProvider)
        .sendMessage(chatId: widget.chatId, senderId: senderId, text: text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat ${widget.chatId}')),
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
              final userId = userSnapshot.data ?? '';
              if (userId.isEmpty) {
                return const Center(child: Text('User not authenticated.'));
              }

              return Column(
                children: [
                  Expanded(
                    child: StreamBuilder<List<ChatMessageModel>>(
                      stream: ref
                          .read(firebaseChatServiceProvider)
                          .watchMessages(widget.chatId),
                      builder: (context, messagesSnapshot) {
                        final messages = messagesSnapshot.data ?? [];
                        if (messagesSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (messages.isEmpty) {
                          return const Center(child: Text('No messages yet.'));
                        }

                        return ListView.builder(
                          reverse: true,
                          padding: const EdgeInsets.all(16),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            final isMine = message.senderId == userId;
                            return Align(
                              alignment: isMine
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isMine
                                      ? Colors.blueAccent
                                      : Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  message.text,
                                  style: TextStyle(
                                    color: isMine
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _messageController,
                              decoration: const InputDecoration(
                                hintText: 'Type a message...',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () => _sendMessage(userId),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
