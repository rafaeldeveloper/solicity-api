class Request < ApplicationRecord
  belongs_to :user
	
	def send_notification
		p "true ;p"
	end

end
