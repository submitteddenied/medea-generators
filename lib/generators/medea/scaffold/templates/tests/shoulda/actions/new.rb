  context "new action" do
    should "render new templates" do
      get :new
      assert_template 'new'
    end
  end
