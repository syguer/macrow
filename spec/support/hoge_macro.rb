class HogeMacro < Macrow
  rules do
    rule 'ping' do
      'pong'
    end

    rule 'length' do |object|
      object.length
    end
  end
end
