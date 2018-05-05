class Identity < ApplicationRecord
  belongs_to :user

  attr_accessor :provider, :uid,
                  :email, :name, :password

  validates_presence_of :provider, :uid
  validates_uniqueness_of :uid, scope: :provider

  def self.find_with_omniauth(auth)
    find_by_provider_and_uid(auth['provider'], auth['uid'])
  end

  def self.create_with_omniauth(auth)
    create(provider:      auth['provider'],
            uid:          auth['uid'],
            name:         auth['info']['name'],
            email:        auth['info']['email']
          )
  end
end