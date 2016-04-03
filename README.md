# Shelike::Pipe

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

using ShelikePipe

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

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/shelike-pipe. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

