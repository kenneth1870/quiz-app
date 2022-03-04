module ChecklistsHelper
  
  def get_checkbox_style(public)
    public == true ? 'checked="checked"' : ''
  end

  def get_public_name(public)
    public == true ? 'Published' : 'Unpublished'
  end

end
