/// View models for the learning path (CLAUDE.md §4.1).
enum NodeStatus { locked, available, completed }

enum NodeType { letter, vocab, reading, review, checkpoint }

NodeType nodeTypeFromString(String s) => switch (s) {
      'letter' => NodeType.letter,
      'vocab' => NodeType.vocab,
      'reading' => NodeType.reading,
      'review' => NodeType.review,
      'checkpoint' => NodeType.checkpoint,
      _ => NodeType.vocab,
    };

NodeStatus nodeStatusFromString(String s) => switch (s) {
      'completed' => NodeStatus.completed,
      'available' => NodeStatus.available,
      _ => NodeStatus.locked,
    };

class PathNode {
  const PathNode({
    required this.id,
    required this.type,
    required this.title,
    required this.contentRefs,
    required this.status,
    required this.stars,
    required this.ordinal,
  });

  final String id;
  final NodeType type;
  final String title;
  final List<String> contentRefs;
  final NodeStatus status;
  final int stars;
  final int ordinal;

  bool get isPlayable => status != NodeStatus.locked;
}

class PathUnit {
  const PathUnit({required this.id, required this.title, required this.nodes});

  final String id;
  final String title;
  final List<PathNode> nodes;

  int get completedCount =>
      nodes.where((n) => n.status == NodeStatus.completed).length;
}
