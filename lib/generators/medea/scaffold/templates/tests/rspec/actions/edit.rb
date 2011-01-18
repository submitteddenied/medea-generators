  it "edit action should render edit templates" do
    get :edit, :id => <%= class_name %>.first
    response.should render_template(:edit)
  end
