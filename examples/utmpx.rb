require "linux/utmpx"
require "optparse"
require "time"

options = {}
parser = OptionParser.new
parser.on("-u", "--utmp", "Dump /var/run/utmp") do |v|
  options[:utmp] = v
end
parser.on("-w", "--wtmp", "Dump /var/log/wtmp") do |v|
  options[:wtmp] = v
end
parser.on("-d", "--delayed", "Dump with delayed IO") do |v|
  options[:delayed] = v
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
  printf("%25s %14s %7s %10s %20s %10s %10s\n", "TIME", "TYPE", "PID", "USER", "HOST", "ID", "LINE")
  if options[:delayed]
    obj = BinData::DelayedIO.new(type: Linux::Utmpx::UtmpxParser, read_abs_offset: 0)
    while !io.eof?
      obj.read(io.read(384)) do
        obj.read_now!
        printf("%25s %14s %7d %10s %20s %10s %10s\n",
               obj.time, obj.type, obj.pid, obj.user, obj.host, obj.id, obj.line)
      end
    end
  else
    while !io.eof?
      entry = utmpx.read(io)
      printf("%25s %14s %7d %10s %20s %10s %10s\n",
             entry.time, entry.type, entry.pid, entry.user, entry.host, entry.id, entry.line)
    end
  end
end
