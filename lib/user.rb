USER = [ :_id, :url, :external_id, :name, :alias, :created_at, :active, :verified, :shared, :locale, :timezone, :last_login_at, :email, :phone, :signature, :organization_id, :tags, :suspended, :role ]

class User
  attr_accessor *USER

  def initialize(user)
    USER.each do |attribute|
      eval "@#{attribute} = user[attribute.to_s]"
    end
  end

  def display
    USER.each do |field|
      printf "%-20s %s\n", field, self.send(field)
    end
  end
end
