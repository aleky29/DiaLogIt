/// FeedbackForm is a data class which stores data fields of Feedback.
class DiaForm {
  String fecha;
  String mgdl;
  String unidades;
  String alimentos;
  String actividadPrevia;
  String actividadPosterior;
  String notas;

  DiaForm(this.fecha, this.mgdl, this.unidades, this.alimentos,
      this.actividadPrevia, this.actividadPosterior, this.notas);

  factory DiaForm.fromJson(dynamic json) {
    return DiaForm(
        "${json['fecha']}",
        "${json['mgdl']}",
        "${json['unidades']}",
        "${json['alimentos']}",
        "${json['actividadPrevia']}",
        "${json['actividadPosterior']}",
        "${json['notas']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'fecha': fecha,
        'mgdl': mgdl,
        'unidades': unidades,
        'alimentos': alimentos,
        'actividadPrevia': actividadPrevia,
        'actividadPosterior': actividadPosterior,
        'notas': notas
      };
}
