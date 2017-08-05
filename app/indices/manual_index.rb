ThinkingSphinx::Index.define :manual, :with => :real_time do
  indexes name, :type => :string, :sortable => true
  indexes nested_contents
  # indexes content, :type => :text
  # indexes user.name, :as => :user, :sortable => true
  #
  # has tag_ids, :multi => true
  has id, :as => :manual_id, :type => :integer
  # has user_id,  :type => :integer
  # has created_at, :type => :timestamp
  # has updated_at, :type => :timestamp
end
