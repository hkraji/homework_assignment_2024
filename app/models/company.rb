class Company < ApplicationRecord
  has_many   :deals
  belongs_to :industry
end
