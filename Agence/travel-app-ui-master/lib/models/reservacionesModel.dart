class ReservacionModel{

  int paquId;
  int persId;
  int reseId;

  ReservacionModel({this.paquId,this.persId,this.reseId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['paqu_Id'] = this.paquId;
    data['pers_Id'] = this.persId;
    data['rese_Id'] = this.reseId;
    return data;
  }
}