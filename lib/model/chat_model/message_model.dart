class MessageModel {
  String time;
  String msgId;
  String msg;
  String sender;
  String mediaType;
  bool isSeen = false;

  MessageModel({
    required this.time,
    required this.msgId,
    required this.msg,
    required this.sender,
    required this.mediaType,
    required this.isSeen,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        time: json['time'],
        msgId: json['msgId'],
        msg: json['msg'],
        sender: json['sender'],
        mediaType: json['mediaType'],
        isSeen: json['isSeen'],
      );

  Map<String, dynamic> toJson() => {
        'time': time,
        'msgId': msgId,
        'msg': msg,
        'sender': sender,
        'mediaType': mediaType,
        'isSeen': isSeen,
      };
}
