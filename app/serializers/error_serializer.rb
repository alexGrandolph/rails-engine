class ErrorSerializer

  def self.cant_find_error
    { 
      data: {
        message: 'bad request',
        error: 'unable to find a match'
      }
    }
  end
  
end 