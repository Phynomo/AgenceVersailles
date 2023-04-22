class UsuarioModel {
  String usuaId;
  String usuaNombreUsuario;
  String usuaImgUrl;
  String usuaCorreo;
  String usuaContrasena;
  String persId;
  String persCelular;
  String persNacimiento;
  String usuaPersonaNombreCompleto;
  String usuaEsAdmin;

  UsuarioModel({
    this.usuaId,
    this.usuaNombreUsuario,
    this.usuaImgUrl,
    this.usuaCorreo,
    this.usuaContrasena,
    this.persId,
    this.persCelular,
    this.persNacimiento,
    this.usuaPersonaNombreCompleto,
    this.usuaEsAdmin,
  });

  Map<String, dynamic> toJson() {
    return {
      'usua_Id': usuaId,
      'usua_NombreUsuario': usuaNombreUsuario,
      'usua_PerfilImage' : usuaImgUrl,
      'usua_Correo': usuaCorreo,
      'usua_Contrasena': usuaContrasena,
      'pers_Id': persId,
      'pers_Celular' : persCelular,
      'pers_FechaNacimiento' : persNacimiento,
      'usua_PersonaNombreCompleto': usuaPersonaNombreCompleto,
      'usua_EsAdmin': usuaEsAdmin,
    };
  }

  factory UsuarioModel.fromJson(Map<String, dynamic> json) {
    return UsuarioModel(
      usuaId: json['usua_Id'],
      usuaNombreUsuario: json['usua_NombreUsuario'],
      usuaImgUrl: json['usua_PerfilImage'],
      usuaCorreo: json['usua_Correo'],
      usuaContrasena: json['usua_Contrasena'],
      persId: json['pers_Id'],
      persCelular: json['pers_Celular'],
      persNacimiento: json['pers_FechaNacimiento'],
      usuaPersonaNombreCompleto: json['usua_PersonaNombreCompleto'],
      usuaEsAdmin: json['usua_EsAdmin'],
    );
  }
}
