# puppet-stns

[![Build Status](https://img.shields.io/travis/STNS/puppet-stns/master.svg?style=flat-square)](https://travis-ci.org/STNS/puppet-stns)
[![Puppet Forge](https://img.shields.io/puppetforge/v/hfm/stns.svg?style=flat-square)](https://forge.puppet.com/hfm/stns)

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with stns](#setup)
   - [Setup requirements](#setup-requirements)
   - [Beginning with stns](#beginning-with-stns)
1. [Usage - Configuration options and additional functionality](#usage)
   - [Configuring stns_v2::server](#configuring-stnsserver)
   - [Configuring stns_v2::client](#configuring-stnsclient)
   - [Configuring modules from Hiera](#configuring-modules-from-hiera)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
   - [Public Classes](#public-classes)
   - [Private Classes](#private-classes)
   - [Defined Types](#defined-types)
   - [Parameters](#parameters)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)
   - [Running tests](#running-tests)
   - [Testing quickstart](#testing-quickstart)

## Description

The STNS module handles installing, configuring, and running [STNS](https://github.com/STNS/STNS) and [libnss_stns](https://github.com/STNS/libnss_stns) on [stns.jp](http://stns.jp).

## Setup

### Setup Requirements

The STNS module requires the following puppet modules:

- [puppetlabs-stdlib](https://forge.puppet.com/puppetlabs/stdlib): version 4.0 or newer.
- [puppetlabs-apt](https://forge.puppet.com/puppetlabs/apt): version 2.0 or newer (only Debian-based distributions).

Both puppetlabs-apt is soft dependencies. If you are installing on Debian or RedHat-based systems, you will need to configure appropriate versions of those modules.

### Beginning with STNS

To install the STNS server with default parameters, declare the `stns_v2::server` class.

```puppet
include ::stns_v2::server
```

To install the STNS client (libnss\_stns) with default parameters, declare the `stns_v2::client` class.

```puppet
include ::stns_v2::client
```

## Usage

### Configuring stns_v2::server

```puppet
class { '::stns_v2::server':
  port           => 1104,
  user           => 'sample',
  password       => 's@mp1e',
  package_ensure => latest,
}

# Configures users and groups
stns_v2::server::users {
  'foo':
    id         => 1001,
    group_id   => 1001,
    directory  => '/home/foo',
    shell      => '/bin/bash';

  'bar':
    id         => 1002,
    group_id   => 1001,
    directory  => '/home/bar',
    shell      => '/bin/bash';
}

stns_v2::server::groups { 'sample':
  id    => 1001,
  users => [
    'foo',
    'bar',
  ],
}
```

### Configuring stns_v2::client

```puppet
class { '::stns_v2::client':
  api_end_point      => 'http://stns.example.jp:1104',
  user               => 'sample',
  password           => 's@mp1e',
  wrapper_path       => '/usr/local/bin/stns-query-wrapper',
  chain_ssh_wrapper  => '/usr/libexec/openssh/ssh-ldap-wrapper',
  ssl_verify         => true,
  request_timeout    => 3,
  http_proxy         => 'http://proxy.example.com:1104',
  libnss_stns_ensure => latest,
  handle_nsswitch    => true,
  handle_sshd_config => true,
}
```

### Configuring modules from Hiera

```yaml
---
stns_v2::server::port: 1104
stns_v2::server::user: sample
stns_v2::server::password: s@mp1e
stns_v2::server::package_ensure: latest

stns_v2::client::api_end_point: 'http://stns1.example.jp:1104'
stns_v2::client::user: sample
stns_v2::client::password: s@mp1e
stns_v2::client::wrapper_path: '/usr/local/bin/stns-query-wrapper'
stns_v2::client::chain_ssh_wrapper: null
stns_v2::client::ssl_verify: true
stns_v2::client::request_timeout: 3
stns_v2::client::http_proxy: 'http://proxy.example.com:1104'
stns_v2::client::libnss_stns_ensure: latest
stns_v2::client::handle_nsswitch: true
stns_v2::client::handle_sshd_config: true
```

## Reference

### Public Classes

- [`stns_v2::server`](#stnsserver): Installs and configures STNS.
- [`stns_v2::client`](#stnsclient): Installs and configures libnss\_stns.

### Private Classes

- `stns_v2::repo`: Setup STNS repository.
- `stns_v2::server::install`: Installs STNS package.
- `stns_v2::server::config`: Configures STNS.
- `stns_v2::server::server`: Manages service.
- `stns_v2::client::install`: Installs packages for libnss\_stns.
- `stns_v2::client::config`: Configures

### Defined Types

- `stns_v2::server::users`: Specifies a STNS users configuration file.
- `stns_v2::server::groups`: Specifies a STNS groups configuration file.

### Parameters

#### Class: `stns_v2::server`

- `port`: Specifies a listen port listen. Valid options: a number of a port number. Default: 1104.
- `user`: Specifies a user for authentication. Valid options: a string containing a valid username. Default: undef.
- `password`: Specifies a password for authentication. Valid options: a string containing a valid password. Default: undef.
- `package_ensure`: What state the packages should be in.

#### Class: `stns_v2::client`

- `api_end_point`: Valid options: a string containing a valid url. Default: undef.
- `user`: Specifies a user for authentication. Valid options: a string containing a valid username. Default: undef.
- `password`: Specifies a password for authentication. Valid options: a string containing a valid password. Default: undef.
- `wrapper_path`: Valid options: absolute path. Default: '/usr/local/bin/stns-query-wrapper'.
- `chain_ssh_wrapper`: Default: undef.
- `ssl_verify`: Enables SSL verification. Valid options: a boolean. Default: true.
- `request_timeout`: Wrapper Command Timeout. Valid options: a number. Default: 3.
- `http_proxy`: Valid options: a string. Default: undef.
- `uid_shift`: Shift uid. Valid options: a number. Default: 0.
- `gid_shift`: Shift gid. Valid options: a number. Default: 0.
- `libnss_stns_ensure`: What state the libnss-stns package should be in.
- `handle_nsswitch`: Configure nsswitch.conf to use STNS. Valid options: a boolean. Default: false.
- `handle_sshd_config`: Configure sshd\_config to use STNS. Valid options: a boolean. Default: false.

#### Defined Types: `stns_v2::server::users`

- `id`: Specifies the user ID. Valid options: a number type. Default: undef.
- `group_id`: Specifies the user's primary group. Valid options: a number type. Default: undef.
- `directory`: Specifies the home directory of the user. Valid options: a string containing a valid path. Default: `/home/<resource title>`.
- `shell`: Specifies the user's login shell. Valid options: a string containing a valid path. Default: `/bin/bash`.
- `keys`: Specify user attributes in an array of key = value pairs. Valid options: a string containing a valid key = value pairs. Default: undef.
- `link_users`: Valid options: a string containing a valid password. Default: undef.

#### Defined Types: `stns_v2::server::groups`

- `id`: Specifies the group ID. Valid options: a number type. Default: undef.
- `users`: Specifies the members of the group. Valid options: a string containing a valid password. Default: undef.

##### Parameters

## Limitations

This module has been tested on:

- RedHat Enterprise Linux 7
- CentOS 7
- Scientific Linux 7
- Debian 8
- Ubuntu 16.04

## Development

### Running tests

The STNS puppet module contains tests for both [rspec-puppet](http://rspec-puppet.com/) (unit tests) and [beaker-rspec](https://github.com/puppetlabs/beaker-rspec) (acceptance tests) to verify functionality. For detailed information on using these tools, please see their respective documentation.

#### Testing quickstart

- Unit tests:

```console
$ bundle install
$ bundle exec rake
```

- Acceptance tests:

```console
# Set your DOCKER_HOST variable
$ eval "$(docker-machine env default)"

# List available beaker nodesets
$ bundle exec rake beaker_nodes
centos7
jessie
xenial

# Run beaker acceptance tests
$ BEAKER_set=centos7 bundle exec rake beaker
```
