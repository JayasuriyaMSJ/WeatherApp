# intern_weather

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


## Clean Architecture 

In clean architecture, the structure is designed to separate concerns, making your application more maintainable and testable. Here's how you can organize your API key and the purpose of the `data`, `domain`, and `presentation` layers:

### 1. **Data Layer**:
   - **Purpose**: The `data` layer is responsible for data handling. This includes making API calls, handling local data storage, and converting raw data into domain models.
   - **API Key Location**: 
     - You can place the API key in the `data` layer, specifically in a configuration file or as part of your API service class. It’s common to store it in a `*.env` file or a constants file within the `data` layer.
     - Example: `lib/features/weather/data/datasources/api_service.dart` might contain your API calls and use the API key.

### 2. **Domain Layer**:
   - **Purpose**: The `domain` layer is the core of your application’s business logic. It contains use cases (interactors) and the domain models that your app works with. This layer should be independent of any data source or presentation logic.
   - **No API Key Here**: The domain layer should not know about the API key or where the data comes from; it only knows how to perform operations using the data it receives from the `data` layer.

### 3. **Presentation Layer**:
   - **Purpose**: The `presentation` layer is concerned with UI and state management. This is where your widgets, BLoCs, or other state management solutions reside.
   - **No API Key Here**: The presentation layer should not be aware of the API key or the implementation details of the data layer.

### Example Structure:
```plaintext
lib/
└── features/
    └── weather/
        ├── data/
        │   ├── datasources/
        │   │   └── api_service.dart
        │   ├── models/
        │   └── repositories/
        ├── domain/
        │   ├── entities/
        │   └── usecases/
        └── presentation/
            ├── blocs/
            └── screens/
```

### Summary:
- **Data Layer**: Place the API key in the `data` layer, likely within an API service or configuration file.
- **Domain Layer**: Contains business logic, use cases, and domain models. It’s independent of where data comes from.
- **Presentation Layer**: Handles UI and state management. It interacts with the domain layer but is unaware of the data source specifics.

This structure helps keep your app modular and easy to maintain, ensuring that changes in one part of the app don’t unnecessarily affect others.

Let's delve deeper into each of these layers—`datasources`, `models`, `repositories`, `entities`, and `usecases`—using a real-time weather application as an example.

### Data Layer

#### 1. **Datasources (`datasources/`)**:
   - **Purpose**: This is where you define how data is fetched. Datasources can be remote (e.g., from an API) or local (e.g., from a database or cache).
   - **In a Weather App**:
     - **API Service (`api_service.dart`)**: This class will handle API calls to fetch weather data from an external service (e.g., OpenWeatherMap API). It uses the API key to authenticate the requests.
     - Example:
       ```dart
       class ApiService {
         final http.Client client;
         final String apiKey;

         ApiService({required this.client, required this.apiKey});

         Future<WeatherModel> fetchWeather(String city) async {
           final response = await client.get(
             Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey'),
           );

           if (response.statusCode == 200) {
             return WeatherModel.fromJson(json.decode(response.body));
           } else {
             throw Exception('Failed to load weather data');
           }
         }
       }
       ```
     - **Local DataSource** (optional): If your app supports offline mode, you might also have a local datasource to fetch cached data.

#### 2. **Models (`models/`)**:
   - **Purpose**: Models in the data layer represent the raw data structures received from the API. These models are typically mapped to and from JSON.
   - **In a Weather App**:
     - **WeatherModel**: Represents the weather data structure as received from the API.
     - Example:
       ```dart
       class WeatherModel {
         final String cityName;
         final double temperature;
         final String description;

         WeatherModel({required this.cityName, required this.temperature, required this.description});

         factory WeatherModel.fromJson(Map<String, dynamic> json) {
           return WeatherModel(
             cityName: json['name'],
             temperature: json['main']['temp'],
             description: json['weather'][0]['description'],
           );
         }

         Map<String, dynamic> toJson() {
           return {
             'name': cityName,
             'main': {'temp': temperature},
             'weather': [{'description': description}],
           };
         }
       }
       ```

#### 3. **Repositories (`repositories/`)**:
   - **Purpose**: Repositories act as a bridge between the data layer and the domain layer. They abstract away the details of data sources and provide a clean API for the domain layer to interact with.
   - **In a Weather App**:
     - **WeatherRepository**: This repository will have methods like `getWeatherForCity(String city)`, which the domain layer will call to fetch weather data. The repository will decide whether to fetch data from a remote source, local source, or both.
     - Example:
       ```dart
       class WeatherRepository {
         final ApiService apiService;

         WeatherRepository({required this.apiService});

         Future<WeatherEntity> getWeatherForCity(String city) async {
           final weatherModel = await apiService.fetchWeather(city);
           return WeatherEntity(
             cityName: weatherModel.cityName,
             temperature: weatherModel.temperature,
             description: weatherModel.description,
           );
         }
       }
       ```

### Domain Layer

#### 4. **Entities (`entities/`)**:
   - **Purpose**: Entities are the core business objects used across the domain layer. They are typically plain Dart classes and are independent of the data source. These entities are what your app’s core logic operates on.
   - **In a Weather App**:
     - **WeatherEntity**: This would represent the weather data in your domain layer. It might have the same fields as `WeatherModel`, but it’s independent of the data source.
     - Example:
       ```dart
       class WeatherEntity {
         final String cityName;
         final double temperature;
         final String description;

         WeatherEntity({
           required this.cityName,
           required this.temperature,
           required this.description,
         });
       }
       ```

#### 5. **Use Cases (`usecases/`)**:
   - **Purpose**: Use cases (or interactors) represent the operations your app can perform. They contain the business logic of your application, orchestrating how data is fetched or manipulated.
   - **In a Weather App**:
     - **GetWeatherForCity**: This use case might be responsible for fetching the weather data for a given city. It interacts with the repository to get the data.
     - Example:
       ```dart
       class GetWeatherForCity {
         final WeatherRepository repository;

         GetWeatherForCity(this.repository);

         Future<WeatherEntity> execute(String city) async {
           return await repository.getWeatherForCity(city);
         }
       }
       ```
     - In your presentation layer, you’ll typically inject this use case into a BLoC or ViewModel to handle the business logic.

### Summary
- **Data Layer**:
  - **Datasources**: Handles how data is fetched (e.g., API calls, local storage).
  - **Models**: Maps the raw data from the data source to Dart objects.
  - **Repositories**: Provides a clean API for the domain layer, hiding the details of data fetching.

- **Domain Layer**:
  - **Entities**: Represents the core data your app operates on.
  - **Use Cases**: Contains the business logic and orchestrates data fetching and operations.

This separation ensures that your app’s business logic (domain) is independent of the external data sources (data), making your app easier to test and maintain.