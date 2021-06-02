class Event < ApplicationRecord
    belongs_to :host, class_name: "User"
    has_and_belongs_to_many :attendees, class_name: "User", join_table: "attended_events_attendees"
end
