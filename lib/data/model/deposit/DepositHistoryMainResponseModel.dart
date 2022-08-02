
class DepositHistoryMainResponseModel {
  DepositHistoryMainResponseModel({
    String? remark,
    String? status,
    Message? message,
    MainData? mainData,
  }) {
    _remark = remark;
    _status = status;
    _message = message;
    _mainData = mainData;
  }

  DepositHistoryMainResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'].toString();
    _message =
        json['message'] != null ? Message.fromJson(json['message']) : null;
    _mainData = json['data'] != null ? MainData.fromJson(json['data']) : null;
  }

  String? _remark;
  String? _status;
  Message? _message;
  MainData? _mainData;

  String? get remark => _remark;

  String? get status => _status;

  Message? get message => _message;

  MainData? get mainData => _mainData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
    if (_message != null) {
      map['message'] = _message?.toJson();
    }
    if (_mainData != null) {
      map['data'] = _mainData?.toJson();
    }
    return map;
  }
}

class MainData {
  MainData({
    Deposits? deposits,
  }) {
    _deposits = deposits;
  }

  MainData.fromJson(dynamic json) {
    _deposits =
        json['deposits'] != null ? Deposits.fromJson(json['deposits']) : null;
  }

  Deposits? _deposits;

  Deposits? get deposits => _deposits;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_deposits != null) {
      map['deposits'] = _deposits?.toJson();
    }
    return map;
  }
}

class Deposits {
  Deposits({
    int? currentPage,
    List<Data>? data,
    String? firstPageUrl,
    int? from,
    int? lastPage,
    String? lastPageUrl,
    List<Links>? links,
    dynamic nextPageUrl,
    String? path,
    int? perPage,
    dynamic prevPageUrl,
    int? to,
    int? total,
  }) {
    _currentPage = currentPage;
    _data = data;
    _firstPageUrl = firstPageUrl;
    _from = from;
    _lastPage = lastPage;
    _lastPageUrl = lastPageUrl;
    _links = links;
    _nextPageUrl = nextPageUrl;
    _path = path;
    _perPage = perPage;
    _prevPageUrl = prevPageUrl;
    _to = to;
    _total = total;
  }

  Deposits.fromJson(dynamic json) {
    _currentPage = json['current_page'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _firstPageUrl = json['first_page_url'];
    _from = json['from'];
    _lastPage = json['last_page'];
    _lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      _links = [];
      json['links'].forEach((v) {
        _links?.add(Links.fromJson(v));
      });
    }
    _nextPageUrl = json['next_page_url'];
    _path = json['path'];
    _perPage = json['per_page'];
    _prevPageUrl = json['prev_page_url'];
    _to = json['to'];
    _total = json['total'];
  }

  int? _currentPage;
  List<Data>? _data;
  String? _firstPageUrl;
  int? _from;
  int? _lastPage;
  String? _lastPageUrl;
  List<Links>? _links;
  dynamic _nextPageUrl;
  String? _path;
  int? _perPage;
  dynamic _prevPageUrl;
  int? _to;
  int? _total;

  int? get currentPage => _currentPage;

  List<Data>? get data => _data;

  String? get firstPageUrl => _firstPageUrl;

  int? get from => _from;

  int? get lastPage => _lastPage;

  String? get lastPageUrl => _lastPageUrl;

  List<Links>? get links => _links;

  dynamic get nextPageUrl => _nextPageUrl;

  String? get path => _path;

  int? get perPage => _perPage;

  dynamic get prevPageUrl => _prevPageUrl;

  int? get to => _to;

  int? get total => _total;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['current_page'] = _currentPage;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['first_page_url'] = _firstPageUrl;
    map['from'] = _from;
    map['last_page'] = _lastPage;
    map['last_page_url'] = _lastPageUrl;
    if (_links != null) {
      map['links'] = _links?.map((v) => v.toJson()).toList();
    }
    map['next_page_url'] = _nextPageUrl;
    map['path'] = _path;
    map['per_page'] = _perPage;
    map['prev_page_url'] = _prevPageUrl;
    map['to'] = _to;
    map['total'] = _total;
    return map;
  }
}

class Links {
  Links({
    dynamic url,
    String? label,
    bool? active,
  }) {
    _url = url;
    _label = label;
    _active = active;
  }

