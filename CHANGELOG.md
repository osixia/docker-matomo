# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [3.13.5] - 2020-05-04
### Changed
  - Upgrade Matomo version to 3.13.5


## [3.13.0] - 2019-11-27
### Changed
  - Upgrade Matomo version to 3.13.0

## [3.12.0] - 2019-11-09
## Added
  - Multiarch support

### Changed
  - Upgrade Matomo version to 3.12.0
  - Upgrade baseimage to web-baseimage:1.2.0 (debian buster)

## [3.11.0] - 2019-07-26
### Changed
  - Upgrade Matomo version to 3.11.0
  - Upgrade baseimage: web-baseimage:1.2.0

## [3.9.1-1] - 2019-04-06
### Fixed
  - Cron log with /usr/bin/logger
  - Clean unnecessary files

## [3.9.1] - 2019-03-21
### Changed
  - Upgrade Matomo version to 3.9.1

### Fixed
  - Cron log to /proc/self/fd/1 and /proc/self/fd/2

## [3.8.1] - 2019-01-30
### Changed
  - Upgrade Matomo version to 3.8.1

## [3.8.0] - 2019-01-22
### Changed
  - Upgrade Matomo version to 3.8.0

## [3.7.0] - 2018-11-29
### Changed
  - Upgrade Matomo version to 3.7.0

## [3.6.1] - 2018-11-08
### Changed
  - Upgrade Matomo version to 3.6.1

## [3.6.0] - 2018-09-05
### Changed
  - Upgrade Matomo version to 3.6.0

## [3.5.1] - 2018-05-26
### Changed
  - Upgrade Matomo version to 3.5.1

## [3.5.0] - 2018-05-16
### Added
  - MariaDB ssl

### Changed
  - Upgrade Matomo version to 3.5.0

## [3.4.0] - 2018-03-28
### Changed
  - Upgrade Matomo version to 3.4.0

## [3.3.0] - 2018-01-13
### Changed
  - Upgrade Matomo version to 3.3.0 (formerly Piwik)
  - Upgrade baseimage: web-baseimage:1.1.1

## [3.2.1] - 2017-12-07
### Changed
  - Upgrade Piwik version to 3.2.1

## [3.2.0] - 2017-12-06
### Added
  - robots.txt
### Changed
  - Upgrade Piwik version to 3.2.0
  - Upgrade baseimage: web-baseimage:1.1.1

## [3.1.1] - 2017-10-12
### Added
  - PIWIK_FORCE_UPDATE environment variable

### Changed
  - Upgrade Piwik version to 3.1.1

## [3.1.0] - 2017-09-20
### Added
  - Opcache config
### Changed
  - Upgrade Piwik version to 3.1.0

## [3.0.4] - 2017-07-19
### Changed
  - Upgrade Piwik version to 3.0.4
  - Upgrade baseimage: web-baseimage:1.1.0 (debian stretch, php7)

## [2.17.1] - 2016-11-14
### Changed
  - Upgrade Piwik version to 2.17.1
  - chmod 600 on backups
  - Upgrade baseimage: web-baseimage:0.1.12

## [2.17.0] - 2016-10-28
### Added
  - Database backup
  - Ldap tls configuration
### Changed
  - Upgrade Piwik version to 2.17.0

## [2.16.5] - 2016-10-17
### Changed
  - Upgrade Piwik version to 2.16.5

## 2.16.2 - 2016-09-24
Initial release

[3.13.5]: https://github.com/osixia/docker-matomo/compare/v3.13.0...v3.13.5
[3.13.0]: https://github.com/osixia/docker-matomo/compare/v3.12.0...v3.13.0
[3.12.0]: https://github.com/osixia/docker-matomo/compare/v3.11.0...v3.12.0
[3.11.0]: https://github.com/osixia/docker-matomo/compare/v3.9.1-1...v3.11.0
[3.9.1-1]: https://github.com/osixia/docker-matomo/compare/v3.9.1...v3.9.1-1
[3.9.1]: https://github.com/osixia/docker-matomo/compare/v3.8.1...v3.9.1
[3.8.1]: https://github.com/osixia/docker-matomo/compare/v3.8.0...v3.8.1
[3.8.0]: https://github.com/osixia/docker-matomo/compare/v3.7.0...v3.8.0
[3.7.0]: https://github.com/osixia/docker-matomo/compare/v3.6.1...v3.7.0
[3.6.1]: https://github.com/osixia/docker-matomo/compare/v3.6.0...v3.6.1
[3.6.0]: https://github.com/osixia/docker-matomo/compare/v3.5.1...v3.6.0
[3.5.1]: https://github.com/osixia/docker-matomo/compare/v3.5.0...v3.5.1
[3.5.0]: https://github.com/osixia/docker-matomo/compare/v3.4.0...v3.5.0
[3.4.0]: https://github.com/osixia/docker-matomo/compare/v3.3.0...v3.4.0
[3.3.0]: https://github.com/osixia/docker-matomo/compare/v3.2.1...v3.3.0
[3.2.1]: https://github.com/osixia/docker-matomo/compare/v3.2.0...v3.2.1
[3.2.0]: https://github.com/osixia/docker-matomo/compare/v3.1.1...v3.2.0
[3.1.1]: https://github.com/osixia/docker-matomo/compare/v3.1.0...v3.1.1
[3.1.0]: https://github.com/osixia/docker-matomo/compare/v3.0.4...v3.1.0
[3.0.4]: https://github.com/osixia/docker-matomo/compare/v2.17.1...v3.0.4
[2.17.1]: https://github.com/osixia/docker-matomo/compare/v2.17.0...v2.17.1
[2.17.0]: https://github.com/osixia/docker-matomo/compare/v2.16.5...v2.17.0
[2.16.5]: https://github.com/osixia/docker-matomo/compare/v2.16.2...v2.16.5
