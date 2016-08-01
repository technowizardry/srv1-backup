job_type :backup, 'source /backup/.env && cd /backup && backup perform -t :task'

every :monday, at: '10am' do
  backup :srv1
end
