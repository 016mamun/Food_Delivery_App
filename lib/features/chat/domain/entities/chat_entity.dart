import 'package:equatable/equatable.dart';

class ChatMessageEntity extends Equatable {
  final String id;
  final String senderId;
  final String senderName;
  final String receiverId;
  final String orderId;
  final String message;
  final MessageType type;
  final DateTime createdAt;
  final bool isRead;

  const ChatMessageEntity({
    required this.id,
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.orderId,
    required this.message,
    this.type = MessageType.text,
    required this.createdAt,
    this.isRead = false,
  });

  @override
  List<Object?> get props => [id];
}

enum MessageType { text, image, location }
