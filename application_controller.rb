class Hash
  def now
    { alert: "Yeah"}
  end
end
class ApplicationController
  def flash
    Hash.new
  end
end
