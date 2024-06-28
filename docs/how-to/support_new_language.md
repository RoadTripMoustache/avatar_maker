# How to support a new language ?

1. Create a new `.arb` file in the `localization/` folder. The name of the new file must be the name of the new language's locale.

*Example*

- `en.arb` for english
- `it.arb` for italian

2. Copy the content of another `.arb` file and paste it into the new file

3. Update the `"@@locale"` parameter with the new language's locale

4. Replace all the values of the other parameters with the correct translated informations in the new language

5. Run the following command to generate again the `src/l10n/app_localizations_xx.dart` files. A new file must be added with the new language.
```shell
flutter pub get
```

Then you should be able to test the widget with the new language.

--- 

## Useful links
- [tooling/l10n](../tooling/l10n.md)