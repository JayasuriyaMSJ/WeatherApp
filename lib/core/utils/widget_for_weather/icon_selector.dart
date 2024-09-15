String getWeatherIcon(int code) {
  switch (code) {
    case >= 200 && < 300:
      return 'assets/icon/1.png';
    case >= 300 && < 400:
      return 'assets/icon/2.png';
    case >= 500 && < 600:
      return 'assets/icon/3.png';
    case >= 600 && < 700:
      return 'assets/icon/4.png';
    case >= 700 && < 800:
      return 'assets/icon/5.png';
    case == 800:
      return 'assets/icon/6.png';
    case > 800 && <= 804:
      return 'assets/icon/7.png';
    default:
      return 'assets/icon/7.png';
  }
}
