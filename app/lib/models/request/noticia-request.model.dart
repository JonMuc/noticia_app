class NoticiaRequestModel{
  int PageSize;
  int PageIndex;
  int IdBase;

  NoticiaRequestModel(this.PageIndex, this.PageSize, this.IdBase);

  NoticiaRequestModel.fromJson(Map<String, dynamic> json) {
    PageSize = json['PageSize'];
    PageIndex = json['PageIndex'];
    IdBase = json['IdBase'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PageSize'] = this.PageSize;
    data['PageIndex'] = this.PageIndex;
    data['IdBase'] = this.IdBase;
    return data;
  }
}