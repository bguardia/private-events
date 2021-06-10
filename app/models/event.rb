class Event < ApplicationRecord
    belongs_to :host, class_name: "User"
    has_many :invitations, dependent: :destroy
    has_many :invitees, through: :invitations
    has_and_belongs_to_many :attendees, class_name: "User", join_table: "attended_events_attendees"

    scope :upcoming, ->{ where("events.start_date >= ?", DateTime.current) }
    scope :ongoing, ->{ where("events.start_date < :current_datetime AND events.end_date > :current_datetime", current_datetime: DateTime.current)}
    scope :past, ->{ where("events.end_date < ?", DateTime.current) }

    VALID_OPENNESS_SETTINGS = ['invite_only', 'public']

    validates :openness, inclusion: {in: VALID_OPENNESS_SETTINGS }

    def pretty_start_date
        self.start_date.strftime('%B %-d, %Y')
    end

    def start_time
        self.start_date.localtime.strftime('%k:%M')
    end

    def upcoming?
        start_date >= DateTime.current
    end

    def past?
        end_date < DateTime.current
    end

    def ongoing?
        start_date < DateTime.current && end_date > DateTime.current
    end
end
