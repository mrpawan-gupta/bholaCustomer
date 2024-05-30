class FCMData {
  FCMData({
    this.title,
    this.body,
    this.clickAction,
    this.id,
    this.screen,
  });

  FCMData.fromJson(Map<String, dynamic> json) {
    title = json["title"];
    body = json["body"];
    clickAction = json["click_action"];
    id = json["_id"];
    screen = json["screen"];
  }
  String? title;
  String? body;
  String? clickAction;
  String? id;
  String? screen;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map["title"] = title;
    map["body"] = body;
    map["click_action"] = clickAction;
    map["_id"] = id;
    map["screen"] = screen;
    return map;
  }
}
