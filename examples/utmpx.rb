require "linux/utmpx"
require "optparse"

options = {}
parser = OptionParser.new
parser.on("-u", "--utmp", "Dump /var/run/utmp") do |v|
  options[:utmp] = v
end
parser.on("-w", "--wtmp", "Dump /var/log/wtmp") do |v|
  options[:wtmp] = v
end
parser.parse!(ARGV)

path = "/var/run/utmp"
if options[:utmp]
  path = "/var/run/utmp"
end
if options[:wtmp]
  path = "/var/log/wtmp"
end

unless options[:utmp] or options[:wtmp]
  puts parser.help
  exit 1
end

File.open(path, "rb") do |io|
  utmpx = Linux::Utmpx::UtmpxParser.new
  printf("%20s %10s %s@%s\n", "TYPE", "PID", "USER", "HOST")
  while !io.eof?
    entry = utmpx.read(io)
    printf("%20s %10d %s@%s\n", entry.type, entry.pid, entry.user, entry.host)
  end
end
