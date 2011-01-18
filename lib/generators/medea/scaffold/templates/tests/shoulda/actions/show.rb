  context "show action" do
    should "render show templates" do
      get :show, :id => <%= class_name %>.first
      assert_template 'show'
    end
  end
