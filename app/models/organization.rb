class Organization < ActiveRecord::Base
	has_many :causes
	
	EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :contact_email, uniqueness: true, :format => EMAIL_REGEX, if: 'contact_email.present?'
	validates :organization_name, :presence => true, uniqueness: true
	validates :nonprofit_id, :presence => true, uniqueness: true
	validates :password, :presence => true, length: { minimum: 6 }
	validates :username, :presence => true, uniqueness: true 
	attr_accessor :password

	before_save :encrypt_password, :ensure_authentication_token
	after_save :clear_password

	'''JSON RESPONSE '''
    def as_json(options={})
		options[:except] = [:encrypted_password, :salt, :encrypted_plaid_token]
		super
	end

	private
		''' Password Encryption '''
		def encrypt_password
		  if password.present?
		    self.salt = BCrypt::Engine.generate_salt
		    self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
		  end
		end

		def clear_password
		  self.password = nil
		end

		'''Authentication Token'''
		def ensure_authentication_token
		    if authentication_token.blank?
		      self.authentication_token = generate_authentication_token
		    end
		end

	    def generate_authentication_token
	    	loop do
	      		token = generate_secure_token_string
	      		break token unless User.where(authentication_token: token).first
	    	end
	    end

	    def generate_secure_token_string
	    	SecureRandom.urlsafe_base64(25).tr('lIO0', 'sxyz')
	  	end

	  	def reset_authentication_token!
	    	self.authentication_token = generate_authentication_token
	  	end
end
