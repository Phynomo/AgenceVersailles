class UsuarioModel {
  String usuaId;
  String usuaNombreUsuario;
  String usuaCorreo;
  String usuaContrasena;
  String persId;
  String usuaPersonaNombreCompleto;
  String usuaEsAdmin;

  UsuarioModel({
    this.usuaId,
    this.usuaNombreUsuario,
    this.usuaCorreo,
    this.usuaContrasena,
    this.persId,
    this.usuaPersonaNombreCompleto,
    this.usuaEsAdmin,
  });

  Map<String, dynamic> toJson() {
    return {
      'usua_Id': usuaId,
      'usua_NombreUsuario': usuaNombreUsuario,
      'usua_Correo': usuaCorreo,
      'usua_Contrasena': usuaContrasena,
      'pers_Id': persId,
      'usua_PersonaNombreCompleto': usuaPersonaNombreCompleto,
      'usua_EsAdmin': usuaEsAdmin,
    };
  }

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      usuaId: json['usua_Id'],
      usuaNombreUsuario: json['usua_NombreUsuario'],
      usuaCorreo: json['usua_Correo'],
      usuaContrasena: json['usua_Contrasena'],
      persId: json['pers_Id'],
      usuaPersonaNombreCompleto: json['usua_PersonaNombreCompleto'],
      usuaEsAdmin: json['usua_EsAdmin'],
    );
  }
}
