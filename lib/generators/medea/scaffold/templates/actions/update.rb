  def update
    @<%= instance_name %> = <%= class_name %>.get_by_key(params[:id])
    if @<%= instance_name %>.update_attributes(params[:<%= instance_name %>])
      flash[:notice] = "Successfully updated <%= class_name.underscore.humanize.downcase %>."
      redirect_to <%= item_url %>
    else
      render :action => 'edit'
    end
  end
