# clevis

master branch: [![Build Status](https://secure.travis-ci.org/millerjl1701/millerjl1701-clevis.png?branch=master)](http://travis-ci.org/millerjl1701/millerjl1701-clevis)

#### Table of Contents

1. [Module Description - What the module does and why it is useful](#module-description)
1. [Setup - The basics of getting started with clevis](#setup)
    * [What clevis affects](#what-clevis-affects)
    * [Beginning with clevis](#beginning-with-clevis)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Module Description

This module manages the installation and configuration of the clevis service - the client side component of Network Bound Disk Encryption (NBDE). 

This module does not currently support associating LUKS volumes with TANG servers nor luksmeta management. This work is planned to occur; however, it has not started.

This module does not manage the TANG server component of NBDE. If you are looking to do so consider using the [millerjl1701/tang](https://forge.puppet.com/millerjl1701/tang) module.

This module does not attempt to manage LUKS encrypted containers of volumes. If you are looking to do so, consider using the [sammcj/luks](https://forge.puppet.com/sammcj/luks) module.

Documentation concerning the clevis client service on RHEL/CentOS systems may be found at:
* https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/security_guide/sec-using_network-bound_disk_encryption
* https://rhelblog.redhat.com/2018/04/13/an-easier-way-to-manage-disk-decryption-at-boot-with-red-hat-enterprise-linux-7-5-using-nbde/

Note: NBDE was initilly released with RedHat/CentOS version 7.4 with complete support arriving with RedHat/CentOS 7.5.

## Setup

### What clevis affects

* Packages: clevis, clevis-dracut, clevis-luks
* Service: clevis-luks-askpass.path

### Beginning with clevis

In order to install and configure the clevis client service, all that is needed in a puppet code manifest is `include ::clevis`.

## Usage

### Changing the names of packages installed for the clevis client service

```puppet
  class { 'clevis':
    package_name => [ 'clevis', 'clevis-dracut', 'clevis-luks', 'luksmeta', ],
  }
```

### Changing the names of packages installed for the clevis client service via hiera

```yaml
---
clevis::package_name:
  - 'clevis'
  - 'clevis-dracut'
  - 'clevis-luks'
  - 'luksmeta'
```

## Reference

Generated puppet strings documentation with examples is available from [https://millerjl1701.github.io/millerjl1701-clevis](https://millerjl1701.github.io/millerjl1701-clevis).

The puppet strings documentation is also included in the /docs folder.

### Public Classes

* clevis: Main class which installs, configures, and manages the clevis client service

### Private Classes

* clevis::config: Class which manages the configuration of the clevis client service.
* clevis::install: Class which manages the installation of the clevis client service.
* clevis::service: Class which provides for clevis service management.

## Limitations

For RedHat/CentOS systems, the clevis client service will only run on version 7.4 or higher. Attempting to use this class with lower versions will likely be problematic.

The RedHat recommended HA configuration for the clevis client service is to associating a LUKS volume or container to two or more TANG service servers. This module does not currently support associating LUKS volumes with TANG servers nor luksmeta management. This work is planned to occur; however, it has not started.

## Development

Please see the [CONTRIBUTING document](CONTRIBUTING.md) for information on how to get started developing code and submit a pull request for this module. While written in an opinionated fashion at the start, over time this can become less and less the case.

### Contributors

To see who is involved with this module, see the [GitHub list of contributors](https://github.com/millerjl1701/millerjl1701-clevis/graphs/contributors) or the [CONTRIBUTORS document](CONTRIBUTORS).
