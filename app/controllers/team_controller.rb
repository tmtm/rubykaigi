class TeamController < LocaleBaseController
  layout_for_latest_ruby_kaigi
  def index
    @team = YAML.load(File.read(File.join(Rails.root, 'db', '2011', 'team.yaml')))
  end
end
