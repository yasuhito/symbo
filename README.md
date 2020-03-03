# Symbo

A simple symbolic computation library in Ruby

## What is symbolic computation

Numerical calculations using computers are approximate. For example, if you calculate the square root of 2 on a computer, the result is an approximation with numbers omitted, despite √2 being an infinitely irrational number.

```
irb> Math.sqrt(2)
=> 1.4142135623730951
```

What happens if we further calculate (1/√2)^2? If we calculate it by hand, it should be 0.5 because it is equal to 1/2. However, in practice, a different value is returned.

```
irb> (1 / Math.sqrt(2))**2
=> 0.4999999999999999
```

If you use symbolic computation, you can do error-free calculations. Symbolic operations transform mathematical formulas in the same way as human calculations and find the answer. Symbo is a symbolic computation library for Ruby that can calculate the above expression correctly.

Open the Symbo console with the following command and calculate (1/√2)^2.

```
% ./bin/console
irb> ((1/√(2))**2).simplify.to_s
=> "1/2"
```

`#simplify` is a method that transforms a mathematical expression as simple as possible. Using this method, you can transform not only numerical calculations but also expressions with variables into simple forms.

```
# ((x·y)^(1/2) * z^2)^2 # => x·y·z^4
irb> (((:x * :y)**(1/2) * :z**2)**2).simplify.to_s
=> "x*y*z^4"
```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'symbo'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install symbo

## Usage

Here is a simple sample code that uses symbolic computation. Load the required libraries with `require 'symbo'`. `include Symbo` allows operations and constants such as √ and π to be used. `using Symbo` replaces subsequent operations with symbolic operations by Symbo.

```ruby
require 'symbo'

class MyClass
  include Symbo
  using Symbo

  # Your code goes here
  # ...

end
```

### Supported Operations and Expressions

* `+`, `-`, `*`, `/`, `**`
* Integers, fractions, complex numbers, variables, e (the base of the natural logarithm) and π
* Trigonometric functions (cos(x) and sin(x)) and anonymous functions (e.g. f(x), g(x))
* Matrices and vectors
* Qubit and bra-ket vectors

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/yasuhito/symbo.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
