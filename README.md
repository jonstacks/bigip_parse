# BigipParse [![Build Status](https://travis-ci.org/jonstacks13/bigip_parse.svg?branch=master)](https://travis-ci.org/jonstacks13/bigip_parse)

Simple gem to parse BIG IP configs

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bigip_parse'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bigip_parse

## Usage

```ruby

config = BigIParse::Config.new(File.read('bigip.conf'))

# Virtual Server Definitions
vs_defs = config.subsections.select do |s|
  s.header.starts_with?('ltm virtual ')
end

# Print Virtual Server Names, one per line
vs_defs.each { |vs_def| puts vs_def.header.split.last }

```

## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake false` to run the tests. You can also run `bin/console`
for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and
then run `bundle exec rake release`, which will create a git tag for the
version, push git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/jonstacks13/bigip_parse.
