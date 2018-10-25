class Player
    attr_accessor :name, :token

    def initialize(name, token)
        @name = name
        @token = token
    end
    
    def to_s
        @token
    end

end