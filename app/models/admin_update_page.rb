class AdminUpdatePage < ApplicationRecord
  def self.ransackable_attributes(auth_object = nil)
    %w[title content created_at updated_at id]
  end
end
