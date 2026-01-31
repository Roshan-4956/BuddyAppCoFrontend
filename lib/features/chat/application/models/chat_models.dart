import 'package:cloud_firestore/cloud_firestore.dart';

enum ChatType { buddy, nudge, event, community, communityGroup }

extension ChatTypeX on ChatType {
  String get apiValue {
    switch (this) {
      case ChatType.buddy:
        return 'BUDDY';
      case ChatType.nudge:
        return 'NUDGE';
      case ChatType.event:
        return 'EVENT';
      case ChatType.community:
        return 'COMMUNITY';
      case ChatType.communityGroup:
        return 'COMMUNITY_GROUP';
    }
  }

  static ChatType fromApi(String value) {
    switch (value) {
      case 'NUDGE':
        return ChatType.nudge;
      case 'EVENT':
        return ChatType.event;
      case 'COMMUNITY':
        return ChatType.community;
      case 'COMMUNITY_GROUP':
        return ChatType.communityGroup;
      case 'BUDDY':
      default:
        return ChatType.buddy;
    }
  }
}

DateTime? parseFirestoreDate(dynamic value) {
  if (value == null) return null;
  if (value is Timestamp) return value.toDate();
  if (value is DateTime) return value;
  if (value is String) return DateTime.tryParse(value);
  return null;
}

class FirebaseUserModel {
  final String userId;
  final String displayName;
  final String? avatarUrl;
  final bool isOnline;
  final DateTime? lastSeenAt;
  final DateTime? updatedAt;

  FirebaseUserModel({
    required this.userId,
    required this.displayName,
    this.avatarUrl,
    required this.isOnline,
    required this.lastSeenAt,
    required this.updatedAt,
  });

  factory FirebaseUserModel.fromFirestore(
    String docId,
    Map<String, dynamic> data,
  ) {
    return FirebaseUserModel(
      userId: docId,
      displayName: data['display_name'] as String? ?? '',
      avatarUrl: data['avatar_url'] as String?,
      isOnline: data['is_online'] as bool? ?? false,
      lastSeenAt: parseFirestoreDate(data['last_seen_at']),
      updatedAt: parseFirestoreDate(data['updated_at']),
    );
  }
}

class LastMessageModel {
  final String text;
  final String senderId;
  final DateTime? sentAt;

  LastMessageModel({
    required this.text,
    required this.senderId,
    required this.sentAt,
  });

  factory LastMessageModel.fromJson(Map<String, dynamic> json) {
    return LastMessageModel(
      text: json['text'] as String? ?? '',
      senderId: json['sender_id'] as String? ?? '',
      sentAt: parseFirestoreDate(json['sent_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'sender_id': senderId, 'sent_at': sentAt};
  }
}

class FirebaseChatModel {
  final String chatId;
  final ChatType type;
  final List<String> participants;
  final LastMessageModel? lastMessage;
  final DateTime? lastMessageAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Map<String, dynamic>? metadata;

  FirebaseChatModel({
    required this.chatId,
    required this.type,
    required this.participants,
    this.lastMessage,
    this.lastMessageAt,
    this.createdAt,
    this.updatedAt,
    this.metadata,
  });

  factory FirebaseChatModel.fromFirestore(
    String docId,
    Map<String, dynamic> data,
  ) {
    final lastMessageData = data['last_message'] as Map<String, dynamic>?;
    return FirebaseChatModel(
      chatId: docId,
      type: ChatTypeX.fromApi(data['type'] as String? ?? 'BUDDY'),
      participants: (data['participants'] as List<dynamic>? ?? [])
          .map((item) => item.toString())
          .toList(),
      lastMessage: lastMessageData != null
          ? LastMessageModel.fromJson(lastMessageData)
          : null,
      lastMessageAt: parseFirestoreDate(data['last_message_at']),
      createdAt: parseFirestoreDate(data['created_at']),
      updatedAt: parseFirestoreDate(data['updated_at']),
      metadata: data['metadata'] as Map<String, dynamic>?,
    );
  }
}

class UserChatEntryModel {
  final String chatId;
  final ChatType chatType;
  final int unreadCount;
  final bool muted;
  final bool pinned;
  final DateTime? lastReadAt;
  final DateTime? joinedAt;
  final DateTime? updatedAt;

  UserChatEntryModel({
    required this.chatId,
    required this.chatType,
    required this.unreadCount,
    required this.muted,
    required this.pinned,
    required this.lastReadAt,
    required this.joinedAt,
    required this.updatedAt,
  });

  factory UserChatEntryModel.fromFirestore(
    String docId,
    Map<String, dynamic> data,
  ) {
    return UserChatEntryModel(
      chatId: docId,
      chatType: ChatTypeX.fromApi(data['chat_type'] as String? ?? 'BUDDY'),
      unreadCount: data['unread_count'] as int? ?? 0,
      muted: data['muted'] as bool? ?? false,
      pinned: data['pinned'] as bool? ?? false,
      lastReadAt: parseFirestoreDate(data['last_read_at']),
      joinedAt: parseFirestoreDate(data['joined_at']),
      updatedAt: parseFirestoreDate(data['updated_at']),
    );
  }
}

class ChatMessageModel {
  final String messageId;
  final String text;
  final String senderId;
  final DateTime? sentAt;

  ChatMessageModel({
    required this.messageId,
    required this.text,
    required this.senderId,
    required this.sentAt,
  });

  factory ChatMessageModel.fromFirestore(
    String docId,
    Map<String, dynamic> data,
  ) {
    return ChatMessageModel(
      messageId: docId,
      text: data['text'] as String? ?? '',
      senderId: data['sender_id'] as String? ?? '',
      sentAt: parseFirestoreDate(data['sent_at']),
    );
  }
}
