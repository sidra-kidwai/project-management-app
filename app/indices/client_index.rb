# frozen_string_literal: true

ThinkingSphinx::Index.define :client, with: :active_record, delta: true do
  indexes :name, sortable: true
end
