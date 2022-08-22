require 'rails_helper'

RSpec.describe CommentsController do
  let!(:comment){create(:comment)}
  let(:product){ comment.product }

  before do
    sign_in comment.user
  end

  context 'Comments Controller Specs' do
    describe 'before_actions' do
      it { should use_before_action(:authenticate_user!) }
      it { should use_before_action(:set_product) }
      it { should use_before_action(:set_comment) }
    end

    describe 'after_actions' do
      it { should use_after_action(:verify_authorized) }
    end

    describe 'routes' do
      it { should route(:get, '/products/1/comments').to(action: :index, product_id: 1) }
      it { should route(:get, '/products/1/comments/new').to(action: :new, product_id: 1) }
      it { should route(:post, '/products/1/comments').to(action: :create, product_id: 1) }
      it { should route(:get, '/comments/1/edit').to(action: :edit, id: 1) }
      it { should route(:put, '/comments/1').to(action: :update, id: 1) }
      it { should route(:patch, '/comments/1').to(action: :update, id: 1) }
      it { should route(:delete, '/comments/1').to(action: :destroy, id: 1) }
    end


    describe 'GET #new' do
      login_user
      context 'Adding new comment to product' do
        let(:product) { create(:product)}
        let(:user) { create(:user)}
        before do
          get :new, params: {
            product_id: product.id
          }
        end
        it 'should have http status 200' do
          expect(response).to have_http_status(200)
        end
        it 'should respond with new' do
          expect(response).to render_template(:new)
        end
        it 'should assign a value to @comment' do
          expect(assigns(:comment)).not_to eq nil
        end
      end
    end

    describe 'POST #create' do
      context 'Creating new product comment' do
        context 'with valid attributes' do
          before do
            comment.destroy
            post :create, params: {
              comment: attributes_for(:comment),
              product_id: product.id
            }
          end
          it 'should assign a value to @comment' do
            expect(assigns(:comment)).not_to eq nil
          end
          it 'should create a comment and redirect to the product' do
            expect(response).to redirect_to product
          end
          it 'should create a comment and increment the count' do
            expect{
              post :create, params: {
                comment: attributes_for(:comment),
                product_id: product.id
              }}.to change(Comment, :count).by(1)
          end
        end
        context 'with invalid attributes' do
          before do
            comment.destroy
            post :create, params: {
              comment: {body: nil},
              product_id: product.id
            }
          end
          it 'should not create a comment and show alert' do
            expect(flash[:alert]).to have_content 'Comment is not valid.'
          end
        end
      end
    end

    describe 'GET #edit' do
      context 'Editing existing product comment' do
        before do
          get :edit, xhr: true, params: {
            id: comment.id,
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
      context 'Updating comment with valid attributes' do
        before { patch :update, params: {
          comment:{
            body: 'updating comment',
            user_id: comment.user_id
          },
          id: comment.id,
          product_id: comment.product_id } }
        it 'should update a comment and redirect to product' do
          expect(response).to redirect_to product
        end
        it 'should update a comment and check if updated' do
          expect(true).to  eq(comment.saved_change_to_body?)
        end
      end

      context 'Updating comment with invalid attributes' do
        before {
          patch :update, params: { comment: { body: nil }, id: comment.id }
        }
        it 'does not update comment and render' do
          expect(response).to render_template('edit')
        end
      end
    end

    describe 'DELETE /destroy' do
      context 'when the user tries to delete comment with valid attributes' do
        it 'delete a comment and decrement the count and redirect to product' do
          expect { delete :destroy, params: { id: comment.id }}.to change(Comment, :count).by(-1)
          expect(response).to redirect_to product
        end
      end
      context 'Invalid case for delete' do
        it 'not destroying the comment' do
          allow_any_instance_of(Comment).to receive(:destroy).and_return(false)
          expect { delete :destroy, params: { id: comment.id }}.to change(Product, :count).by(0)
          expect(flash[:alert]).to have_content 'There is some error in deleting comment.'
        end
      end
    end


  end

end
