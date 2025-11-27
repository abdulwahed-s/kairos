String getWeatherSvg(int code) {
  switch (code) {
    case >= 200 && < 300:
      return "thunderstorm.svg";
    case >= 300 && < 400:
      return "drizzle.svg";
    case >= 500 && < 600:
      return "rain.svg";
    case >= 600 && < 700:
      return "snow.svg";
    case >= 700 && < 800:
      return "atmosphere.svg";
    case == 800:
      return "clear.svg";
    case > 800 && <= 804:
      return "clouds.svg";
    default:
      return "unknown.svg";
  }
}
