require 'spec_helper'

module Locations
  describe LibrariesController, type: :controller do

    routes { Locations::Engine.routes }

    let(:invalid_attributes) {
      skip("Add a hash of attributes invalid for your model")
    }

    # This should return the minimal set of values that should be in the session
    # in order to pass any filters (e.g. authentication) defined in
    # LibrariesController. Be sure to keep this updated too.
    let(:valid_session) { {} }

    describe "GET #index" do
      it "assigns all libraries as @libraries" do
        library = FactoryGirl.create(:library)
        get :index, {}, valid_session
        expect(assigns(:libraries)).to eq([library])
      end
    end

    describe "GET #show" do
      it "assigns the requested library as @library" do
        library = FactoryGirl.create(:library)
        get :show, { id: library.to_param}, valid_session
        expect(assigns(:library)).to eq(library)
      end
    end

    describe "GET #new" do
      it "assigns a new library as @library" do
        get :new, {}, valid_session
        expect(assigns(:library)).to be_a_new(Library)
      end
    end

    describe "GET #edit" do
      it "assigns the requested library as @library" do
        library = FactoryGirl.create(:library)
        get :edit, { id: library.to_param}, valid_session
        expect(assigns(:library)).to eq(library)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new Library" do
          expect {
            post :create, { library: FactoryGirl.attributes_for(:library) }, valid_session
          }.to change(Library, :count).by(1)
        end

        it "assigns a newly created library as @library" do
          post :create, { library: FactoryGirl.attributes_for(:library) }, valid_session
          expect(assigns(:library)).to be_a(Library)
          expect(assigns(:library)).to be_persisted
        end

        it "redirects to the created library" do
          post :create, { library: FactoryGirl.attributes_for(:library) }, valid_session
          expect(response).to redirect_to(Library.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved library as @library" do
          post :create, {library: invalid_attributes}, valid_session
          expect(assigns(:library)).to be_a_new(Library)
        end

        it "re-renders the 'new' template" do
          post :create, { library: invalid_attributes }, valid_session
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT #update" do
      context "with valid params" do
        let(:new_attributes) { FactoryGirl.attributes_for(:library) }

        it "updates the requested library" do
          library = FactoryGirl.create(:library)
          put :update, { id: library.to_param, :library => new_attributes}, valid_session
          library.reload
          skip("Add assertions for updated state")
        end

        it "assigns the requested library as @library" do
          library = FactoryGirl.create(:library)
          put :update, { id: library.to_param, library: FactoryGirl.attributes_for(:library) }, valid_session
          expect(assigns(:library)).to eq(library)
        end

        it "redirects to the library" do
          library = FactoryGirl.create(:library)
          put :update, { id: library.to_param, library: FactoryGirl.attributes_for(:library) }, valid_session
          expect(response).to redirect_to(library)
        end
      end

      context "with invalid params" do
        it "assigns the library as @library" do
          library = FactoryGirl.create(:library)
          put :update, { id: library.to_param, library: invalid_attributes}, valid_session
          expect(assigns(:library)).to eq(library)
        end

        it "re-renders the 'edit' template" do
          library = FactoryGirl.create(:library)
          put :update, { id: library.to_param, library: invalid_attributes}, valid_session
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested library" do
        library = FactoryGirl.create(:library)
        expect {
          delete :destroy, { id: library.to_param }, valid_session
        }.to change(Library, :count).by(-1)
      end

      it "redirects to the libraries list" do
        library = FactoryGirl.create(:library)
        delete :destroy, { id: library.to_param}, valid_session
        expect(response).to redirect_to(libraries_path)
      end
    end

  end
end
