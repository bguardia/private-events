class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_and_belongs_to_many :attended_events, class_name: "Event", join_table: "attended_events_attendees"
  has_many :hosted_events, class_name: "Event", foreign_key: "host_id", inverse_of: :host, dependent: :destroy

end
