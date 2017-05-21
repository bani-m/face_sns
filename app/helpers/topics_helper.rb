module TopicsHelper
  def choose_new_or_edit
    if action_name == 'new' || action_name == 'confirm'
      confirm_blogs_path
    elsif action_name == 'edit'
      topic_path
    end
  end
end