[![Build Status](https://travis-ci.org/mumuki/patch_adams.svg?branch=master)](https://travis-ci.org/mumuki/patch_adams)
[![Code Climate](https://codeclimate.com/github/mumuki/patch_adams/badges/gpa.svg)](https://codeclimate.com/github/mumuki/patch_adams)
[![Test Coverage](https://codeclimate.com/github/mumuki/patch_adams/badges/coverage.svg)](https://codeclimate.com/github/mumuki/patch_adams)
[![Issue Count](https://codeclimate.com/github/mumuki/patch_adams/badges/issue_count.svg)](https://codeclimate.com/github/mumuki/patch_adams)

# :clown_face: `patch_adams`

> :monkey: Ruby monkey patches to increase your code's health and your own happines

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

## Available patches

### Core

#### `as_module_name`

> :cherries: Cherry-pick with `require 'patch_adams/core/as_module_name`

TODO

#### `as_variable_name`

> :cherries: Cherry-pick with `require 'patch_adams/core/as_variable_name`

TODO


#### `attempt`

> :cherries: Cherry-pick with `require 'patch_adams/core/attempt`

`attempt` generalizes `activesupport`'s `try` method by accepting a default value and dealing with block failures.

More specifically, `attempt` tries to pass the receptor to a given block, returning an optional default value if either:

* the receptor is `nil`
* the block returns `nil`
* the block fails

```ruby
# LICENSE_FILE is nil; block is not executed
> ENV['LICENSE_FILE'].attempt { |it| File.read it }
=> nil

# Again, block is not executed, but a default value is provided
> ENV['LICENSE_FILE'].attempt("No license") { |it| File.read it }
=> "No license"

# LICENSE_FILE points to an existing license file; block is executed and succeeds
> ENV['LICENSE_FILE'] = 'LICENSE.txt'
> ENV['LICENSE_FILE'].attempt { |it| File.read it }
=> "The MIT License (MIT) ...\n"

# LICENSE_FILE points to a non existing license file; block is executed and fails
> ENV['LICENSE_FILE'] = 'foo'
> ENV['LICENSE_FILE'].attempt { |it| File.read it }
=> nil

# Again, block is executed and fails, but this time a default value is provided
> ENV['LICENSE_FILE'].attempt("No license") { |it| File.read it }
=> "No license"
```

#### `captures`

> :cherries: Cherry-pick with `require 'patch_adams/core/captures`

TODO

#### `defaulting`

> :cherries: Cherry-pick with `require 'patch_adams/core/defaulting`

`defaulting` just implements the idiom `maybe_nil || default` in a more-fluid message fashion, easier to chain in some contexts:

```ruby
> 4.defaulting(5)
=> 4
> nil.defaulting(5)
=> 5
```

#### `like`

> :cherries: Cherry-pick with `require 'patch_adams/core/like`

Don't you remember if a given object is a symbol, class or string? Are you dealing with a not-very-consistent-API? `like?` allows to perform loose comparisons between symbolic-like objects:

```ruby
> 'hello'.like? 'hello'
=> true
> 'hello'.like? :hello
=> true

> 5.like? '5'
=> true
> '5'.like? 5
=> true

> 'false'.like? false
=> true
> false.like? :false
=> true

> OpenStruct.like? :OpenStruct
=> true
> OpenStruct.like? 'OpenStruct'
=> true
> OpenStruct.like? :open_struct
=> true

> String.like? 'Symbol'
=> false
> 'false'.like? :hello
=> false

> String.like? 'string'
=> true
> String.like? 'symbol'
=> false
> Kernel.like? :kernel
=> true
```

#### `status?`

> :cherries: Cherry-pick with `require 'patch_adams/core/status`

`PatchAdams.define_status` allows you to declare global status-like matchers for strings and symbols:

```ruby
# Somewhere in your program startup-code
PatchAdams.define_status :passed, :failed?

# Then...
> PatchAdams::STATUSES
=> [:passed, :failed]

> :passed.passed?
=> true

> :foo.passed?
=> false

> nil.failed?
=> false

> 'failed'.failed?
=> true
```

#### `to_struct`

> :cherries: Cherry-pick with `require 'patch_adams/core/to_struct`

`struct` and `to_struct` are easy an convinient way of converting hashes into `OpenStruct`s:

```ruby
> {name: 'Mary', surname: 'Doe'}.to_struct
=> #<OpenStruct name="Mary", surname="Doe">

> struct name: 'Jon', surname: 'Doe'
=> #<OpenStruct name="Jon", surname="Doe">
```

#### `Array#assign_numbers!`

> :cherries: Cherry-pick with `require 'patch_adams/array/assign_numbers`

`Array#assign_numbers!` assigns a number to each of the elements in the array, starting by `1`. By default the elements need to understand a `number=` message:

```ruby
class Team
  attr_accessor :number
end

> 5.times.map { Team.new }.assign_numbers!
=> [#<Team:0x0000562b389264b8 @number=1>, #<Team:0x0000562b38926490 @number=2>, #<Team:0x0000562b38926468 @number=3>, #<Team:0x0000562b38926440 @number=4>, #<Team:0x0000562b38926418 @number=5>]
```

You can change the initial number:

```ruby
> 5.times.map { Team.new }.assign_numbers! start_at: 10
=> [#<Team:0x000055f2cd60b880 @number=10>, #<Team:0x000055f2cd60b858 @number=11>, #<Team:0x000055f2cd60b830 @number=12>, #<Team:0x000055f2cd60b808 @number=13>, #<Team:0x000055f2cd60b678 @number=14>]
```

And you can send an alternate selector:

```ruby
class Player
  attr_accessor :position
end

> 3.times.map { Player.new }.assign_numbers! selector: :position
=> [#<Player:0x000055f2cd978770 @position=1>, #<Player:0x000055f2cd978748 @position=2>, #<Player:0x000055f2cd978720 @position=3>]
```

#### `Array#to_csv`

> :cherries: Cherry-pick with `require 'patch_adams/array/to_csv`

`Array#to_csv` converts an array of hashes into a CSV string.

```ruby
puts [{id: 1, name: 'Jon', surname: 'Doe'}, {id: 2, name: 'Mary', surname: 'Doe'}].to_csv
1,Jon,Doe
2,Mary,Doe
```

#### `Array#to_h`

> :cherries: Cherry-pick with `require 'patch_adams/array/to_h`

`Array#to_h` converts an array of pairs into a hash:

```ruby
[].to_h
=> {}

[[:force, true], [:recursive, true], [:max_level, 4]].to_h
=> {:force=>true, :recursive=>true, :max_level=>4}
```

#### `Hash#fix_missing`

> :cherries: Cherry-pick with `require 'patch_adams/hash/fix_missing`

`Hash#fix_missing` is like `merge` but withs arguments flipped. This means that, unlike `merge`, receptor's object entries take precedence over the given's one.

```ruby
> {recursive: true}.fix_missing(recursive: false, force: false)
=> {:recursive=>true, :force=>false}
```

#### `Hash#diff`

> :cherries: Cherry-pick with `require 'patch_adams/core/hash/diff`

`diff` and `deep_diff` provide a way of comparing a hash, key by key. As name suggests, `diff` compute a shallow diff only based on receptor's key, while `deep_diff` computes
this diff recursively for entries which contain arrays or hashes.

```ruby
> {}.diff({})
=> {:deletions=>{}, :additions=>{}}
> {foo: 1}.diff(bar: 2)
=> {:deletions=>{:foo=>1}, :additions=>{:bar=>2}}
> {foo: 1, bar: 2, baz: 7}.diff(bar: 2, foo: 1, bax: 3, foobar: 5)
=> {:deletions=>{:baz=>7}, :additions=>{:bax=>3, :foobar=>5}}

# deep_diff works also with nested hashes
> {foo: {baz: 2}}.deep_diff({foo: {baz: 3}})
=> {:deletions=>{:foo=>{:baz=>2}}, :additions=>{:foo=>{:baz=>3}}}
> {foo: {bax: {kux: 4, bar: 9}, baz: 10}}.deep_diff({foo: {bax: {kux: 3, bar: 9}, baz: 10}})
=> {:deletions=>{:foo=>{:bax=>{:kux=>4}}}, :additions=>{:foo=>{:bax=>{:kux=>3}}}}

# deep_diff works with nested arrays too
> {foo: [1, 2, 5]}.deep_diff({foo: [9, 10, 5, 6]})
=> {:deletions=>{:foo=>[1, 2]}, :additions=>{:foo=>[9, 10, 6]}}
> {foo: [{bar: 4, bax: 9}, 5]}.deep_diff({foo: [{bar: 5, bax: 9}, 5]})
=> {:deletions=>{:foo=>[{:bar=>4}]}, :additions=>{:foo=>[{:bar=>5}]}}
```

#### `Hash#dig`

> :cherries: Cherry-pick with `require 'patch_adams/core/hash/dig`

TODO

#### `Hash#indifference`

> :cherries: Cherry-pick with `require 'patch_adams/core/hash/indifference`

indifferent_delete

TODO

#### `Hash#replace_key`

> :cherries: Cherry-pick with `require 'patch_adams/core/hash/replace_key`

TODO

#### `JSON#pretty_parse`

> :cherries: Cherry-pick with `require 'patch_adams/core/json/pretty_parse`

TODO

#### `Module#required`

> :cherries: Cherry-pick with `require 'patch_adams/core/module/required`

TODO

#### `Module#revamp`

> :cherries: Cherry-pick with `require 'patch_adams/core/module/revamp`

TODO

#### `Module#rewrite`

> :cherries: Cherry-pick with `require 'patch_adams/core/module/rewrite`


#### `Object#ensure_present`

> :cherries: Cherry-pick with `require 'patch_adams/core/object/ensure_present`

TODO

#### `Object#to_stringified_h`

> :cherries: Cherry-pick with `require 'patch_adams/core/object/to_stringified_h`

TODO

#### `Regexp#matches`

> :cherries: Cherry-pick with `require 'patch_adams/core/regexp/matches`

TODO

#### `Yaml#load_interpolated`

> :cherries: Cherry-pick with `require 'patch_adams/core/yaml/load_interpolated`

TODO

### ActiveModel

TODO

### I18n

TODO

### Rack

TODO

### RSpec

TODO

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

