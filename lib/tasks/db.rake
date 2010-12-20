namespace :db do

  def backup_command(env)
    require 'heroku'
    require 'heroku/command'

    Heroku::Command::Pgbackups.new(['--app', "secretgoals-#{env}"])
  end

  desc "capture the production database"
  task :prod_capture do
    command = backup_command(:production)
    pgbackup_client = command.pgbackup_client

    existing = pgbackup_client.get_transfers
    if existing.length >= 2
      puts "found 2 dumps, destroying the oldest"
      name = command.send(:backup_name, existing.first["to_url"])
      puts "Destroying backup #{name}"
      pgbackup_client.delete_backup(name)
    end

    command.capture
  end

  desc "capture production database and load locally"
  task :prod_pull => [:prod_capture] do
    new_dump_url = backup_command(:production).pgbackup_client.get_latest_backup["public_url"]

    puts "downloading #{new_dump_url}"

    %x{wget "#{new_dump_url}" -O db/pg.dump}

    puts "recreating db"
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke

    puts "restoring data"
    %x{pg_restore -d secretgoals_dev db/pg.dump}
  end

  desc "staging clone"
  task :staging_clone => [:prod_capture] do
    from_url = backup_command(:production).pgbackup_client.get_latest_backup["public_url"]
    from_name = "EXTERNAL_BACKUP (PRODUCTION)"

    staging_command = backup_command(:staging)
    to_url = staging_command.resolve_db_id(nil, :default => "DATABASE_URL")[1]
    to_name = "SHARED_DATABASE_URL (STAGING)"


    puts "CLONING FROM #{from_url}\nTO #{to_url}"
    restore = staging_command.pgbackup_client.create_transfer(from_url, from_name, to_url, to_name)
    puts "MORE"
    restore = staging_command.send(:poll_transfer!, restore)
    abort(" !    An error occurred and your restore did not finish.") if restore["error_at"]

  end
end
