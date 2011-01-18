  context "index action" do
    should "render index templates" do
      get :index
      assert_template 'index'
    end
  end
