worker_processes ENV.fetch('WEB_CONCURRENCY') { 2 }

listen ENV.fetch('PORT') { 3000 }


timeout 30

preload_app true
GC.respond_to?(:copy_on_write_friendly=) && GC.copy_on_write_friendly = true

before_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |_server, _worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end