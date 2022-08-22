require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let!(:product) {create(:product)}

  before do
    sign_in product.user
  end


  describe 'Products Controller Specs' do
    context 'before_actions' do
      it { should use_before_action(:authenticate_user!) }
      it { should use_before_action(:set_product) }
      it { should use_before_action(:authorize_product) }
    end

    context 'after_actions' do
      it { should use_after_action(:verify_authorized) }
    end

    context 'routes' do
      it { should route(:get, '/user/products').to(action: :index) }
      it { should route(:get, '/user/products/new').to(action: :new) }
      it { should route(:post, '/user/products').to(action: :create) }
      it { should route(:get, '/products/1/edit').to(action: :edit, id: 1) }
      it { should route(:put, '/products/1').to(action: :update, id: 1) }
      it { should route(:patch, '/products/1').to(action: :update, id: 1) }
      it { should route(:delete, '/products/1').to(action: :destroy, id: 1) }
      it { should route(:get, '/products/1').to(action: :show, id: 1) }
    end

    describe 'GET #index' do
      context 'when user exist' do
        before { get :index }
        it 'should have http status 200' do
          expect(response).to have_http_status(200)
        end
        it 'should respond with index' do
          expect(response).to render_template(:index)
        end
        it 'assigns @products' do
          expect(assigns(:products)).to include(product)
        end
      end
    end

    describe 'GET #new' do
      context 'Adding new user product' do
        before { get :new }
        it 'should have http status 200' do
          expect(response).to have_http_status(200)
        end
        it 'should respond with new' do
          expect(response).to render_template(:new)
        end
        it 'should assign a value to @product' do
          expect(assigns(:product)).not_to eq nil
        end
      end
    end

    describe 'POST #create' do
      context 'Creating new user product' do
        before {product.destroy}
        context 'with valid attributes' do
          before do
            post :create, params: {
              product: FactoryBot.attributes_for(:product),
            }
          end
          it 'should assign a value to @product' do
            expect(assigns(:product)).not_to eq nil
          end
          it 'should create a product and increment the count' do
            expect{
              post :create, params: {
                product: attributes_for(:product),
              }}.to change(Product, :count).by(1)
          end
          it 'should create a comment and increment the count' do
            expect{
              post :create, params: {
                product: attributes_for(:product),
              }}.to change(Product, :count).by(1)
          end
        end

        context 'with invalid attributes' do
          before do
            post :create,
            params: { product: { name: nil }, id: product.id }
          end
          it 'does not create product and render' do
            expect(response).to render_template('new')
          end
        end
      end
    end

    describe 'GET #edit' do
      context 'Editing existing user product' do
        let(:product) { create(:product)}
        before do
          get :edit, params: {
            id: product.id
          }
        end
        it 'should have http status 200' do
          expect(response).to have_http_status(200)
        end
        it 'should respond with edit' do
          expect(response).to render_template(:edit)
        end
      end
    end

    describe 'POST #update' do
      context 'Updating user product with valid attributes' do
        before {
          put :update, params: {
          product:{
            name: 'updating Product',
            user_id: product.user_id,
            images: []
          },
          id: product.id } }
        it 'should update a product and redirect to updated product' do
          expect(response).to redirect_to product
        end
        it 'should update a product and check if updated' do
          expect(product.saved_change_to_name?).not_to be_truthy
        end
      end

      context 'Updating user product with invalid attributes' do
        before {
          patch :update, params: { product: { name: nil }, id: product.id }
        }
        it 'does not update product and render' do
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE /destroy' do
      context 'when the user tries to delete product with valid attributes' do
        it 'delete a product when user is logged in, decrement count and redirect' do
          expect { delete :destroy, params: { id: product.id }}.to change(Product, :count).by(-1)
          expect(response).to redirect_to user_products_path
        end
      end
      context 'Invalid case for delete' do
        it 'not destroying the product' do
          allow_any_instance_of(Product).to receive(:destroy).and_return(false)
          expect { delete :destroy, params: { id: product.id }}.to change(Product, :count).by(0)
          expect(flash[:alert]).to have_content 'There is some error in destroying Product'
        end
      end
    end

    describe 'GET #show' do
      context 'when product exist' do
        let(:product) { create(:product)}
        before do
          get :show, params: {
            id: product.id
          }
        end
        it 'should have http status 200' do
          expect(response).to have_http_status(200)
        end
        it 'should respond with show' do
          expect(response).to render_template(:show)
        end
      end
    end

    describe 'Get #all_products' do
      context 'List all the products' do
        it 'returns a 200 status code' do
          get :all_products
          expect(response).to have_http_status(200)
        end

        it 'renders the all_products template' do
          get :all_products
          expect(response).to render_template('all_products')
        end

        it 'assigns @products when user signed in' do
          get :all_products
          expect(assigns(:products)).not_to include([create(:product)])
        end
        it 'assigns @products when user not signed in' do
          sign_out product.user
          get :all_products
          expect(assigns(:products)).not_to include([create(:product)])
        end
      end
    end

  end
end
