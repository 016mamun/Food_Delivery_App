import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/chat_entity.dart';

abstract class ChatRepository {
  Future<Either<Failure, void>> sendMessage(ChatMessageEntity message);
  Stream<List<ChatMessageEntity>> getMessages(String orderId);
  Future<Either<Failure, void>> markMessagesAsRead(String orderId);
}
