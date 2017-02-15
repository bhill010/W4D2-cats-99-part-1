# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :string           not null
#  end_date   :string           not null
#  status     :string           default("PENDING"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ActiveRecord::Base
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: { in: %w(APPROVED PENDING DENIED), message: "%{value} is not valid status" }
  validate :overlapping_approved_requests

  def overlapping_requests
    dates = get_dates

    dates.each_with_index do |date, i|
      dates.each_with_index do |existing_date, j|
        next if i == j
        if date.overlaps?(existing_date)
          return true
          # return self.warnings[:note] << ":has already been requested. You may not be approved."
        end
      end
    end
  end


  def overlapping_approved_requests
    dates = get_approved_dates

    dates.each_with_index do |date, i|
      if date.overlaps?(self.start_date.to_date..self.end_date.to_date)
        self.errors[:date] << "has been reserved already"
      end
    end
    true
  end

  def get_approved_dates
    reservations = []
    dates = Cat
      .select(:start_date, :end_date)
      .joins(:requests)
      .where("cats.id = cat_id AND status == 'APPROVED'")

    dates.each do |date|
      a = date[:start_date]
      b = date[:end_date]

      reservations << (a.to_date..b.to_date)
    end
    reservations
  end

  def get_dates
    reservations = []
    dates = Cat
      .select(:start_date, :end_date)
      .joins(:requests)
      .where("cats.id = cat_id")

    dates.each do |date|
      a = date[:start_date]
      b = date[:end_date]

      reservations << (a.to_date..b.to_date)
    end
    reservations
  end


  belongs_to :cat
end
