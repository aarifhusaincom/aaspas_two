import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class VideoCacheManager extends CacheManager {
  static const key = 'videoCache';

  static VideoCacheManager? _instance;

  factory VideoCacheManager() {
    _instance ??= VideoCacheManager._();
    return _instance!;
  }

  VideoCacheManager._()
    : super(
        Config(
          key,
          stalePeriod: const Duration(days: 7),
          maxNrOfCacheObjects: 500,
          repo: JsonCacheInfoRepository(databaseName: key),
          fileService: HttpFileService(),
          fileSystem: IOFileSystem(key),
        ),
      );
}
