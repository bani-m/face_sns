lock '3.6.0'

set :default_env, {
  rbenv_root: "/usr/local/rbenv",
  path: "~/.rbenv/shims:~/.rbenv/bin:$PATH",
  #AWS_REGION: ENV['AWS_REGION'],
  #AWS_ACCESS_KEY_ID: ENV["AWS_ACCESS_KEY_ID"],
  #AWS_SECRET_ACCESS_KEY: ENV["AWS_SECRET_ACCESS_KEY"]
  AWS_REGION: "ap-northeast-1",
  AWS_ACCESS_KEY_ID: "AKIAJHVGGDGCOW3ARVDA",
  AWS_SECRET_ACCESS_KEY: "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" ,
  SECRET_KEY_BASE: "1344bb018e747f12e8109e42765b232aa0ffbadb4fe84d69914a52d27eef1575beffdbffcb314801d67d181304d1bdc9c30c315391697b3133e964b9cb81a022"
}

AWS_SECRET_ACCESS_KEY:
# デプロイするアプリケーション名
set :application, 'face_sns'

# cloneするgitのレポジトリ（xxxxxxxx：ユーザ名、yyyyyyyy：アプリケーション名）
set :repo_url, 'https://github.com/bani-m/face_sns.git'

# deployするブランチ。デフォルトはmasterなのでなくても可。
set :branch, ENV['BRANCH'] || 'master'

# deploy先のディレクトリ。
set :deploy_to, '/var/www/face_sns'

# シンボリックリンクをはるフォルダ・ファイル
set :linked_files, %w{.env config/secrets.yml}
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets public/uploads}

# 保持するバージョンの個数(※後述)
set :keep_releases, 5

# Rubyのバージョン
set :rbenv_ruby, '2.3.0'
set :rbenv_type, :system

#出力するログのレベル。
set :log_level, :debug

namespace :deploy do
  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  desc 'Create database'
  task :db_create do
    on roles(:db) do |host|
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:create'
        end
      end
    end
  end

  desc 'Run seed'
  task :seed do
    on roles(:app) do
      with rails_env: fetch(:rails_env) do
        within current_path do
          execute :bundle, :exec, :rake, 'db:seed'
        end
      end
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end
end
