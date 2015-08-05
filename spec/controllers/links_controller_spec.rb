require 'rails_helper'

RSpec.describe LinksController, type: :controller do

  describe "GET #index" do

    before do
      get :index
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "renders correct template" do
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do

    context "no links created" do

      it "redirects to #index" do
        get :show, :id => 'qwerty'
        expect(response).to redirect_to('/')
      end
    end

    context "with links created" do

      let(:link) { Link.create!(origin: "example.com") }

      it "redirects to origin" do
        get :show, :id => link.url
        expect(response).to redirect_to(link.origin)
      end

      it "increment counter after redirect to origin" do
        get :show, :id => link.url
        expect(Link.last.counter).to be > link.counter
      end

      it "shows link info page if '+' char passed" do
        get :show, :id => "#{link.url}+"
        expect(response).to render_template(:show)
      end

      it "shows link info page if '+' char passed" do
        get :show, :id => "#{link.url}+"
        expect(assigns(:link)).to eq(link)
      end
    end

    context "link creation" do

      it "creates link" do
        post :create, link: {origin: 'example.com'}
        expect(Link.count).to eq(1)
      end

      it "redirects after creation" do
        post :create, link: {origin: 'example.com'}
        expect(response).to redirect_to(link_path "#{Link.first.url}+")
      end
    end

  end

end
