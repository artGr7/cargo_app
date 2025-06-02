class Order < ApplicationRecord
  include AASM

  belongs_to :user

  aasm column: 'status' do
    state :new, initial: true
    state :processing
    state :done
    state :rejected

    event :start_processing do
      transitions from: :new, to: :processing
    end

    event :complete do
      transitions from: :processing, to: :done
    end

    event :reject do
      transitions from: [:new, :processing], to: :rejected
    end
  end

  validates :first_name, :last_name, :phone, :email, :from, :to, presence: true

  after_commit :send_status_change_email, on: :update
  
  def self.ransackable_associations(auth_object = nil)
    ["user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "distance", "email", "first_name", "from", "height", "id", "id_value", "last_name", "length", "middle_name", "phone", "price", "status", "to", "updated_at", "user_id", "weight", "width"]
  end
  
  def send_status_change_email
    if saved_change_to_status?
      SendStatusChangedEmailJob.perform_later(self.id)
    end
  end

end