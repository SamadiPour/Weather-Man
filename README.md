# Weather-Man
Weather App with darksky api to view current weather status in flutter    
   
Download Built APK from here   
<a href="https://github.com/SamadiPour/Weather-Man/releases/download/1.0.0/app-release.apk">
<img src="https://github.com/SamadiPour/Weather-Man/blob/master/download.png" height="100">
</a>


## :camera: Screenshots

<table>
  <tr>
    <td>
  <img width="500px" src="https://github.com/SamadiPour/Weather-Man/blob/master/Screenshots/1.png">
    </td>
    <td>
  <img width="500px" src="https://github.com/SamadiPour/Weather-Man/blob/master/Screenshots/2.png">
    </td>
    <td>
  <img width="500px" src="https://github.com/SamadiPour/Weather-Man/blob/master/Screenshots/3.png">
    </td>
    <td>
  <img width="500px" src="https://github.com/SamadiPour/Weather-Man/blob/master/Screenshots/4.png">
    </td>
  </tr>
  <tr>
    <td>
  <img width="500px" src="https://github.com/SamadiPour/Weather-Man/blob/master/Screenshots/5.png">
    </td>
    <td>
  <img width="500px" src="https://github.com/SamadiPour/Weather-Man/blob/master/Screenshots/6.png">
    </td>
    <td>
  <img width="500px" src="https://github.com/SamadiPour/Weather-Man/blob/master/Screenshots/7.png">
    </td>
    <td>
  <img width="500px" src="https://github.com/SamadiPour/Weather-Man/blob/master/Screenshots/8.png">
    </td>
</table>


## :innocent: Features

* Beautiful UI
* Dark Mode
* Current weather: current temperature, max and min temperature, humidity, pressure, wind
* Weather forecast for 7 days
* Weather forecast for 24 hours
* Precipitation Chance chart
* Current Weather icon animation
* Weather based on location
* Google map showing lat & lng  
* On and Off switch for widgets
* Offline database of city names
* Flag of each city
* Reverse GeoCoding Info

## :fist: Getting Started

### Prerequisites
- Flutter
- Dart Sdk
- Google Maps API Key
- geonames.org API Key
- darksky.net API Key

### API Keys
#### Google API

Go to [here](https://console.cloud.google.com/apis) and create new project if you don't have   
then enable Google Maps for Android & Google Maps for IOS   
then get the api key and follow below steps   

- Android
open `AndroidManifest.xml` in `android\app\src\main`   
find this line:

```
<meta-data android:name="com.google.android.geo.API_KEY"
            android:value="YOUR_API_KEY"/>
```

replace your key with `YOUR_API_KEY`

- IOS
open `AppDelegate.m` in `ios\Runner`
find this line:
```
[GMSServices provideAPIKey:@"YOUR_API_KEY"];
```

replace your key with `YOUR_API_KEY`


#### Darksky API

Get Api from [here](https://darksky.net/dev/account)   
open `ApiKey.dart` in `lib\Utilities` then find this line:

```
static const DARK_SKY_API = 'YOUR_API_KEY';
```

replace your key with `YOUR_API_KEY`

#### Geocoding API

Get Api from [here](https://www.geonames.org/login) (Register first. Your api key is your username!)   
open `ApiKey.dart` in `lib\Utilities` then find this line:

```
static const GEO_NAMES_API = 'YOUR_API_KEY';
```

replace your key(Username) with `YOUR_API_KEY`

## :heart: Credits
- API: https://darksky.net - http://www.geonames.org
- Icons: Icons8, FlatIcon
- Animations:
    - Weather Icons Animation: https://www.2dimensions.com/a/SamadiPour/files/flare/weather-flat-icons/preview
    - Liquid Loader: https://www.2dimensions.com/a/SamadiPour/files/flare/liquid-loader/preview
- Flag icons: I can't remember!
- Cities Database: Made from offline data of http://download.geonames.org/export/dump/cities500.zip
    - Converted to JSON with https://github.com/lutangar/cities.json
    - Converted to Sqlite with https://sqlitebiter.readthedocs.io/en/latest/
- Weather Page Design: https://www.uplabs.com/posts/minimal-weather-app-c4063e3e-ef6e-404a-af6b-1a04f069b122
- Fonts: https://fonts.google.com
