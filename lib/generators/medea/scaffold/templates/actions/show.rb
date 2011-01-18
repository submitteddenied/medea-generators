  def show
    @<%= instance_name %> = <%= class_name %>.get_by_key(params[:id])
  end
