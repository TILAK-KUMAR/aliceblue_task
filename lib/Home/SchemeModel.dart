class SchemeModel {
  String status;
  String message;
  List<Data> data;

  SchemeModel({this.status, this.message, this.data});

  SchemeModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    if (json['Data'] != null) {
      data = new List<Data>();
      json['Data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String schemecode;
  String schemeName;
  String navrs;
  String schemeType;
  String minInv;

  Data(
      {this.schemecode,
        this.schemeName,
        this.navrs,
        this.schemeType,
        this.minInv});

  Data.fromJson(Map<String, dynamic> json) {
    schemecode = json['Schemecode'];
    schemeName = json['schemeName'];
    navrs = json['Navrs'];
    schemeType = json['schemeType'];
    minInv = json['minInv'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Schemecode'] = this.schemecode;
    data['schemeName'] = this.schemeName;
    data['Navrs'] = this.navrs;
    data['schemeType'] = this.schemeType;
    data['minInv'] = this.minInv;
    return data;
  }
}