class Invitation < ApplicationRecord
    belongs_to :sender, class_name: "User"
    belongs_to :invitee, class_name: "User"
    belongs_to :event

    VALID_STATUSES = ['pending', 'accepted', 'rejected']

    validates :status, inclusion: { in: VALID_STATUSES }
end
