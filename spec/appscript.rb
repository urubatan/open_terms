module Appscript
  def app(name)
    if name=="System Events"
      $system_mock
    else
      $term_mock
    end
  end
end
