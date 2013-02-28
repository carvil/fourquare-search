OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :foursquare, "2DREYBAIO00E4XFZNOLM51BYT3W2IBGTUMZXWNY1PN0QH2W3", "5ZQJQUQGQ5WNNVGQOXKN3ZONDDSSLTFP1WC02WYVZKDSRG3D"
end
