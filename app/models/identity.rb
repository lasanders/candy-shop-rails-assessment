class Identity < ApplicationRecord
  belongs_to :user

  attr_accessor :provider, :uid,
                  :email, :name, :password

  validates_presence_of :provider, :uid
  validates_uniqueness_of :uid, scope: :provider

  def self.find_with_omniauth(auth)
    find_by_provider_and_uid(auth['provider'], auth['uid'])
  end
    def self.create
  # def self.create_with_omniauth(auth['provider'], auth['uid'], auth['name'], auth['email'])
  #   create(provider:      auth['provider'],
  #           uid:          auth['uid'],
  #           name:         auth['name'],
  #           email:        auth['email'],
  #           # password:     auth['info']['password']
  #         )
   end
end