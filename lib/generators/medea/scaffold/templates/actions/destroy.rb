  def destroy
    @<%= instance_name %> = <%= class_name %>.get_by_key(params[:id])
    @<%= instance_name %>.delete!
    flash[:notice] = "Successfully destroyed <%= class_name.underscore.humanize.downcase %>."
    redirect_to <%= items_url %>
  end
