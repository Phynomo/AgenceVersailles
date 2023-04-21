class Paises {
  String paisNombre;
  int paisId;

  Paises({this.paisNombre, this.paisId});

  factory Paises.fromJson(Map<String, dynamic> json) {
    return Paises(
      paisNombre: json['pais_Nombre'],
      paisId: json['pais_Id'],
    );
  }
}

class Vuelos {
  String vuelInfo;
  int vuelId;

  Vuelos({this.vuelInfo, this.vuelId});

  factory Vuelos.fromJson(Map<String, dynamic> json) {
    return Vuelos(
      vuelInfo: json['vuel_Info'],
      vuelId: json['vuel_Id'],
    );
  }
}


class Hoteles {
  String hoteNombre;
  int hoteId;

  Hoteles({this.hoteNombre, this.hoteId});

  factory Hoteles.fromJson(Map<String, dynamic> json) {
    return Hoteles(
      hoteNombre: json['hote_Nombre'],
      hoteId: json['hote_Id'],
    );
  }
}



class Habitaciones {
  String habiNombre;
  int habiId;

  Habitaciones({this.habiNombre, this.habiId});

  factory Habitaciones.fromJson(Map<String, dynamic> json) {
    return Habitaciones(
      habiNombre: json['habi_Nombre'],
      habiId: json['habi_Id'],
    );
  }
}