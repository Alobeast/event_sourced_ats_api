class Application < ApplicationRecord
  belongs_to :job
  has_many :events, class_name: "Application::Event", dependent: :destroy
end
