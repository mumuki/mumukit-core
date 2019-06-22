[![Build Status](https://travis-ci.org/mumuki/patch_adams.svg?branch=master)](https://travis-ci.org/mumuki/patch_adams)
[![Code Climate](https://codeclimate.com/github/mumuki/patch_adams/badges/gpa.svg)](https://codeclimate.com/github/mumuki/patch_adams)
[![Test Coverage](https://codeclimate.com/github/mumuki/patch_adams/badges/coverage.svg)](https://codeclimate.com/github/mumuki/patch_adams)
[![Issue Count](https://codeclimate.com/github/mumuki/patch_adams/badges/issue_count.svg)](https://codeclimate.com/github/mumuki/patch_adams)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'patch_adams'
```

And then execute:

```bash
$ bundle install
```

Or install it yourself as:

```bash
$ gem install patch_adams
```

## Loading

### Core patches

If you want to load the whole core patches, require `patch_adams` this way:

```ruby
require 'patch_adams/core'
```

If you want to cherry-pick specific core patches instead, require `patch_adams/minimal` and only those you need:

```ruby
require `patch_adams/minimal`
require 'patch_adams/core/hash/diff'
```

### Extra patches

Some patches require additional dependencies and are meant for specific contexts, and must be loaded independently.

#### ActiveModel

> :warning: You need to add `active_model >= 4.1` to your dependencies first

If you want to require the whole `active_model` patches:

```ruby
require 'patch_adams/active_model'
```

If you want to cherry-pick specific `active_model` patches instead, require `patch_adams/minimal` and only those you need:

```ruby
require `patch_adams/minimal`
require 'patch_adams/active_model/naming/name_model_as'
```

#### Rspec

> :warning: You need to add `rspec >= 2` to your dependencies first

If you want to require the whole `rspec` patches:

```ruby
require 'patch_adams/rspec'
```

If you want to cherry-pick specific `rspec` patches instead, require `patch_adams/minimal` and only those you need:

```ruby
require `patch_adams/minimal`
require 'patch_adams/rspec/matches/json_eq'
```

#### Rack

> :warning: You need to add `rack >= 1.5` to your dependencies first

If you want to require the whole `rack` patches:

```ruby
require 'patch_adams/rack'
```

If you want to cherry-pick specific `rack` patches instead, require `patch_adams/minimal` and only those you need:

```ruby
require `patch_adams/minimal`
require 'patch_adams/rack/request/subdominated'
```

#### I18n

> :warning: You need to add `i18n ~> 0.7` to your dependencies first

If you want to require the whole `i18n` patches:

```ruby
require 'patch_adams/i18n'
```

If you want to cherry-pick specific `i18n` patches instead, require `patch_adams/minimal` and only those you need:

```ruby
require `patch_adams/minimal`
require 'patch_adams/i18n/load_translations_path'
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mumuki/patch_adams. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## Adding new patches

Patches are declared in separate files, each one containing a single patch or a group of very-related patches. This is done in order to make them easy to mantain, find and include in your project selectively.

* If you want to add a core patch that does not require any additional dependency, place it in `lib/patch_adams/core` directory.
* If you want to add an extra patch that requires an additional dependency, place it top-level in `lib/patch_adams` directory

Additionally, if your patch is specific to a class or module - most are - place you patch file within a directory named as the class or module. Otherwise - that is, the patch is polymorphic and applies to many classes - place it top-level.

For example, if you want to add `a_great_method` to `hash`, place it here:

```
└── lib
    └── patch_adams
        └── core
            └── hash
                └── a_great_method.rb
```

`If you want to add `a_great_method` that is polymorphic to `nil`, booleans, strings and regular expressions, place it here:
`
```
└── lib
    └── patch_adams
        └── core
             └── a_great_method.rb
```

And if you want to add `a_great_method` to `AClass` of `a_well_known_library` , place it here:


```
└── lib
    └── patch_adams
        └── a_well_known_library
            └── a_class
                └── a_great_method.rb
```

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

