# frozen_string_literal: true

ThinkingSphinx::Index.define :user, with: :active_record, delta: true do
  indexes :name, sortable: true
  indexes :email
end
