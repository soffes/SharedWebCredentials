desc 'Generate documentation'
task :docs do
  sh 'rm -rf docs'
	sh 'jazzy \
	--clean \
	--author "Sam Soffes" \
	--author_url https://soff.es \
	--github_url https://github.com/soffes/SharedWebCredentials \
	--github-file-prefix https://github.com/soffes/SharedWebCredentials/tree/`git describe --tags --abbrev=0` \
	--root-url https://soffes.github.io/SharedWebCredentials/ \
	--output docs/'
  sh 'rm -rf build'
end
