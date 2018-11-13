# frozen_string_literal: true

class UserSessionSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :auth_token
end
