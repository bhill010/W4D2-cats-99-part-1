require 'time'
# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birthdate   :string           not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cat < ActiveRecord::Base
  validates :birthdate, :color, :name, :sex, presence: true

  def age
    d = Date.parse(self.birthdate)
    days = Time.now.to_date - Time.new(d.year, d.month, d.day).to_date
    better_days = days.to_s.split("/").first.to_i
    age = better_days / 365

    return age
  end


  has_many :requests,
    :dependent => :destroy,
    class_name: :CatRentalRequest

end
