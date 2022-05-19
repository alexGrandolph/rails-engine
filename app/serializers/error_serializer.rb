class ErrorSerializer

  def self.cant_find_error
    { 
      data: {
        error: 'unable to find a match'
      }
    }

  end 

end 