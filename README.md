puppet-lint-file_source_rights-check
====================================

[![Build Status](https://img.shields.io/travis/camptocamp/puppet-lint-file_source_rights-check.svg)](https://travis-ci.org/camptocamp/puppet-lint-file_source_rights-check)
[![Gem Version](https://img.shields.io/gem/v/puppet-lint-file_source_rights-check.svg)](https://rubygems.org/gems/puppet-lint-file_source_rights-check)
[![Gem Downloads](https://img.shields.io/gem/dt/puppet-lint-file_source_rights-check.svg)](https://rubygems.org/gems/puppet-lint-file_source_rights-check)
[![Coverage Status](https://img.shields.io/coveralls/camptocamp/puppet-lint-file_source_rights-check.svg)](https://coveralls.io/r/camptocamp/puppet-lint-file_source_rights-check?branch=master)
[![Gemnasium](https://img.shields.io/gemnasium/camptocamp/puppet-lint-file_source_rights-check.svg)](https://gemnasium.com/camptocamp/puppet-lint-file_source_rights-check)

A puppet-lint plugin to check file rights when providing a source. 

## Installing

### From the command line

```shell
$ gem install puppet-lint-file_source_rights-check
```

### In a Gemfile

```ruby
gem 'puppet-lint-file_source_rights-check', :require => false
```

## Checks

### Source without rights

When using the `source` parameter for a `file` resource, the Puppetmaster
will use the rights of the distant file on the fileserver as defaults.

This might lead to unexpected results, so the file's owner, group and mode
should be specified when using `source`.

#### What you have done

```puppet
file { '/tmp/foo':
  ensure => file,
  source => 'puppet:///modules/bar/foo',
}
```

#### What you should have done

```puppet
file { '/tmp/foo':
  ensure => file,
  owner  => 'root',
  group  => '0',
  mode   => '0644',
  source => 'puppet:///modules/bar/foo',
}
```

#### Disabling the check

To disable this check, you can add `--no-source_without_rights-check` to your puppet-lint command line.

```shell
$ puppet-lint --no-source_without_rights-check path/to/file.pp
```

Alternatively, if you’re calling puppet-lint via the Rake task, you should insert the following line to your `Rakefile`.

```ruby
PuppetLint.configuration.send('disable_source_without_rights')
```
