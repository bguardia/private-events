class CreateAttendedEventsAttendeesTable < ActiveRecord::Migration[6.1]
  def change
    create_table :attended_events_attendees, id: false do |t|
      t.bigint :user_id
      t.bigint :event_id
    end

    add_index :attended_events_attendees, :user_id
    add_index :attended_events_attendees, :event_id
  end
end
