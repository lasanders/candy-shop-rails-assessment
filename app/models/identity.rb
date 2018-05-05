class Identity < ApplicationRecord
  belongs_to :user

  attr_accessible :provider, :client_id,
                  :email, :name, :password

  validates_presence_of :provider, :client_id
  validates_uniqueness_of :uid, scope: :provider

  def self.find_with_omniauth(auth)
    find_by_provider_and_client_id(auth['provider'], auth['client_id'])
  end

  def self.create_with_omniauth(auth)
    create(provider:      auth['provider'],
            client_id:    auth['client_id'],
            name:         auth['info']['name'],
            email:        auth['info']['email']
          )
  end
end