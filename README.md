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
`en_ci_utils_init`            | Initializes enviornment variables for **gym**, **scan**, **slather**, **oclint**, **swiftlint** and **lizard**. <br> It forces all these actions to put all outputs to the **build** folder (e.g. derived data, logs, scan reports, slather reports, oclint report, lizard reports and swiftlint reports)
`en_setup_project` | Updates Xcode projects, Info.plist, Entitlements file and any other plist file using values from the provided yaml file [example `appstore.yml`](Demo/config/appstore.yml)
`en_create_sonar_reports` | Creates sonarqube reports (unit tests, code coverage, static code analysis with swiftlint, oclint and lizard) to be used with the open source sonarqube plugins for Swift and Objective-C
`en_build_number`    | Returns the value of current build number regardless of CI environment. If run on desktop, then is always `1`
`en_setup_keychain`  | Creates a keychain and if provided, it imports the give certificate file. It also updates **match** environment variables to use the new created keychain.
`en_remove_keychain` | Removes the keychain created by ```en_setup_keychain``` and restores the default keychain
`en_git_changelog`   | Creates the changelog based on git commits by filtering commit messages by a keyword
`en_close_simulator` | Quits the simulator
`en_install_provisioning_profiles` | Copies all provisioning profiles from project folder to `~/Library/MobileDevice/Provisioning Profiles`. <br> Useful when signing certificates and provisioning profiles are managed directly from the Fastfile.
`en_profile_name`    | Returns the provisioning profile name by path or uuid



## Example

Check out the [example `Fastfile`](fastlane/Fastfile) and [project `FastlaneDemo`](Demo) to see how to use this plugin. Try it by cloning the repo, running `fastlane install_plugins` and `bundle exec fastlane build`.

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
