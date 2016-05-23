require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  let(:valid_attributes) do {
      caption: Faker::Lorem.words,
      image_file_name: "aphoto.jpg"
    }
  end

  let(:post) { Post.create valid_attributes}

  describe "GET index" do
    it "assigns all posts as @posts" do
      post = Post.create! valid_attributes
      get :index, {}
      expect(assigns(:posts)).to eq([post])
    end
  end

  describe "Get show" do
    it "assigns the the requested do as @post" do
      post = Post.create! valid_attributes
      get :show, { id: post.id }
      expect(assigns(:post)).to eq(post)
    end
  end

  describe "GET edit" do
    xit "assigns the requested post as @post" do
      get :edit, { id: post.id }, valid_attributes
      expect(assigns(:post)).to eq(post)
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested post" do
      post = Post.create! valid_attributes
      delete :destroy, { id: post.id }
      expect(Post.find_by_id(:post)).to be_nil
    end

    it "redirects to sign in unless user logged in" do
      post = Post.create! valid_attributes
      delete :destroy, { id: post.id }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
