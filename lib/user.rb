USER = [ :_id, :url, :external_id, :name, :alias, :created_at, :active, :verified, :shared, :locale, :timezone, :last_login_at, :email, :phone, :signature, :organization_id, :tags, :suspended, :role ]

class User
  attr_accessor *USER

  def initialize(user)
    USER.each do |attribute|
      eval "@#{attribute} = user[attribute.to_s]"
    end
  end

  def display
    result = ''
    USER.each do |field|
      result.concat sprintf "%-20s %s\n", field, self.send(field)
    end
    return result
  end

  def self.find(search_term, search_value, users)

    unless USER.include?(search_term.to_sym)
      Search.error "Search term not found"
      return
    end

    selected = @users.select{|user| user.send(search_term) == search_value.to_i}

    if selected.count == 0
      Search.error "No users match"
    end

    selected.each do |user|
      return user.display
    end
  end

end
