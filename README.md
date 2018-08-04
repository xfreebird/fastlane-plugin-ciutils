# ciutils plugin

[![fastlane Plugin Badge](https://rawcdn.githack.com/fastlane/fastlane/master/fastlane/assets/plugin-badge.svg)](https://rubygems.org/gems/fastlane-plugin-ciutils)

## Getting Started

This project is a [fastlane](https://github.com/fastlane/fastlane) plugin. To get started with `fastlane-plugin-ciutils`, add it to your project by running:

```bash
bundle exec fastlane add_plugin ciutils
```

## About ciutils

Various utilities for CI and Xcode project configuration. 

action                   |description
-------------------------|-------
`en_ci_utils_init`            | Initializes several environment variables:  <br>**gym**<br>`GYM_OUTPUT_DIRECTORY`=**`build`**<br> `GYM_BUILDLOG_PATH`=**`build/logs/gym`**  <br><br>**scan**<br>`SCAN_OUTPUT_DIRECTORY`=**`build/reports/unittests`**<br>`SCAN_BUILDLOG_PATH`=**`build/logs/scan/`**<br>`SCAN_DERIVED_DATA_PATH`=**`build/deriveddata`** <br>`SCAN_OUTPUT_TYPES`=**`html,junit,json-compilation-database`**<br><br>**slather**<br>`FL_SLATHER_BUILD_DIRECTORY`=**`build/deriveddata`**<br>`FL_SLATHER_USE_BUNDLE_EXEC`=**`true`**<br>`FL_SLATHER_OUTPUT_DIRECTORY`=**`build/reports/`**<br> `FL_SLATHER_COBERTURA_XML_ENABLED`=**`true`**<br><br>**build number**<br>`BUILD_NUMBER` and `FL_BUILD_NUMBER_BUILD_NUMBER` are initialized with the current build number regardless of CI environment. When run on desktop, it us always `1`<br><br>
`en_profile_name`    | Returns the provisioning profile name by path or uuid
`en_build_number`    | Returns the value of current build number regardless of CI environment. If run on desktop, then is always `1`
`en_setup_keychain`  | Creates a keychain and imports the provided certificate
`en_remove_keychain` | Removes the keychain created by ```en_setup_keychain``` and restores the default keychain
`en_git_changelog`   | Creates the changelog based on git commits by filtering commit messages by a keyword
`en_close_simulator` | Quits the simulator
`en_install_provisioning_profiles` | Copies all provisioning profiles from project folder to `~/Library/MobileDevice/Provisioning Profiles`
`en_setup_project` | Updates Xcode projects, Info.plist, Entitlements file and any other plist file using values from the provided yaml file.



## Example

Check out the [example `Fastfile`](fastlane/Fastfile) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane test`.

## Run tests for this plugin

To run both the tests, and code style validation, run

```
rake
```

To automatically fix many of the styling issues, use
```
rubocop -a
```

## Issues and Feedback

For any other issues and feedback about this plugin, please submit it to this repository.

## Troubleshooting

If you have trouble using plugins, check out the [Plugins Troubleshooting](https://github.com/fastlane/fastlane/blob/master/fastlane/docs/PluginsTroubleshooting.md) doc in the main `fastlane` repo.

## Using `fastlane` Plugins

For more information about how the `fastlane` plugin system works, check out the [Plugins documentation](https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Plugins.md).

## About `fastlane`

`fastlane` is the easiest way to automate beta deployments and releases for your iOS and Android apps. To learn more, check out [fastlane.tools](https://fastlane.tools).
