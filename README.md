# Typo3 Toolchain in Docker

[![GitHub version](https://badge.fury.io/gh/o-slash%2Fdocker-typo3-toolchain.svg)](https://badge.fury.io/gh/o-slash%2Fdocker-typo3-toolchain) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Docker images in this repository provide tools and dependencies for development, continuous integration and production stages for Typo3 based websites. **They doesn't cointain Typo3 code which has to be installed via composer**.

## Basic usage

### In a development context

To start you need a directory with at least a fully configured *composer.json* file like this one:

```json
{
  "name": "vendor/mywebsite",
  "description": "My Typo3 Website",
  "type": "typo3-cms-website",
  "authors": [
    {
      "name": "John Smith",
      "email": "j.smith@example.com"
    }
  ],
  "license": "ISC",
  "homepage": "https://github.com/vendor/my-website",
  "version": "1.0.0",
  "repositories": [
    {
      "type": "composer",
      "url": "https://composer.typo3.org/"
    }
  ],
  "require": {
    "typo3/cms": "^8.7.0"
  },
  "extra": {
    "typo3/cms": {
      "cms-package-dir": "{$vendor-dir}/typo3/cms",
      "web-dir": "web"
    }
  }
}
```

Note the ```"web-dir": "web"``` directive which is important.

Now you can have a brand new Typo3 installation ready for development at http://localhost:8080 just with:

```bash
docker run -v/my/proj/dir:/var/www/site -p8080:80 -e TYPO3_CONTEXT=Development --rm -it mulgo/typo3-toolchain:8.7-latest
```

### In continuous integration

Docker images provide the following tools that can be used in CI/CD pipelines:

* [composer](https://deployer.org/) dependency manager
* [phing](https://www.phing.info/) build system
* [PHPUnit](https://phpunit.de/) testing framework
* [BeHat](http://behat.org) behavior-driven development framework
* [deployer](https://deployer.org/) deployment tool

### In a production context

You can build production images just copying your source code in the working directory. Here is a minimal Dockerfile doing just that.

```Dockerfile
FROM mulgo/typo3-toolchain:8.7
COPY . /var/www/site
WORKDIR /var/www/site
```

## Available tags

This repository offers the following image tags:

- `8.7`, `8.7-latest` whith support for Typo3 in `8.7.*` branch.
- `7.6`, `7.6-latest` whith support for Typo3 in `7.6.*` branch.
- `6.2`, `6.2-latest` whith support for Typo3 in `6.2.*` branch.
