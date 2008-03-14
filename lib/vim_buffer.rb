class VimBuffer
  def initialize
    @buffer = VIM::Buffer.current
  end

  def clear!
    while (@buffer.length > 1)
      @buffer.delete(1)
    end
    @buffer.delete(1)
  end

  def append(text)
    if text.length == 0
      @buffer.append(@buffer.length - 1, "")
    else  
      text.each_line do |line|
        @buffer.append(@buffer.length - 1, line.chomp)
      end
    end
  end

  def current_line
    @buffer.line
  end
end
