require 'thin'

puts "started, pid = #{Process.pid}"

def start_server
  EM.epoll; EM.kqueue

  EM.run do
    $0 = "ruby config.ru"
    puts "server started, pid = #{Process.pid}"

    require "./server"
	Thin::Server.start Server, '0.0.0.0', 8000

    ['TERM', 'INT', 'HUP'].each { |s| trap(s) {exit!} }
  end
end

while true
  child_pid = fork do
    start_server
  end

  $0 = "ruby config.ru"
  ['TERM', 'INT', 'HUP'].each do |s| 
    trap(s) do 
      Process.kill('TERM', child_pid) if child_pid
      exit!
    end
  end

  pid = Process.wait
  sleep 1
  puts "server [#{pid}] died, exitcode = #{$?.exitstatus}, try to restart it."
end
