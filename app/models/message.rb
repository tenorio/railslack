class Message < ApplicationRecord
  belongs_to :messagable, polymorphic: true
  belongs_to :user

  after_create_commit { MessageBroadcastJob.perform_later self }

  validates_presence_of :body, :user
end
