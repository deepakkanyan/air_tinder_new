class ChatRoomModel {
  String createdAt;
  String roomId;
  String lastMsg;
  String lstMsgTime;
  String isBlockByName;
  String isBlockById;
  List<dynamic> participants;

  ChatRoomModel({
    required this.createdAt,
    required this.roomId,
    required this.lastMsg,
    required this.lstMsgTime,
    required this.participants,
    required this.isBlockByName,
    required this.isBlockById,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) => ChatRoomModel(
        createdAt: json['createdAt'],
        roomId: json['roomId'],
        lastMsg: json['lastMsg'],
        lstMsgTime: json['lstMsgTime'],
        participants: json['participants'],
        isBlockByName: json['isBlockByName'],
        isBlockById: json['isBlockById'],
      );

  Map<String, dynamic> toJson() => {
        'createdAt': createdAt,
        'roomId': roomId,
        'lastMsg': lastMsg,
        'lstMsgTime': lstMsgTime,
        'participants': participants,
        'isBlockByName': isBlockByName,
        'isBlockById': isBlockById,
      };
}
