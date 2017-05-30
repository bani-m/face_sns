class Comment < ActiveRecord::Base
  belongs_to :user, de
  belongs_to :topic
end
