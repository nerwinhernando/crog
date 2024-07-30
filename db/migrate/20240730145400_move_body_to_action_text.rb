class MoveBodyToActionText < ActiveRecord::Migration[7.1]
  def change
    BlogPost.all.find_each do |bp|
      bp.update(content: bp.body)
    end

    remove_column :blog_posts, :body
  end
end
