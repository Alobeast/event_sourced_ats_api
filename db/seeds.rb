puts "Destroying all records..."
Job.destroy_all

puts "Creating jobs and applications..."
20.times do
  job = Job.create!(
    title: Faker::Job.title,
    description: Faker::Lorem.unique.sentence
  )

  rand(0..2).times do
    event_type = [
      "Job::Event::Activated",
      "Job::Event::Deactivated"
    ].sample

    job.events.create!(
      type: event_type
    )
  end

  5.times do
    job.applications.create!(
      candidate_name: Faker::Name.name
    )
  end
end

puts "Adding events to applications..."
Application.find_each do |application|
  rand(0..3).times do
    event_type = [
      "Application::Event::Interview",
      "Application::Event::Note"
    ].sample

    application.events.create!(
      type: event_type,
      interview_date: (Date.today if event_type == "Application::Event::Interview"),
      hire_date: (Date.today if event_type == "Application::Event::Hired"),
      content: (Faker::Lorem.unique.sentence if event_type == "Application::Event::Note")
    )
  end

  last_event_type = [
      "Application::Event::Hired",
      "Application::Event::Rejected",
      "Application::Event::Note"
    ].sample

  if application.events.any?
    application.events.create!(
      type: last_event_type,
      hire_date: (Date.today if last_event_type == "Application::Event::Hired"),
      content: (Faker::Lorem.unique.sentence if last_event_type == "Application::Event::Note")
    )
  end
end
