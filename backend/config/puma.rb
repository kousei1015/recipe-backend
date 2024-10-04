# Puma のログ出力先を設定
# stdout_redirect 'log/puma.stdout.log', 'log/puma.stderr.log', true

# その他の Puma 設定
threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }
threads threads_count, threads_count

port ENV.fetch('PORT') { 3000 }

environment ENV.fetch('RAILS_ENV') { 'development' }

# プロセス数
workers ENV.fetch('WEB_CONCURRENCY') { 2 }

preload_app!

on_worker_boot do
  # Worker が起動する際の処理
end
