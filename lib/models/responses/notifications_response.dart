//! DISABLED
// class NotificationsResponse {
//   List<Notifications> notifications;

//   NotificationsResponse({this.notifications});

//   NotificationsResponse.fromJson(Map<String, dynamic> json) {
//     if (json['notifications'] != null) {
//       notifications = new List<Notifications>();
//       json['notifications'].forEach((v) {
//         notifications.add(new Notifications.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.notifications != null) {
//       data['notifications'] = this.notifications.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Notifications {
//   String id;
//   String type;
//   String notifiableType;
//   String notifiableId;
//   Data data;
//   Null readAt;
//   String createdAt;
//   String updatedAt;

//   Notifications({
//     this.id,
//     this.type,
//     this.notifiableType,
//     this.notifiableId,
//     this.data,
//     this.readAt,
//     this.createdAt,
//     this.updatedAt,
//   });

//   Notifications.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     type = json['type'];
//     notifiableType = json['notifiable_type'];
//     notifiableId = json['notifiable_id'];
//     data = json['data'] != null ? new Data.fromJson(json['data']) : null;
//     readAt = json['read_at'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['type'] = this.type;
//     data['notifiable_type'] = this.notifiableType;
//     data['notifiable_id'] = this.notifiableId;
//     if (this.data != null) {
//       data['data'] = this.data.toJson();
//     }
//     data['read_at'] = this.readAt;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
// }

// class Data {
//   String body;

//   Data({this.body});

//   Data.fromJson(Map<String, dynamic> json) {
//     body = json['body'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['body'] = this.body;
//     return data;
//   }
// }
