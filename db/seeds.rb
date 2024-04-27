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
