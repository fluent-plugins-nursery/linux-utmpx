# Linux::Utmpx::UtmpxParser

Helper library to parse /var/log/wtmp, /var/run/utmp.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'linux-utmpx'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install linux-utmpx

## Usage

Read all records in `/var/log/wtmp`.

```ruby
io = File.open("/var/log/wtmp")
parser = Linux::Utmpx::UtmpxParser.new
while !io.eof? do
  puts parser.read(io)
end
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test-unit` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fluent-lugins-nursery/linux-utmpx.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
