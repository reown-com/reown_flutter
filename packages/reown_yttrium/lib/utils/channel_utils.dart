class ChannelUtils {
  static dynamic handlePlatformResult(dynamic input) {
    if (input == null) {
      return null; // Handle null explicitly
    } else if (input is Map) {
      return input.map((key, value) {
        // Recursively convert the value, preserving its type
        return MapEntry('$key', handlePlatformResult(value));
      });
    } else if (input is List) {
      // Handle lists by recursively converting their elements
      return input.map((item) => handlePlatformResult(item)).toList();
    }
    // Return scalar values (int, String, bool, double, etc.) as-is
    return input;
  }
}