import 'dart:convert';

import 'package:http/http.dart' as http;

class VimeoService {
  Future<String?> getVideoUrl(String vimeoUrl) async {
    final videoId = _extractVideoId(vimeoUrl);

    if (videoId == null) {
      throw Exception('Invalid Vimeo URL');
    }

    final html = await _fetchHtml(videoId);

    final config = _extractConfig(html);

    if (config == null) {
      throw Exception('Failed to extract Vimeo config');
    }

    return _extractHlsUrl(config);
  }

  Future<String> _fetchHtml(String videoId) async {
    final response = await http.get(
      Uri.parse('https://player.vimeo.com/video/$videoId'),
      headers: {
        'Origin': 'https://vimeo.com',
        'Referer': 'https://vimeo.com/',
        'Accept': 'text/html,application/xhtml+xml',
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
      },
    );

    return response.body;
  }

  static Map<String, dynamic>? _extractConfig(String html) {
    final regex = RegExp(
      r'window\.playerConfig\s*=\s*({.*?})\s*</script>',
      dotAll: true,
    );

    final match = regex.firstMatch(html);
    if (match == null) return null;

    final jsonString = match.group(1);
    if (jsonString == null) return null;

    return jsonDecode(jsonString);
  }

  String? _extractHlsUrl(Map<String, dynamic> config) {
    try {
      final files = config['request']?['files'];
      final hls = files?['hls'];

      if (hls == null) return null;

      final cdns = hls['cdns'] as Map<String, dynamic>;

      // Prefer fastly_skyfire or fallback to first CDN
      final cdn = cdns['fastly_skyfire'] ?? cdns.values.first;

      return cdn['url'];
    } catch (_) {
      return null;
    }
  }

  String? _extractVideoId(String url) {
    try {
      final uri = Uri.parse(url);

      if (uri.pathSegments.isNotEmpty) {
        return uri.pathSegments.last;
      }

      return null;
    } catch (_) {
      return null;
    }
  }
}
