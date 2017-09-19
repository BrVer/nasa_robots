# NasaRobots

[![Build Status](https://travis-ci.org/BrVer/nasa_robots.svg)](https://travis-ci.org/BrVer/nasa_robots)

Simple ruby solution of 'NASA rowers' task

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'nasa_robots', git: 'https://github.com/BrVer/nasa_robots.git'
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