  Links.fromJson(dynamic json) {
    _url = json['url'];
    _label = json['label'];
    _active = json['active'];
  }

  dynamic _url;
  String? _label;
  bool? _active;

  dynamic get url => _url;

  String? get label => _label;

  bool? get active => _active;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['label'] = _label;
    map['active'] = _active;
    return map;
  }
}

class Data {
  Data({
    int? id,
    String? userId,
    String? subscriptionId,
    String? methodCode,
    String? amount,
    String? methodCurrency,
    String? charge,
    String? rate,
    String? finalAmo,
    dynamic detail,
    String? btcAmo,
    String? btcWallet,
    String? trx,
    String? status,
    String? fromApi,
    dynamic adminFeedback,
    String? createdAt,
    String? updatedAt,
    String? date,
    Gateway? gateway,
    Subscription? subscription,
  }) {
    _id = id;
    _userId = userId;
    _subscriptionId = subscriptionId;
    _methodCode = methodCode;
    _amount = amount;
    _methodCurrency = methodCurrency;
    _charge = charge;
    _rate = rate;
    _finalAmo = finalAmo;
    _detail = detail;
    _btcAmo = btcAmo;
    _btcWallet = btcWallet;
    _trx = trx;
    _status = status;
    _fromApi = fromApi;
    _adminFeedback = adminFeedback;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _date = date;
    _gateway = gateway;
    _subscription = subscription;
  }

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'].toString();
    _subscriptionId = json['subscription_id'];
    _methodCode = json['method_code'];
    _amount = json['amount'];
    _methodCurrency = json['method_currency'];
    _charge = json['charge'];
    _rate = json['rate'];
    _finalAmo = json['final_amo'];
    _detail = json['detail'];
    _btcAmo = json['btc_amo'];
    _btcWallet = json['btc_wallet'];
    _trx = json['trx'];
    _status = json['status'].toString();
    _fromApi = json['from_api'];
    _adminFeedback = json['admin_feedback'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _date = json['date'];
    _gateway =
        json['gateway'] != null ? Gateway.fromJson(json['gateway']) : null;
    _subscription = json['subscription'] != null
        ? Subscription.fromJson(json['subscription'])
        : null;
  }

  int? _id;
  String? _userId;
  String? _subscriptionId;
  String? _methodCode;
  String? _amount;
  String? _methodCurrency;
  String? _charge;
  String? _rate;
  String? _finalAmo;
  dynamic _detail;
  String? _btcAmo;
  String? _btcWallet;
  String? _trx;
  String? _status;
  String? _fromApi;
  dynamic _adminFeedback;
  String? _createdAt;
  String? _updatedAt;
  String? _date;
  Gateway? _gateway;
  Subscription? _subscription;

  int? get id => _id;

  String? get userId => _userId;

  String? get subscriptionId => _subscriptionId;

  String? get methodCode => _methodCode;

  String? get amount => _amount;

  String? get methodCurrency => _methodCurrency;

  String? get charge => _charge;

  String? get rate => _rate;

  String? get finalAmo => _finalAmo;

  dynamic get detail => _detail;

  String? get btcAmo => _btcAmo;

  String? get btcWallet => _btcWallet;

  String? get trx => _trx;

  String? get status => _status;

  String? get fromApi => _fromApi;

  dynamic get adminFeedback => _adminFeedback;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  String? get date => _date;

  Gateway? get gateway => _gateway;

  Subscription? get subscription => _subscription;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['subscription_id'] = _subscriptionId;
    map['method_code'] = _methodCode;
    map['amount'] = _amount;
    map['method_currency'] = _methodCurrency;
    map['charge'] = _charge;
    map['rate'] = _rate;
    map['final_amo'] = _finalAmo;
    map['detail'] = _detail;
    map['btc_amo'] = _btcAmo;
    map['btc_wallet'] = _btcWallet;
    map['trx'] = _trx;
    map['status'] = _status;
    map['from_api'] = _fromApi;
    map['admin_feedback'] = _adminFeedback;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['date'] = _date;
    if (_gateway != null) {
      map['gateway'] = _gateway?.toJson();
    }
    if (_subscription != null) {
      map['subscription'] = _subscription?.toJson();
    }
    map['subscription'] = _subscription;
    return map;
  }
}

