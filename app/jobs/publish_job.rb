# frozen_string_literal: true

class PublishJob < ApplicationJob
  queue_as :ecsf_publish

  def perform(queue_name, sender_id: nil, **payload)
    Hutch.connect
    Hutch.publish(queue_name, sender_id: sender_id, **payload)
  end
end
