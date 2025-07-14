class ApiConfig {
  // TMDB API Configuration
  static const String tmdbApiKey = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjYTc2MDk3MTlhNTYxYjM0MWM4MDYyYzMzN2FiZTM5NyIsIm5iZiI6MTc0NDI5MzUwOC4xMDQsInN1YiI6IjY3ZjdjZTg0MzE3NzUyNzZkNmQ5OTM4OCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.jB-LdCFKnX7xETXv3UgAHXffgoCOFK9wfyr6Z8y4AzI';
  static const String tmdbBaseUrl = 'https://api.themoviedb.org/3';
  static const String tmdbImageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  
  // SubDL API Configuration
  static const String subdlApiKey = 'l0cgAb7VNM_KMN2KwkLCFNuRsk8q3tEg';
  static const String subdlBaseUrl = 'https://api.subdl.com';
  
  // Headers for TMDB API
  static Map<String, String> get tmdbHeaders => {
    'Authorization': 'Bearer $tmdbApiKey',
    'Content-Type': 'application/json',
  };
  
  // Headers for SubDL API
  static Map<String, String> get subdlHeaders => {
    'Api-Key': subdlApiKey,
    'Content-Type': 'application/json',
  };
  
  // Getter for subdl API key (for backward compatibility)
  static String get subdl => subdlApiKey;
}