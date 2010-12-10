class Integer
  ENCODE_CHARS =
    %w(S J x F K R c f
       W r d j m V b t
       N Z C T G h n P
       M D B H p Q v k)

  OFFSET = 9876

  DECODE_MAP = ENCODE_CHARS.to_enum(:each_with_index).inject({}) do |h,(c,i)|
    h[c] = i; h
  end

  def to_obfuscated
    (self + OFFSET).to_s(2).reverse.scan(/.{1,5}/).map do |bits|
      ENCODE_CHARS[bits.reverse.to_i(2)]
    end.reverse.join
  end

  def self.unobfuscate(string)
    string.split(//).map { |char|
      DECODE_MAP[char] or return nil
    }.inject(0) { |result,val| (result << 5) + val } - OFFSET
  end
end
