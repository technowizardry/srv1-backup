# encoding: utf-8

##
# Backup Generated: MySQL Dump
# Once configured, you can run the backup with the following command:
#
# $ backup perform -t mysql [-c <path_to_configuration_file>]
#
# For more information about Backup's components, see the documentation at:
# http://backup.github.io/backup
#
Model.new(:srv1, 'Exports the entire server') do
  archive :source_control do |archive|
    archive.add '/git'
  end
  database MySQL do |db|
    db.name = :all
    db.additional_options = ['--quick', '--single-transaction']
    db.username = ENV['SQL_USER']
    db.password = ENV['SQL_PASS']
    db.host = ENV['SQL_HOST']
    db.port = 3306
  end
  compress_with Bzip2

  encrypt_with OpenSSL do |encryption|
    encryption.password = ENV['ARCHIVE_PASS']
  end

  run_date = Time.now.strftime '%Y-%m-%d'
  store_with RSync, run_date.to_sym do |rsync|
    rsync.keep = 5
    rsync.mode = :ssh
    rsync.additional_ssh_options = '-i /root/.ssh/id_rsa'
    rsync.host = ENV['STORAGE_HOST']
    rsync.port = ENV['STORAGE_PORT'].to_i
    rsync.ssh_user = ENV['STORAGE_USER']
    rsync.path = "/media/sf_srv1.technowizardry.net/#{run_date}"
  end
end
