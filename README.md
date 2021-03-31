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
require "linux/utmpx"

io = File.open("/var/log/wtmp")
parser = Linux::Utmpx::UtmpxParser.new
while !io.eof? do
  puts parser.read(io)
end
```

By the above example, it prints the following records.

```
{:ut_type=>7, :pad_type=>0, :ut_pid=>3018, :ut_line=>"tty7", :ut_id=>":0", :ut_user=>"kenhys", :ut_host=>":0", :ut_exit=>{:e_termination=>0, :e_exit=>0}, :ut_session=>0, :ut_tv=>{:tv_sec=>1614902638, :tv_usec=>26903}, :ut_addr_v6=>[0, 0, 0, 0], :reserved=>"..."}
```

## Supported fields

`Linux::Utmpx::UtmpxParser` supports to read the following fields.

| parameter | type            | description                 |
|-----------|-----------------|-----------------------------|
| ut_type   | integer         | Type of login               |
| ut_pid    | integer         | Process ID of login process |
| ut_line   | string          | Device name                 |
| ut_id     | string          | Inittab ID                  |
| ut_user   | string          | Username                    |
| ut_host   | string          | Hostname for remote login   |
| ut_tv     | BinData::Record | Time entry                  |

For making access easy, these accessor methods are provided.

| parameter | type    | description                                                                                                                                                                   |
|-----------|---------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| type      | integer | Type of login. It returns `:EMPTY`, `:RUN_LVL`, `:BOOT_TIME`, `:NEW_TIME`, `:OLD_TIME`, `:INIT_PROCESS`, `:LOGIN_PROCESS`, `:USER_PROCESS`, `:DEAD_PROCESS` or `:ACCOUNTING`. |
| pid       | integer | Process ID of login process                                                                                                                                                   |
| line      | string  | Device name                                                                                                                                                                   |
| id        | string  | Inittab ID                                                                                                                                                                    |
| user      | string  | Username                                                                                                                                                                      |
| host      | string  | Hostname for remote login                                                                                                                                                     |
| time      | Time    | Time entry.it returns the value of `Time`.                                                                                                                                    |
## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test-unit` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/fluent-lugins-nursery/linux-utmpx.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
