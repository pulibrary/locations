require 'spec_helper'

module Locations
  describe LibrariesController, type: :controller do

    routes { Locations::Engine.routes }

    let(:invalid_attributes) {
      FactoryGirl.attributes_for(:library, label: nil)
    }

    let(:valid_session) { {} }

    describe "GET #index" do
      render_views

      it "assigns all libraries as @libraries" do
        library = FactoryGirl.create(:library)
        get :index
        expect(assigns(:libraries)).to eq([library])
      end

      it 'libraries is active in navbar' do
        get :index
        expect(response.body.include?('<li class="active"><a href="/locations/libraries')).to eq true
      end

    end

    describe "GET #show" do
      it "assigns the requested library as @library" do
        library = FactoryGirl.create(:library)
        get :show, params: { id: library.code}
        expect(assigns(:library)).to eq(library)
      end
    end

    describe "GET #new" do
      it "assigns a new library as @library" do
        get :new
        expect(assigns(:library)).to be_a_new(Library)
      end
    end

    describe "GET #edit" do
      it "assigns the requested library as @library" do
        library = FactoryGirl.create(:library)
        get :edit, params: { id: library.code}
        expect(assigns(:library)).to eq(library)
      end
    end

    describe "POST #create" do
      let(:valid_params) { { params: { library: FactoryGirl.attributes_for(:library) } } }
      let(:invalid_params) { { params: {library: invalid_attributes} } }
      context "with valid params" do
        it "creates a new Library" do
          expect {
            post :create, valid_params
          }.to change(Library, :count).by(1)
        end

        it "assigns a newly created library as @library" do
          post :create, valid_params
          expect(assigns(:library)).to be_a(Library)
          expect(assigns(:library)).to be_persisted
        end

        it 'passes flash notice message' do
          post :create, valid_params
          expect(flash[:notice]).to be_present
        end

        it "redirects to the created library" do
          post :create, valid_params
          expect(response).to redirect_to(Library.last)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved library as @library" do
          post :create, invalid_params
          expect(assigns(:library)).to be_a_new(Library)
        end

        it 'passes a flash error message' do
          post :create, invalid_params
          expect(flash[:error]).to be_present
        end

        it "re-renders the 'new' template" do
          post :create, invalid_params
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT/PATCH #update" do
      let(:library) { FactoryGirl.create(:library) }
      let(:updated_label) { 'Updated Label'}
      let(:new_attributes) {
        opts = { label: updated_label, code: library.code }
        FactoryGirl.attributes_for(:library, opts)
      }
      let(:valid_params) { { params: { id: library.code, library: new_attributes } } }
      let(:invalid_params) { { params: { id: library.code, library: invalid_attributes} } }
      context "with valid params" do
        it "updates the requested library" do
          put :update, valid_params
          library.reload
          expect(library.label).to eq updated_label
        end

        it "assigns the requested library as @library" do
          put :update, valid_params
          expect(assigns(:library)).to eq(library)
        end

        it 'passes flash notice message' do
          put :update, valid_params
          expect(flash[:notice]).to be_present
        end

        it "redirects to the library" do
          put :update, valid_params
          expect(response).to redirect_to(library)
        end
      end

      context "using ajax" do
        let(:updated_order) { 15 }
        let(:ajax_params) { { params: { order: updated_order, id: library.id, format: :js } } }
        it "updates the requested library's order" do
          original_order = library[:order]
          expect {
              patch :update, ajax_params
            }.to change { library.reload[:order] }.from(original_order).to(updated_order)
        end
      end

      context "with invalid params" do
        it "assigns the library as @library" do
          put :update, invalid_params
          expect(assigns(:library)).to eq(library)
        end

        it 'passes a flash error message' do
          put :update, invalid_params
          expect(flash[:error]).to be_present
        end

        it "re-renders the 'edit' template" do
          put :update, invalid_params
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested library" do
        library = FactoryGirl.create(:library)
        expect {
          delete :destroy, params: { id: library.code }
        }.to change(Library, :count).by(-1)
      end

      it 'passes flash notice message' do
        library = FactoryGirl.create(:library)
        delete :destroy, params: { id: library.code }
        expect(flash[:notice]).to be_present
      end

      it "redirects to the libraries list" do
        library = FactoryGirl.create(:library)
        delete :destroy, params: { id: library.code }
        expect(response).to redirect_to(libraries_path)
      end
    end

  end
end
