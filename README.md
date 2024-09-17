# Weather App

## Overview

The Weather App is a Flutter-based application that provides real-time weather information, including a 5-day forecast with 3-hour intervals. The app integrates multiple features such as current weather conditions, air quality index (AQI), and forecast data. It offers a clean and user-friendly interface for easy navigation through the forecast.

## Features

- **Real-time Weather Updates**: Displays current weather information for the user's location, including temperature, weather conditions, and AQI data.
- **5-day Weather Forecast**: Provides a detailed forecast for the upcoming 5 days, with 3-hour interval data visualization.
- **Graphical Representation**: Weather data is visualized using graphs, making it easy to interpret temperature trends throughout the day.
- **Location-Based Data**: Automatically fetches weather data based on the user's location.
- **Scrollable and Interactive UI**: Users can scroll through the forecast and view detailed weather data for specific days.

## Architecture

This app is built following **Clean Architecture** principles to ensure a scalable, maintainable, and testable codebase. The project is structured into **domain**, **data**, and **presentation** layers, each with clearly defined responsibilities.

- **Domain Layer**: Contains business logic, including entities and use cases.
- **Data Layer**: Manages the retrieval of weather and AQI data from APIs.
- **Presentation Layer**: Manages UI elements and state, using BLoC (Business Logic Component) for state management.

## SOLID Principles

The app adheres to the **SOLID principles** to promote better code organization, easier maintainability, and flexibility for future updates. 

- **S**: Single Responsibility Principle – Each class in the app has a well-defined responsibility.
- **O**: Open/Closed Principle – The app’s structure is open for extension but closed for modification.
- **L**: Liskov Substitution Principle – Interchangeability of components is achieved without altering functionality.
- **I**: Interface Segregation Principle – Interfaces are client-specific, ensuring minimal dependency.
- **D**: Dependency Inversion Principle – Higher-level modules do not depend on lower-level ones but on abstractions.

## Tech Stack

- **Flutter**: Frontend framework for building the app.
- **BLoC**: State management solution.
- **OpenWeatherMap API**: Source for weather data.
- **Dart**: Programming language.

## Conclusion

This weather app is a clean, efficient solution for displaying weather data while adhering to best coding practices, including clean architecture and SOLID principles, to maintain a robust and scalable application.
