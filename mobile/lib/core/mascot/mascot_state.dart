/// Mascot ("Kamış", the reed-pen / kalem-i ney character) emotional states
/// (CLAUDE.md §4.3). Art is placeholder SVG; the enum abstracts state so the
/// artwork can be swapped without touching call sites.
enum MascotState {
  normal('assets/mascot/kamis_normal.svg'),
  celebrating('assets/mascot/kamis_celebrate.svg'),
  sad('assets/mascot/kamis_sad.svg'),
  sleeping('assets/mascot/kamis_sleep.svg');

  const MascotState(this.asset);

  /// SVG asset path for this state.
  final String asset;
}
