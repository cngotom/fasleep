class Survey < ActiveRecord::Base
  attr_accessible :answer, :email

 



	def method_missing(method_name, *args, &block)
	  # delegate to superclass if you're not handling that method_name
	  return super unless /^answer_(.*)(=?)/ =~ method_name
	  # after match we have attribute name in $1 captured group and '' or '=' in $2
	 
	end
end
