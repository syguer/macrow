# Macrow
[![TravisCI Build Status](https://travis-ci.org/syguer/macrow.svg?branch=master)](http://travis-ci.org/syguer/macrow)
[![Coverage Status](https://coveralls.io/repos/github/syguer/macrow/badge.svg?branch=master)](https://coveralls.io/github/syguer/macrow?branch=master)
[![Code Climate](https://codeclimate.com/github/syguer/macrow.svg)](https://codeclimate.com/github/syguer/macrow)

This gem provide DSL for define rules of text replacing. It makes the code more readable and helps avoinding fat model.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'macrow'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install macrow

## Usage

### Basic Usage
```ruby
class HogeMacro < Macrow
  rules do
    # this rule means '${something}' -> 'trouble'
    rule 'something' do
      'trouble'
    end

    # you can access an object
    rule 'length' do |object|
      object.length
    end
  end
end

macro = HogeMacro.new

macro.apply_all_rules("${something} happened")
# => "trouble happened"

macro.apply("${something} happened") # you can use short alias
# => "trouble happened"

array = [1, 2]
macro.apply("object length is ${length}", array) # you can pass an object
# => "object length is 2"

```

### Custom Usage
you can change syntax like ...

```ruby
class HogeMacro < Macrow
  macro_prefix '{{'
  macro_suffix '}}'

  rules do
    # this rule means '{{something}}' -> 'trouble'
    rule 'something' do
      'trouble'
    end
  end
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/macrow.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

