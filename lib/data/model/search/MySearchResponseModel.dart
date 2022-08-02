import '../auth/registration_response_model.dart';

class MySearchResponseModel {
  MySearchResponseModel({
      String? remark, 
      String? status, 
     Message? message, 
      MainData? mainData,}){
    _remark = remark;
    _status = status;
    _message = message;
    _mainData = mainData;
}

  MySearchResponseModel.fromJson(dynamic json) {
    _remark = json['remark'];
    _status = json['status'].toString();
    _message = json['message'] != null ? Message.fromJson(json['message']):null;
    _mainData = json['data'] != null ? MainData.fromJson(json['data']) : null;
  }
  String? _remark;
  String? _status;
  Message? _message;
  MainData? _mainData;

  String? get remark => _remark;
  String? get status => _status;
  Message? get message => _message;
  MainData? get data => _mainData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['remark'] = _remark;
    map['status'] = _status;
   if(_message!=null){
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
    String? portraitPath,
      Items? items,}){
    _items = items;
    _portraitPath= portraitPath;
}

  MainData.fromJson(dynamic json) {
    _items = json['items'] != null ? Items.fromJson(json['items']) : null;
    _portraitPath=json['portrait_path'];
  }
  Items? _items;
  String? _portraitPath;

  Items? get items => _items;
  String? get portraitPath => _portraitPath;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_items != null) {
      map['items'] = _items?.toJson();
    }
    map['portrait_path'] = _portraitPath;
    return map;
  }

}

class Items {
  Items({
      int? currentPage, 
      List<Data>? data, 
      String? firstPageUrl, 
      int? from, 
      int? lastPage, 
      String? lastPageUrl, 
      List<Links>? links, 
      String? nextPageUrl, 
      String? path, 
      int? perPage, 
      dynamic prevPageUrl, 
      int? to, 
      int? total,}){
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

  Items.fromJson(dynamic json) {
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
  String? _nextPageUrl;
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
  String? get nextPageUrl => _nextPageUrl;
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
      bool? active,}){
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
      String? categoryId, 
      dynamic subCategoryId, 
      String? title, 
      String? previewText, 
      String? description, 
      Team? team, 
      Image? image, 
      String? itemType, 
      String? status, 
 /*     String? single,
      String? trending, 
      String? featured, 
      String? version, */
      String? tags, 
      String? ratings, 
      String? view, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _categoryId = categoryId;
    _subCategoryId = subCategoryId;
    _title = title;
    _previewText = previewText;
    _description = description;
    _team = team;
    _image = image;
    _itemType = itemType;
    _status = status;
    /*_single = single;
    _trending = trending;
    _featured = featured;
    _version = version;*/
    _tags = tags;
    _ratings = ratings;
    _view = view;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _categoryId = json['category_id'].toString();
    _subCategoryId = json['sub_category_id'].toString().toString();
    _title = json['title'];
    _previewText = json['preview_text'];
    _description = json['description'];
    _team = json['team'] != null ? Team.fromJson(json['team']) : null;
    _image = json['image'] != null ? Image.fromJson(json['image']) : null;
    _itemType = json['item_type'].toString();
    _status = json['status'].toString();
    /*_single = json['single'].toString();
    _trending = json['trending'].toString();
    _featured = json['featured'].toString();
    _version = json['version'].toString();*/
    _tags = json['tags'].toString();
    _ratings = json['ratings'].toString();
    _view = json['view'].toString();
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  int? _id;
  String? _categoryId;
  dynamic _subCategoryId;
  String? _title;
  String? _previewText;
  String? _description;
  Team? _team;
  Image? _image;
  String? _itemType;
  String? _status;
 /* String? _single;
  String? _trending;
  String? _featured;
  String? _version;*/
  String? _tags;
  String? _ratings;
  String? _view;
  String? _createdAt;
  String? _updatedAt;

  int? get id => _id;
  String? get categoryId => _categoryId;
  dynamic get subCategoryId => _subCategoryId;
  String? get title => _title;
  String? get previewText => _previewText;
  String? get description => _description;
  Team? get team => _team;
  Image? get image => _image;
  String? get itemType => _itemType;
  String? get status => _status;
/*  String? get single => _single;
  String? get trending => _trending;
  String? get featured => _featured;
  String? get version => _version;*/
  String? get tags => _tags;
  String? get ratings => _ratings;
  String? get view => _view;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category_id'] = _categoryId;
    map['sub_category_id'] = _subCategoryId;
    map['title'] = _title;
    map['preview_text'] = _previewText;
    map['description'] = _description;
    if (_team != null) {
      map['team'] = _team?.toJson();
    }
    if (_image != null) {
      map['image'] = _image?.toJson();
    }
    map['item_type'] = _itemType;
    map['status'] = _status;
/*    map['single'] = _single;
    map['trending'] = _trending;
    map['featured'] = _featured;
    map['version'] = _version;*/
    map['tags'] = _tags;
    map['ratings'] = _ratings;
    map['view'] = _view;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}

class Image {
  Image({
      String? landscape, 
      String? portrait,}){
    _landscape = landscape;
    _portrait = portrait;
}

  Image.fromJson(dynamic json) {
    _landscape = json['landscape'];
    _portrait = json['portrait'];
  }
  String? _landscape;
  String? _portrait;

  String? get landscape => _landscape;
  String? get portrait => _portrait;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['landscape'] = _landscape;
    map['portrait'] = _portrait;
    return map;
  }

}

class Team {
  Team({
      String? director, 
      String? producer, 
      String? casts,}){
    _director = director;
    _producer = producer;
    _casts = casts;
}

  Team.fromJson(dynamic json) {
    _director = json['director'];
    _producer = json['producer'];
    _casts = json['casts'];
  }
  String? _director;
  String? _producer;
  String? _casts;

  String? get director => _director;
  String? get producer => _producer;
  String? get casts => _casts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['director'] = _director;
    map['producer'] = _producer;
    map['casts'] = _casts;
    return map;
  }

}