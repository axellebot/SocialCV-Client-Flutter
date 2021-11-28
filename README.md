# Social-CV Flutter App

A new Flutter application about "resumes".

## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.io/).

## Directory structure

- Date:
Contains data layer shared classes that are not framework dependent (e.g. Flutter, AngularDart) or interfaces that must be used by client application
- Domain:
Contains domain layer company rules
- Bloc:
Contains shared business logic components
- Presentation:
Contains commons classes

## Installation

### Config
Use secret template `./config.json.dist` to add secret file `./config.json`

### Generate models
[documentation](https://flutter.io/json/)

Generate : `flutter packages pub run build_runner build` | `flutter packages pub run build_runner watch`
Generate and delete conflicting outputs : `flutter packages pub run build_runner build
--delete-conflicting-outputs`

## License

```
    Copyright 2019 Axel LE BOT

    Licensed under the Creative Common License,
    Attribution-NonCommercial-ShareAlike 4.0 International;
    you may not use this file except in compliance with the License.
    
    You may obtain a copy of the License at
    https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode.txt
```