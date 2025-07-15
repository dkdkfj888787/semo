class ApiConfig {
  // TMDB API Configuration
  static const String tmdbApiKey = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjYTc2MDk3MTlhNTYxYjM0MWM4MDYyYzMzN2FiZTM5NyIsIm5iZiI6MTc0NDI5MzUwOC4xMDQsInN1YiI6IjY3ZjdjZTg0MzE3NzUyNzZkNmQ5OTM4OCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.jB-LdCFKnX7xETXv3UgAHXffgoCOFK9wfyr6Z8y4AzI';
  static const String tmdbBaseUrl = 'https://api.themoviedb.org/3';
  static const String tmdbImageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String tmdbImageOriginalUrl = 'https://image.tmdb.org/t/p/original';
  
  // SubDL API Configuration
  static const String subdlApiKey = 'l0cgAb7VNM_KMN2KwkLCFNuRsk8q3tEg';
  static const String subdlBaseUrl = 'https://api.subdl.com';
  
  // API Headers
  static Map<String, String> get tmdbHeaders => {
    'Authorization': 'Bearer $tmdbApiKey',
    'Content-Type': 'application/json',
  };
  
  static Map<String, String> get subdlHeaders => {
    'Api-Key': subdlApiKey,
    'Content-Type': 'application/json',
  };
  
  // API Endpoints
  static String get popularMovies => '$tmdbBaseUrl/movie/popular';
  static String get topRatedMovies => '$tmdbBaseUrl/movie/top_rated';
  static String get upcomingMovies => '$tmdbBaseUrl/movie/upcoming';
  static String get nowPlayingMovies => '$tmdbBaseUrl/movie/now_playing';
  
  static String get popularTvShows => '$tmdbBaseUrl/tv/popular';
  static String get topRatedTvShows => '$tmdbBaseUrl/tv/top_rated';
  static String get onTheAirTvShows => '$tmdbBaseUrl/tv/on_the_air';
  static String get airingTodayTvShows => '$tmdbBaseUrl/tv/airing_today';
  
  static String movieDetails(int movieId) => '$tmdbBaseUrl/movie/$movieId';
  static String tvShowDetails(int tvId) => '$tmdbBaseUrl/tv/$tvId';
  static String searchMovies(String query) => '$tmdbBaseUrl/search/movie?query=$query';
  static String searchTvShows(String query) => '$tmdbBaseUrl/search/tv?query=$query';
  
  // SubDL Endpoints
  static String get subdlSearch => '$subdlBaseUrl/subtitles';
  static String subdlDownload(String subtitleId) => '$subdlBaseUrl/subtitles/$subtitleId/download';
  
  // Image URLs
  static String getImageUrl(String? imagePath, {bool original = false}) {
    if (imagePath == null || imagePath.isEmpty) return '';
    final baseUrl = original ? tmdbImageOriginalUrl : tmdbImageBaseUrl;
    return '$baseUrl$imagePath';
  }
  
  static String getPosterUrl(String? posterPath) => getImageUrl(posterPath);
  static String getBackdropUrl(String? backdropPath) => getImageUrl(backdropPath, original: true);
  
  // Getter for subdl API key (for backward compatibility)
  static String get subdl => subdlApiKey;
}