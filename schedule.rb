job_type :backup, 'source /backup/.env && cd /Backup && backup perform -t :task'

every :sunday, at: '12pm' do
  backup :srv1
end
