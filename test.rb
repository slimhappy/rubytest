class String

  def rot13
  	self.tr("A-Ma-mN-Zn-z","N-Zn-zA-Ma-m")
  end

end

joke = "Y2K bug"
joke13 = joke.rot13
puts joke13

episode_2 = "Fcbvyre: Naanxva qbrfa'g trg xvyyq."
puts episode_2.rot13
