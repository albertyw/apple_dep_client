## 2.2.2 (2017-05-21)

Cleanup:

 - Repository is now at https://github.com/albertyw/apple_dep_client
 - Fixed deprecation in code coverage package

## 2.2.1 (2016-07-23)

Features:

 - Updates to rake, typhoeus, and oauth

## 2.2.0 (2016-01-31)

Features:

 - Change license to GPL
 - Uncap plist gem version

## 2.1.1 (2016-01-13)

Features:

 - Officially support typhoeus 1.0

## 2.1.0 (2015-10-31)

Features:

 - Deprecate device disown (new for iOS 9)
 - Allow `await_device_configured` setting in configuration profiles

## 2.0.1 (2015-10-30)

Features:

 - Allow newer versions of typhoeus
 - Run rubocop and fix coding style issues

## 2.0.0 (2015-09-23)

Features:

 - `apple_dep_client` is now open source with an MIT license
 - Updates to documentation

## 1.2.0 (2015-08-06)

Features:

 - Better error handling for undecryptable device callback data

Bugfixes:

 - Fix checking for `PROFILE_NOT_FOUND` errors when assigning or fetching profiles
 - Fix decrypting device callback data

## 1.1.3 (2015-08-01)

Features:

 - Don't send token decryption errors to stdout
 - Update README with more information

## 1.1.2 (2015-07-23)

Features:

 - Change token decryption errors from RuntimeError to TokenError

## 1.1.1 (2015-06-06)

Bugfixes:

 - Fix saving binary callback data

## 1.1.0 (2015-05-28)

Features:

 - Make User-Agent be customizable

## 1.0.0 (2015-05-07)

Features:

 - Add device sync function

## 0.4.2 (2015-05-07)

Features:

 - Add example code
 - Add ability to query for device information

## 0.4.1 (2015-05-05)

Features:

 - More documentation and code clearnup

## 0.4.0 (2015-05-01)

Features:

 - Add ability to parse device callbacks from signed plist into ruby hash

## 0.3.1 (2015-04-30)

Bugfixes:

 - Fix urls not respecting updates to the `apple_dep_server` config value

## 0.3.0 (2015-04-29)

Bugfixes:

 - Updated syntax of positional arguments

Features:

 - Add in functions for interacting with profiles

## 0.2.1 (2015-04-29)

Features:

 - Simplify error checking

## 0.2.0 (2015-04-27)

Features:

 - Support fetching and disowning devices
 - Support being able to set apple dep server url

## 0.1.2 (2015-04-25)

Bugfixes:

  - Fix usage of public/private keys

## 0.1.1 (2015-04-24)

Features:

  - Overhaul request error checking

## 0.1.0 (2015-04-24)

Features:

  - Add support for decoding encrypted Apple DEP token files
  - Add support for getting DEP account details

## 0.0.1 (2015-04-16)

Features:

  - Initial Gem
