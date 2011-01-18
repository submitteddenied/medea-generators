  it "index action should render index templates" do
    get :index
    response.should render_template(:index)
  end
