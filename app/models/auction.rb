class Auction < ActiveRecord::Base
  has_many :bids, dependent: :destroy
  belongs_to :user

  include AASM

  aasm whiny_transitions: false do
    state :draft, initial: true
    state :published
    state :reserve_met
    state :won
    state :canceled
    state :reserve_not_met

    event :submit do
      transitions from: :draft, to: :published
    end

    event :meet_reserve do
      transitions from: :published, to: :reserve_met
    end

    event :win do
      transitions from: :reserve_met, to: :won
    end

    event :cancel do
      transitions from: [:published, :reserve_met, :reserve_not_met], to: :canceled
    end

    event :fail do
      transitions from: :published, to: :reserve_not_met
    end
  end

end
