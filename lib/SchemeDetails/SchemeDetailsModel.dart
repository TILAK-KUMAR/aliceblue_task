class SchemeDetailsModel {
  String status;
  String message;
  Data data;

  SchemeDetailsModel({this.status, this.message, this.data});

  SchemeDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    data = json['Data'] != null ? new Data.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Status'] = this.status;
    data['Message'] = this.message;
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String minimumPurchaseAmount;
  String maximumPurchaseAmount;
  String purchaseAmountMultiplier;
  String sETTLEMENTTYPE;
  String startDate;
  String endDate;
  String aCCEXITLOAD;
  String lockInPeriod;
  String fundMgr1;
  String defaultopt;
  String cLASSNAME;
  String eXPRATIO;
  String s1YEARCRET;
  String s2YEARCRET;
  String s3YEARCRET;
  String s4YEARCRET;
  String s5YEARCRET;
  List<IndusrtyData> indusrtyData;

  Data(
      {this.minimumPurchaseAmount,
        this.maximumPurchaseAmount,
        this.purchaseAmountMultiplier,
        this.sETTLEMENTTYPE,
        this.startDate,
        this.endDate,
        this.aCCEXITLOAD,
        this.lockInPeriod,
        this.fundMgr1,
        this.defaultopt,
        this.cLASSNAME,
        this.eXPRATIO,
        this.s1YEARCRET,
        this.s2YEARCRET,
        this.s3YEARCRET,
        this.s4YEARCRET,
        this.s5YEARCRET,
        this.indusrtyData});

  Data.fromJson(Map<String, dynamic> json) {
    minimumPurchaseAmount = json['Minimum Purchase Amount'];
    maximumPurchaseAmount = json['Maximum Purchase Amount'];
    purchaseAmountMultiplier = json['Purchase Amount Multiplier'];
    sETTLEMENTTYPE = json['SETTLEMENT TYPE'];
    startDate = json['Start Date'];
    endDate = json['End Date'];
    aCCEXITLOAD = json['ACC_EXITLOAD'];
    lockInPeriod = json['Lock-in Period'];
    fundMgr1 = json['fund_mgr1'];
    defaultopt = json['defaultopt'];
    cLASSNAME = json['CLASSNAME'];
    eXPRATIO = json['EXPRATIO'];
    s1YEARCRET = json['1YEAR_CRET'];
    s2YEARCRET = json['2YEAR_CRET'];
    s3YEARCRET = json['3YEAR_CRET'];
    s4YEARCRET = json['4YEAR_CRET'];
    s5YEARCRET = json['5YEAR_CRET'];
    if (json['indusrtyData'] != null) {
      indusrtyData = new List<IndusrtyData>();
      json['indusrtyData'].forEach((v) {
        indusrtyData.add(new IndusrtyData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Minimum Purchase Amount'] = this.minimumPurchaseAmount;
    data['Maximum Purchase Amount'] = this.maximumPurchaseAmount;
    data['Purchase Amount Multiplier'] = this.purchaseAmountMultiplier;
    data['SETTLEMENT TYPE'] = this.sETTLEMENTTYPE;
    data['Start Date'] = this.startDate;
    data['End Date'] = this.endDate;
    data['ACC_EXITLOAD'] = this.aCCEXITLOAD;
    data['Lock-in Period'] = this.lockInPeriod;
    data['fund_mgr1'] = this.fundMgr1;
    data['defaultopt'] = this.defaultopt;
    data['CLASSNAME'] = this.cLASSNAME;
    data['EXPRATIO'] = this.eXPRATIO;
    data['1YEAR_CRET'] = this.s1YEARCRET;
    data['2YEAR_CRET'] = this.s2YEARCRET;
    data['3YEAR_CRET'] = this.s3YEARCRET;
    data['4YEAR_CRET'] = this.s4YEARCRET;
    data['5YEAR_CRET'] = this.s5YEARCRET;
    if (this.indusrtyData != null) {
      data['indusrtyData'] = this.indusrtyData.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class IndusrtyData {
  String hOLDPERCENTAGE;
  String cOMPNAME;
  String sECTNAME;
  String aUM;

  IndusrtyData({this.hOLDPERCENTAGE, this.cOMPNAME, this.sECTNAME, this.aUM});

  IndusrtyData.fromJson(Map<String, dynamic> json) {
    hOLDPERCENTAGE = json['HOLDPERCENTAGE'];
    cOMPNAME = json['COMPNAME'];
    sECTNAME = json['SECT_NAME'];
    aUM = json['AUM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HOLDPERCENTAGE'] = this.hOLDPERCENTAGE;
    data['COMPNAME'] = this.cOMPNAME;
    data['SECT_NAME'] = this.sECTNAME;
    data['AUM'] = this.aUM;
    return data;
  }
}