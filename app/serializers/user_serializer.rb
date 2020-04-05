class UserSerializer < ActiveModel::Serializer
  # di update terbaru tidak perlu pakai embed,
  # tinggal tulis saja product_ids di attributesnya
  # embed :ids, :include => true

  attributes :id, :email, :created_at, :updated_at, :auth_token, :product_ids
  has_many :products
end
