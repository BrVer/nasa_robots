# NasaRobots

Simple ruby solution of 'NASA rowers' task

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nasa_robots'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install nasa_robots

## Usage
```ruby
input = <<-INPUT
  5 5
  1 2 N
  LMLMLMLMM
  3 3 E
  MMRMMRMRRM
INPUT

NasaRobots::Mission.new(input).perform # will return ['1 3 N', '5 1 E'] 
```
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).