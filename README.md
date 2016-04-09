# Shelike::Pipe

[![Build Status](https://travis-ci.org/k-motoyan/shelike-pipe.svg?branch=master)](https://travis-ci.org/k-motoyan/shelike-pipe)
[![Code Climate](https://codeclimate.com/github/k-motoyan/shelike-pipe/badges/gpa.svg)](https://codeclimate.com/github/k-motoyan/shelike-pipe)
[![Test Coverage](https://codeclimate.com/github/k-motoyan/shelike-pipe/badges/coverage.svg)](https://codeclimate.com/github/k-motoyan/shelike-pipe/coverage)

Shelike::Pipe offer an operator to behave like the pipe operator of the shell.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'shelike-pipe'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install shelike-pipe

## Usage

```rb
require 'shelike/pipe'

using Shelike::Pipe

# Can let an object of the left side of a go board apply to the symbol of the right side.
('foo' | :upcase).call # => 'FOO'

# Can apply it for the Method and Proc
require 'json'

('{ "a": 1 }' | JSON.method(:parse)).call           # => { "a" => 1 }
('{ "a": 1 }' | ->(json) { JSON.parse(json) }).call # => { "a" => 1 }

# When an argument is necessary, define it with sequence. 
(%w(a b c) | :size | [:*, 3]).call # => 9

# Can return nil when carry out processing by silence method when an exception occurs on the way.
('{ a: 1 }' | JSON.method(:parse)).call    # => JSON::ParserError
('{ a: 1 }' | JSON.method(:parse)).silence # => nil
```

## Development

After checking out the repo, run `bin/setup` to install dependencies.

## Contributing

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Added some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

