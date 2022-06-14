class FirmenGruppe {
  final String id;
  final String name;

  FirmenGruppe._(this.id, this.name);

  static final List<FirmenGruppe> all = [
    FirmenGruppe._("hk", "Helmsauer Assekuranzmakler AG"),
    FirmenGruppe._("sue", "Dr. Schmidt & Erdsiek Versicherungsmakler"),
    FirmenGruppe._("jade", "Dr. Schmidt & Erdsiek (Ex-Jade)"),
    FirmenGruppe._("bbg", "Dr. Schmidt & Erdsiek (Ex-Berenberg-Gossler)"),
    FirmenGruppe._("aewz", "Ärzte Wirtschaftszentrum Köln"),
    FirmenGruppe._("hp", "Helmsauer und Preuß GmbH"),
    FirmenGruppe._("myh", "myHelmsauer"),
  ];

  static FirmenGruppe fromId(String id) => all.firstWhere((fg) => fg.id == id);
}
