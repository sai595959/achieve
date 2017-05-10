class Blog < ActiveRecord::Base
    validates :title, presence: true
    belongs_to :user

    #CommentモデルのAssociation
    # dependent: :destroyを設定することでBlogモデルが削除された時に紐づくコメントのレコードも削除される
    has_many :comments, dependent: :destroy

end
