# frozen_string_literal: true

ThinkingSphinx::Index.define :project, with: :active_record, delta: true do
  indexes :name, sortable: true
  indexes :details
end
