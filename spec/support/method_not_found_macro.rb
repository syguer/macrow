class MethodNotFoundMacro < Macrow
  rules do
    rule 'hoge' do |object|
      object.will_fail
    end
  end
end
