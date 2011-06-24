module TweetLink
	module ClassMethods

	end

	module InstanceMethods
		def link
			"http://twitter.com/#!/" + self.screen_name
		end
	end

	def self.included(receiver)
		receiver.extend ClassMethods
		receiver.send :include, InstanceMethods
	end
end