job_type :backup, 'source /backup/.env && cd /backup && backup perform -t :task'

every :monday, at: '6am' do
  backup :srv1
end
