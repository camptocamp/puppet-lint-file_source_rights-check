PuppetLint.new_check(:source_without_rights) do
  def token_attr(resource, name)
    resource[:tokens].select do |t|
        t.type == :NAME && t.value == name && \
          t.next_code_token && t.next_code_token.type == :FARROW
    end
  end

  def check_attr(resource, name, source_t)
    if token_attr(resource, name).empty?
      notify :warning, {
        :message => "file with source missing #{name}",
        :line    => source_t.line,
        :column  => source_t.column,
        :token   => source_t,
      }
    end
  end

  def check
    resource_indexes.each do |r|
      next unless r[:type].value == 'file'
      source_t = token_attr(r, 'source')
      next if source_t.empty?

      check_attr(r, 'owner', source_t[0])
      check_attr(r, 'group', source_t[0])
      check_attr(r, 'mode', source_t[0])
    end
  end 
end
