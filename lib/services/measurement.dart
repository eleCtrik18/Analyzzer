class MeasurementId {
  int? status;
  D? d;

  MeasurementId({this.status, this.d});

  MeasurementId.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    d = json['d'] != null ? new D.fromJson(json['d']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.d != null) {
      data['d'] = this.d!.toJson();
    }
    return data;
  }
}

class D {
  String? measurementId;
  String? neck;
  String? height;
  String? weight;
  String? belly;
  String? chest;
  String? wrist;
  String? armLength;
  String? thigh;
  String? shoulder;
  String? hips;
  String? ankle;

  D(
      {this.measurementId,
      this.neck,
      this.height,
      this.weight,
      this.belly,
      this.chest,
      this.wrist,
      this.armLength,
      this.thigh,
      this.shoulder,
      this.hips,
      this.ankle});

  D.fromJson(Map<String, dynamic> json) {
    measurementId = json['measurementId'];
    neck = json['neck'];
    height = json['height'];
    weight = json['weight'];
    belly = json['belly'];
    chest = json['chest'];
    wrist = json['wrist'];
    armLength = json['armLength'];
    thigh = json['thigh'];
    shoulder = json['shoulder'];
    hips = json['hips'];
    ankle = json['ankle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['measurementId'] = this.measurementId;
    data['neck'] = this.neck;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['belly'] = this.belly;
    data['chest'] = this.chest;
    data['wrist'] = this.wrist;
    data['armLength'] = this.armLength;
    data['thigh'] = this.thigh;
    data['shoulder'] = this.shoulder;
    data['hips'] = this.hips;
    data['ankle'] = this.ankle;
    return data;
  }
}
