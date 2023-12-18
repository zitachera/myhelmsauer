class FirmenGruppe {
  final String id;
  final String name;

  FirmenGruppe._(this.id, this.name);

  static final List<FirmenGruppe> all = [
    FirmenGruppe._("hk", "Helmsauer & Kollegen"),
    FirmenGruppe._("sue", "Dr. Schmidt & Erdsiek"),
    FirmenGruppe._("aewz", "AEWZ Ärzte-Wirtschafts-Zentrum"),
    FirmenGruppe._("hp", "Helmsauer & Preuß"),
    FirmenGruppe._("idf", "Ingenieur-Dienst-Finanzberatung"),
    FirmenGruppe._("ufb", "UFB:UMU"),
    FirmenGruppe._("verri", "VerRi"),
    FirmenGruppe._("myh", "myHelmsauer"),
  ];

  static FirmenGruppe fromId(String id) => all.firstWhere((fg) => fg.id == id);
}
