class Message
  import ActiveModel::Model
  validates :name, presence: true
  validates :email, presence: true, format: /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates :content, presence: true, length: { maximum: 500 }


end