class Gateway {
  Gateway({
    int? id,
    String? formId,
    String? code,
    String? name,
    String? alias,
    String? gatewayParameters,
    String? crypto,
    Extra? extra,
    dynamic description,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _formId = formId;
    _code = code;
    _name = name;
    _alias = alias;
    _gatewayParameters = gatewayParameters;
    _crypto = crypto;
    _extra = extra;
    _description = description;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Gateway.fromJson(dynamic json) {
    _id = json['id'];
    _formId = json['form_id'];
    _code = json['code'];
    _name = json['name'];
    _alias = json['alias'];
    _gatewayParameters = json['gateway_parameters'];
    _crypto = json['crypto'];
    _extra = json['extra'] != null ? Extra.fromJson(json['extra']) : null;
    _description = json['description'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  String? _formId;
  String? _code;
  String? _name;
  String? _alias;
  bool? _status;
  String? _gatewayParameters;
  String? _crypto;
  Extra? _extra;
  dynamic _description;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;

  String? get formId => _formId;

  String? get code => _code;

  String? get name => _name;

  String? get alias => _alias;

  String? get gatewayParameters => _gatewayParameters;

  String? get crypto => _crypto;

  Extra? get extra => _extra;

  dynamic get description => _description;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['form_id'] = _formId;
    map['code'] = _code;
    map['name'] = _name;
    map['alias'] = _alias;
    map['status'] = _status;
    map['gateway_parameters'] = _gatewayParameters;
    map['crypto'] = _crypto;
    if (_extra != null) {
      map['extra'] = _extra?.toJson();
    }
    map['description'] = _description;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}

class Extra {
  Extra({
    Webhook? webhook,
  }) {
    _webhook = webhook;
  }

  Extra.fromJson(dynamic json) {
    _webhook =
        json['webhook'] != null ? Webhook.fromJson(json['webhook']) : null;
  }

  Webhook? _webhook;

  Webhook? get webhook => _webhook;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_webhook != null) {
      map['webhook'] = _webhook?.toJson();
    }
    return map;
  }
}

class Webhook {
  Webhook({
    String? title,
    String? value,
  }) {
    _title = title;
    _value = value;
  }

  Webhook.fromJson(dynamic json) {
    _title = json['title'];
    _value = json['value'];
  }

  String? _title;
  String? _value;

  String? get title => _title;

  String? get value => _value;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['title'] = _title;
    map['value'] = _value;
    return map;
  }
}

class Message {
  Message({
    List<String>? success,
  }) {
    _success = success;
  }

  Message.fromJson(dynamic json) {
    _success = json['success'] != null ?json['success'].cast<String>():null;
  }

  List<String>? _success;

  List<String>? get success => _success;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = _success;
    return map;
  }
}

class Subscription {
  Subscription({
    Plan? plan,
  }) {
    _plan = plan;
  }

  Subscription.fromJson(dynamic json) {
    _plan = json['plan'] != null ? Plan.fromJson(json['plan']) : null;
  }

  Plan? _plan;

  Plan? get plan => _plan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_plan != null) {
      map['plan'] = _plan?.toJson();
    }
    return map;
  }
}

class Plan {
  Plan({
    int? id,
    String? name,
    String? pricing,
    String? duration,
    String? status,
    String? description,
    String? image,
    String? createdAt,
    String? updatedAt,
  }) {
    _id = id;
    _name = name;
    _pricing = pricing;
    _duration = duration;
    _status = status;
    _description = description;
    _image = image;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
  }

  Plan.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _pricing = json['pricing'].toString();
    _duration = json['duration'].toString();
    _status = json['status'].toString();
    _description = json['description'];
    _image = json['image'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }

  int? _id;
  String? _name;
  String? _pricing;
  String? _duration;
  String? _status;
  String? _description;
  String? _image;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;

  String? get name => _name;

  String? get pricing => _pricing;

  String? get duration => _duration;

  String? get status => _status;

  String? get description => _description;

  String? get image => _image;

  String? get createdAt => _createdAt;

  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['pricing'] = _pricing;
    map['duration'] = _duration;
    map['status'] = _status;
    map['description'] = _description;
    map['image'] = _image;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }
}
