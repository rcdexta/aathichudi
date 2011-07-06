class Comment
  attr_accessor :name, :email, :comment

  def inspect
    "<name: #{name}, email: #{email}, comment: #{comment}>"
  end
end
