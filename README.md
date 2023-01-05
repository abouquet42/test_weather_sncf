# weather_test_sncf

A weather forecast app in flutter which has the following features:
Login and display forecasts of the next 5 days in Paris.

## How to Launch the App
### Prerequisites

Latest version of Flutter: 3.3.10

Launch device.

### Install packages

In terminal, get into the folder weather_test_sncf and execute

```bash
  flutter pub get
```

### Launch the app

Then execute

```bash
  flutter run
```

## Login

The first page on app is login. To simulate a real login, there is only one user that can access the weather forecast.
You can find the credentials below.

email: johndoe@test.fr

password: Password@2023

At successful login, the app store user data mock to display the name on the next screen.

## Forecast weather list

You find the weather forecast every 3 hours over 5 days. The temperature is given in Celsius but you
can change it to kelvin or fahrenheit using the icon located at the top right.

To separate the different days, a header with a date is displayed between.

## Errors

If you have a connection problem, a popup will appear asking you to reconnect to the network.

## Tests

To improve the maintainability of the app, the project contains tests.

To execute the tests, run in the project directory

```bash
  flutter test
```
