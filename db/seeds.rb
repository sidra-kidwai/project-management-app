# frozen_string_literal: true

User.create!(name: 'Admin User', email: 'admin@example.com',
             password: 'password', password_confirmation: 'password', role: 2)
