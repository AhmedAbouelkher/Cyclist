//! REPLASED
class SliderModel {
  List<Slide> sliders;

  SliderModel({this.sliders});

  SliderModel.fromJson(Map<String, dynamic> json) {
    if (json['sliders'] != null) {
      sliders = List<Slide>.from(json["sliders"].map((x) => Slide.fromJson(x)));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.sliders != null) {
      data['sliders'] = this.sliders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Slide {
  int id;
  String image;
  String title;
  String createdAt;
  String updatedAt;
  String imagePath;

  Slide({this.id, this.image, this.title, this.createdAt, this.updatedAt, this.imagePath});

  Slide.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imagePath = json['image_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['title'] = this.title;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_path'] = this.imagePath;
    return data;
  }
}
