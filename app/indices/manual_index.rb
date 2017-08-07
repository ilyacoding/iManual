ThinkingSphinx::Index.define :manual, :with => :real_time do
  indexes name, :type => :string, :sortable => true
  indexes nested_contents

  has id, :as => :manual_id, :type => :integer
end
