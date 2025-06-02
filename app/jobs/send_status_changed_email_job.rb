class SendStatusChangedEmailJob < ApplicationJob
  queue_as :default

  def perform(order_id)
    order = Order.find(order_id)
    OrderMailer.status_changed(order).deliver_now
  end
end
