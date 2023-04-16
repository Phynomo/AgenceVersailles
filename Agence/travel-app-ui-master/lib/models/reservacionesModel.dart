class ReservacionModel{

  int paquId;
  int persId;

  ReservacionModel({this.paquId,this.persId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paqu_Id'] = this.paquId;
    data['pers_Id'] = this.persId;
    return data;
  }
}