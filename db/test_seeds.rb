Job.destroy_all

#  create activated jobs
5.times do
  job = Job.create!(
    title: Faker::Job.title,
    description: Faker::Lorem.unique.sentence
  )

  job.events.create(type: "Job::Event::Activated")
end

# create deactivated jobs
5.times do
  job = Job.create!(
    title: Faker::Job.title,
    description: Faker::Lorem.unique.sentence
  )
  rand(0..1).times do
    job.events.create(type: "Job::Event::Deactivated")
  end
end

Job.where(last_event_type: "Job::Event::Activated").find_each do |job|
  5.times do
    job.applications.create!(
      candidate_name: Faker::Name.name
    )
  end
end

Job.where(jobs: {last_event_type: ['Job::Event::Deactivated', nil]}).find_each do |job|
  5.times do
    job.applications.create!(
      candidate_name: Faker::Name.name
    )
  end
end


job = Job.create!(
      title: "Job controller tester",
      description: Faker::Lorem.unique.sentence
    )

job.events.create!(type: "Job::Event::Activated")
app_one = job.applications.create!(candidate_name: "Controller Tester")
app_two = job.applications.create!(candidate_name: Faker::Name.name)
app_three = job.applications.create!(candidate_name: Faker::Name.name)

app_one.events.create!(
  type: "Application::Event::Interview",
  interview_date: Date.today,
  )
app_one.events.create!(
type: "Application::Event::Note",
content: Faker::Lorem.unique.sentence,
)

app_two.events.create!(type: "Application::Event::Rejected")
app_three.events.create!(type: "Application::Event::Hired")
