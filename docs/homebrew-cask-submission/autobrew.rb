cask "autobrew" do
  version "2.3.0"
  sha256 "db885bc65da52772823b1e78be4ef5ca3d041937d2f71d086f0eb4feccab0c83"

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
