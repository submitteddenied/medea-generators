  it "new action should render new templates" do
    get :new
    response.should render_template(:new)
  end
