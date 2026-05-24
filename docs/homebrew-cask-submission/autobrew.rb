cask "autobrew" do
  version "2.4.0"
  sha256 "525b428780582dc4c0d480e3d1e9d6f0ad45ec875e9edada3fab5f6fe98c53fa"

  url "https://github.com/marcelrgberger/auto-brew/releases/download/v#{version}/AutoBrew.dmg"
  name "AutoBrew"
  desc "Menu bar app that automates Homebrew updates and snapshots app data"
  homepage "https://github.com/marcelrgberger/auto-brew"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "AutoBrew.app"

  zap trash: [
    "~/Library/Application Support/AutoBrew",
    "~/Library/Preferences/za.co.digitalfreedom.AutoBrew.plist",
  ]
end
