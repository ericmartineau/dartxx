# /etc/skel/.bashrc:
# $Header: /home/cvsroot/gentoo-src/rc-scripts/etc/skel/.bashrc,v 1.8 2003/02/28 15:45:35 azarah Exp $

alias sf='cd ~/sunny/sunny_flutter'

ulimit -n 2048

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# PATH SETUP
export LIBTOOL=glibtool
export PATH=$PATH:/usr/local/opt/go/libexec/bin:~/go/bin
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
export GRADLE_OPTS="-Xmx2g"
export HISTFILESIZE=1000000000 
export HISTSIZE=1000000
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH=$PATH:/usr/local/groovy/bin
export PATH=$PATH:/usr/local/opt
export PATH=$PATH:/usr/local/mysql/bin
export PATH=$PATH:/usr/local/scala/bin
export PATH=/usr/local/bin:$PATH
export CMAKE_SYSTEM_PREFIX_PATH="${CMAKE_SYSTEM_PREFIX_PATH}:/usr/local/share"
export PATH=$PATH:/Applications/Xcode.app/Contents/Developer/usr/bin
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
export PATH=$PATH:/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
export PATH=$PATH:~/sunny/ext/depot_tools
export PATH=$PATH:~/.cargo/bin
export PATH=$PATH:/usr/local/sbin
export PATH="$PATH":"$HOME/.pub-cache/bin"


eval "$(rbenv init -)"
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

complete -C '/usr/local/bin/aws_completer' aws

#export PATH=$PATH:/usr/local/flutter/bin
#export PATH=$PATH:/usr/local/flutter/.pub-cache/bin
#export PATH=$PATH:/usr/local/flutter/bin/cache/dart-sdk/bin

# export PATH=$PATH:~/sunny/sunny_flutter/.flutter/bin:~/sunny/sunny_flutter/.flutter/bin/cache/dart-sdk/bin

alias lsl='ls -lah'
export NO_PROXY=localhost,127.0.0.1,*.local
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export INFR=~/.m2/repository/com/infusionsoft/
export II=~/.m2/repository/com/infusionsoft/
export MAVEN_OPTS="-XX:ReservedCodeCacheSize=64m -Xmx1200m -XX:MaxPermSize=512m -XX:CompileCommand=exclude,com/infusion/databridge/MemoryRst,loadMeta -Dfile.encoding=ISO-8859-1"
export GRAILS_OPTS="-Xmx1200m -XX:MaxPermSize=512m"
export JAVA_DEBUG="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005"

alias debug_gradle='export GRADLE_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,server=y,suspend=y,address=5005"'
alias undebug_gradle='export GRADLE_OPTS="-Xmx2g"'
alias vpnin='/opt/cisco/anyconnect/bin/vpn connect anyconnect.infusionsoft.com'
alias vpnout='/opt/cisco/anyconnect/bin/vpn disconnect'
alias uuidg='uuidgen | tr -d "\n" | pbcopy'
alias sdkgen='./gradlew -x integrationTest -x test -x findbugsMain clean buildSdk publishToMavenLocalSdk'
alias sdkgen2='./gradlew -x integrationTest -x test -x findbugsMain clean buildSdk installSdk'
alias vgg='vi ~/.grails/goldfish-backend-config.groovy'
alias vg='vi ~/.gradle/gradle.properties'
alias vb='vi build.gradle'
alias vz='vi ~/.zshrc'
alias gs='git status'
alias greb="git pull —-rebase"
alias grs='git pull —-rebase --autostash'
alias grc='git rebase —-continue'
alias gra='git rebase —-abort'
alias gitb='git branch -m $1'
alias gitm='git checkout master'
alias gp='git push'
alias pc='cd ~/ && git commit -a --no-edit -m "Script to push .profile"; git pull --rebase && git push && sp'
alias md5='md5 -r'
alias md5sum='md5 -r'
alias vi='subl'
alias gw="./gradlew"
alias gwv="./gradlew currentVersion"
alias gwl="./gradlew publishToMavenLocal"
alias gwb="./gradlew build"
alias ppe='pip3.6 install --upgrade -e .'
alias sshcubtrails='ssh -i ~/.ssh/lightsail-us-west.pem bitnami@34.209.19.22'
alias sshavidoffroad='ssh -i ~/.ssh/lightsail-us-west.pem bitnami@52.43.103.98'
alias cdalex='cd ~/projects/alexandria && direnv reload'
alias ssh-sunny='ssh -i ~/.ssh/sunny/sunny-ec2-us-west-2.pem ec2-user@54.212.85.240'
alias ssh-sunny-2='ssh -i ~/.ssh/sunny/sunny-ec2-us-west-2.pem ec2-user@ec2-34-222-156-200.us-west-2.compute.amazonaws.com'
alias gdcl='/Applications/Glyph\ Designer.app/Contents/MacOS/Glyph\ Designer'
export POSTMAN_API_KEY=06cd360c41464d629b2af353043790df

alias rv_upload='aws s3 cp ~/sunny/sunnyslack/build/distributions/sunnyslack-single.zip s3://elasticbeanstalk-us-west-2-145846705633/reliveit_latest.zip --profile sunny'
unset circle_echo
circle_echo() {
	echo "CIRCLE_TAG=${CIRCLE_TAG}"
	echo "CIRCLE_BRANCH=${CIRCLE_BRANCH}"
	echo "CIRCLE_PROJECT_REPONAME=${CIRCLE_PROJECT_REPONAME}"
}

unset bmfonter
bmfonter() {
	if [[ -n "$1" ]]; then
		mkdir -p $1
		echo "Generating size 16 font for $0"
		/Applications/Glyph\ Designer.app/Contents/MacOS/Glyph\ Designer $1.GlyphProject $1/$1_16 -fs 16 -fo LUA-lua	
		echo "Generating size 24 font for $0"
		/Applications/Glyph\ Designer.app/Contents/MacOS/Glyph\ Designer $1.GlyphProject $1/$1_24 -fs 24 -fo LUA-lua	
		echo "Generating size 48 font for $0"
		/Applications/Glyph\ Designer.app/Contents/MacOS/Glyph\ Designer $1.GlyphProject $1/$1_48 -fs 48 -fo LUA-lua	
		echo "Generating size 72 font for $0"
		/Applications/Glyph\ Designer.app/Contents/MacOS/Glyph\ Designer $1.GlyphProject $1/$1_72 -fs 72 -fo LUA-lua	
	else
		echo "Usage bmfonter [project_name]"
	fi
	
}

unset build_swagger
build_swagger() {
	cd ~/mverse/ext/swagger-codegen/modules/swagger-codegen
	mvn  install -Dmaven.test.skip=true -e
	cd ~/mverse/ext/swagger-codegen/modules/swagger-codegen-cli
	mvn  install -Dmaven.test.skip=true -e
	rm ~/sunny/sunny_flutter/swagger-cli.jar
	rm ~/sunny/sunny_flutter/build/swagger_templates
}

unset circle_unset_tag
circle_unset_tag() {
	export CIRCLE_TAG=''
}

unset circle_autodetect_tag
circle_autodetect_tag() {
	export CIRCLE_TAG=$(git tag --contains | sort --version-sort | tail -n 1)
	echo "CIRCLE_TAG=${CIRCLE_TAG}"
}

unset circle_autodetect_release
circle_autodetect_release() {
	export CIRCLE_TAG=$(git tag --contains | grep -v '\-rc\.' | sort --version-sort | tail -n 1)
	if [[ -z $CIRCLE_TAG ]]; then
		echo "No release tag detected on the current revision."
		return 1
	fi
	echo "CIRCLE_TAG=${CIRCLE_TAG}"
}

unset npmrc
npmrc() {
  cp ~/.npmrckeap ~/.npmrc
}

unset unpmrc
unpmrc() {
  rm ~/.npmrc
}

unset circle_autodetect_rc
circle_autodetect_rc() {
	export CIRCLE_TAG=$(git tag --contains | grep '\-rc\.' | sort --version-sort | tail -n 1)
	if [[ -z $CIRCLE_TAG ]]; then
		echo "No release candidate tag detected on the current revision."
		return 1
	fi
	echo "CIRCLE_TAG=${CIRCLE_TAG}"
}

unset git_rebase_interactive
git_rebase_interactive() {
	if [[ -n "$1" ]]; then
		git rebase -i
	else
		git rebase -i HEAD~${1}
	fi
}

unset increment_billing
increment_billing() {
	if [[ -n "$3" ]]; then
		curl https://api.stripe.com/v1/subscription_items/$1/usage_records \
		  -u sk_test_EWmrSdQ4PHWqqUnG6umkBYQ6: \
		  -X POST \
		  -d quantity=$2 \
		  -d timestamp=$3 \
		  -d action=increment
	else
		echo "Usage increment_billing [client_id] [hours] [timestamp]"
	fi
}

alias gri='git_rebase_interactive'

if [[ -n $(alias gc) ]]; then unalias gc; fi 

unset gwcover
gwcover() {
	gw coverageReport coverage --continue
	open build/reports/jacoco/coverageReport/html/index.html
}

unset git_commit
git_commit() {
	if [[ -n "$1" ]]; then
		git commit -a -m "$1"
	else
		git commit -a
	fi

	read -q "REPLY?Do you want to push? " 
	if [[ ${REPLY} =~ ^[Yy]$ ]]; then
		echo ""
		git push
	fi
}
alias gc='git_commit'

unset release_final_patch
release_final_patch() {
	gw release final -Prelease.scope=patch -x jacocoTestCoverageVerification
}
alias grfp='release_final_patch'

if [[ -n $(alias gtd) ]]; then unalias gtd; fi
unset git_tag_delete
git_tag_delete() {

	zparseopts -D -E -F -- f+=force || return 1
    
	if [[ -z "$1" ]]; then
		echo "Usage git_tag_delete [pattern]"
	else
		tags=$(git tag | grep -E "$1")
		echo $tags
		if [[ -z $tags ]]; then
			echo "No tags found"
			return
		fi
		if [[ -z "$force" ]]; then
			read -q "REPLY?This will delete the following tags: ${tags}: " 	
		fi
		
		if [[ ${REPLY} =~ ^[Yy]$ || -n "$force" ]]; then
			echo ""
			echo "Deleting tag(s) $1..."
			echo $tags | xargs -P 10 -n 100 git push --delete origin
			echo $tags | xargs git tag -d	
		fi
	fi
}
alias gtd='git_tag_delete'

if [[ -n $(alias gtr) ]]; then unalias gtr; fi
unset git_tag_reset
git_tag_reset() {
	git tag -l | xargs git tag -d
	git fetch --tags	
}
alias gtr='git_tag_reset'

unset ramdisk
ramdisk() {
	ARGS=1
	E_BADARGS=99

	if [ $# -ne $ARGS ] # correct number of arguments to the script;
	then
	  echo " "
	  echo "To create a RAMDISK -> Usage: `basename $0` SIZE_IN_MB"
	  echo "To delete a RAMDISK -> Usage: `basename $0` delete DISK_ID"
	  echo " "
	  echo "Currently this script only supports one RAMDISK. Will update soon."
	  echo "DISK_ID can be shown with 'mount'. usually /dev/disk* where * is a number"
	  echo " "
	  echo " "
	  return $E_BADARGS
	fi

	size=$(($1 * 2097152))
    diskutil eject /Volumes/ramdisk > /dev/null 2>&1
    diskutil erasevolume HFS+ 'ramdisk' `hdiutil attach -nomount ram://$size`
}

rdestroy() {
	hdiutil eject /Volumes/ramdisk
}

if [[ -n $(alias gt) ]]; then unalias gt; fi
unset git_tag
git_tag() {
	zparseopts -D -E -F -- -rev:=revision -push+=force m:=commit_message f+=del  || return 1
	revision=$revision[2]
    commit_message=$commit_message[2]
     
	if [[ -z $1 ]]; then
		echo "Listing tags:"
		tags=$(git tag | sort --version-sort | tail -n 10)
		if [[ -z "$tags" ]]; then
			echo "No tags found"
		else
			echo $tags
			echo "(to see all tags, use git_tag_list (gtl)"
		fi
		echo ""
		echo "To apply tag: git_tag --rev [revision] [--push] [-m commit_message] [-f]"
		return
	fi

	if [[ -n "$del" ]]; then
		echo ""
		echo "----------------------------------"
		echo "Removing old tag $1..."
		echo "----------------------------------"
		git_tag_delete $1 -f > /dev/null
	fi
	if [[ -n "$revision" ]]; then
		echo "Applying $1 to revision $revision"
		git tag -f $1 -a "$revision" -m "$commit_message"
	else
		echo ""
		echo "----------------------------------"
		echo "Applying $1 to HEAD"
		echo "----------------------------------"
		git tag -f $1
	fi

	if [[ -z "$force$del" ]]; then
		echo ""
		read -q -k 1 "REPLY?Would you like to push this tag?: "
		if [[ ${REPLY} =~ ^[Yy]$ ]]; then
			force=1
		fi
	fi

	if [[ -n "$force" ]]; then
		echo ""
		echo "----------------------------------"
		echo "Push $1 to remote  "
		echo "----------------------------------"
		git push --tags
	fi
}

alias gt='git_tag'

unset git_tag_latest_version
git_tag_latest_version() {
	tags=$(git tag | sort --version-sort | tail -n 1)
	if [[ -z "$tags" ]]; then
		echo "No tags found"
	else
		echo "Current version is: $tags"
		echo "(to see all tags, use git_tag_list (gtl)"
	fi
	return
}
alias gv='git_tag_latest_version'

unset git_tag_list
git_tag_list() {
	git tag
}
alias gtl='git_tag_list'

unset newman_run
newman_run() {
	POSTMAN_COLLECTION=${1-1235916-5abdfd97-5c9d-f633-27d6-e6b058e34042}
	POSTMAN_FOLDER=${2-Regression}
	POSTMAN_ENV=${3-sand}
	newman run https://api.getpostman.com/collections/${POSTMAN_COLLECTION}\?apikey\=${POSTMAN_API_KEY} --bail --ignore-redirects --folder ${POSTMAN_FOLDER} --global-var env=${POSTMAN_ENV}
}

unset newman_optimus
newman_optimus() {
	newman_run 1235916-5abdfd97-5c9d-f633-27d6-e6b058e34042 $1 $2
}

unset newman_alexandria
newman_alexandria() {
	newman_run 1235916-742e21ef-2dce-77bd-e7eb-87a92ef50fdc $1 $2
}

unset newman_goldfish
newman_goldfish() {
	newman_run 1235916-ea66db48-8b20-2d84-9180-e7440a4f31de $1 $2
}

unset flutter_apk
flutter_apk() {
	num_commits=`git log --pretty=format:'' | wc -l`
	flutter build apk  --flavor=production  --build-number=701$num_commits	
	cd android
	gw -Pgit.root=../ publishApk
	cd ..
}

unset flutter_appbundle
flutter_appbundle() {
	num_commits=`git log --pretty=format:'' | wc -l`
	flutter build appbundle --target-platform android-arm,android-arm64 --flavor=production  --build-number=701$num_commits	
}

unset flutter_arm_appbundle
flutter_arm_appbundle() {
	num_commits=`git log --pretty=format:'' | wc -l`
	flutter build appbundle --target-platform android-arm --flavor=production  --build-number=701$num_commits	
}

unset flutter_arm64_appbundle
flutter_arm64_appbundle() {
	num_commits=`git log --pretty=format:'' | wc -l`
	flutter build appbundle --target-platform android-arm64 --flavor=production  --build-number=701$num_commits
}

unset flutter_arm64_appbundle_version
flutter_arm64_appbundle_version() {
	num_commits=`git log --pretty=format:'' | wc -l`
	flutter build appbundle --target-platform android-arm64 --flavor=production  --build-number=701$num_commits	-v
}

unset deploy_circle_scripts
deploy_circle_scripts() {
	SRC_PATH=~/projects/circle-scripts/src

	# make sure src is a directory
	[ -d "${SRC_PATH}" ] || usage

	DEST_URL=gs://springboot-scripts/boot2

    gcloud config set project is-optimus-app-prod
	
	# Copy all files from the src directory to the destination url
	# Set cache control to no-cache to force cache servers to validate the content.
	gsutil -m -h "Cache-Control:public, no-cache" cp -r "${SRC_PATH}/*" "${DEST_URL}"

	# Make all files public
	gsutil -m acl ch -r -u AllUsers:R "${DEST_URL}"

	echo "####################################################"
	echo "####################################################"
	echo "#####           DONE UPLOADING                 #####"
	echo "####################################################"
	echo "####################################################"
	
	rm -rf ~/bin
	curl "https://storage.googleapis.com/springboot-scripts/testing/init.sh" | bash

    echo "Setting gcloud default project back"
    gcloud config set project is-nextgen-pubsub
}
alias dpc='deploy_circle_scripts'

unset ideacompare
ideacompare() {
	first_path=$1
	alternate_root=$2
	alternate_file=$3

	second_path=$first_path
	if [[ ${alternate_root} != . ]]; then
		second_path="${alternate_root}/${second_path#*/}"
	fi
	
	if [[ -n ${alternate_file} ]]; then
		second_path="$(dirname $second_path)/${alternate_file}"
	fi

	echo "Source 1: ${first_path}"
	echo "Source 2: ${second_path}"
	idea diff $first_path $second_path
}

unset idea_diffdir
# idea_diffdir() {
# 	first_path=$1
# 	echo $1
# 	echo $2
# 	return 1
# 	alternate_root=$2
# 	file_pattern=$3

# 	second_path=$(dirname ../${second_path}/${first_path})
# 	if [[ -d $first_path ]]; then

# 		echo "Source 1: ${first_path}"
# 		echo "Source 2: ${second_path}"
# 		idea diff $first_path $second_path	
# 	else
# 		echo "Must run on a directory"
# 	fi
# }

unset gae7
gae7() {
	setjdk 1.8
	port=${2:-10778}
	
	if [[ ! $1 ]]; then
		project_name=${PWD##*/}
	else
		project_name=$1
		cd ~/projects/$project_name
	fi
	cd ~/projects/$1
	gw assemble

	## Runs the server
	gae_run $1 $port java7 $3
}

unset gae_run
gae_run() {
	port=${2:-10778}
	runtime=${3:-java7}
	debug_port=${4:-5005}

	if [[ ! $1 ]]; then
		project_name=${PWD##*/}
	else
		project_name=$1
		cd ~/projects/$project_name
	fi
	cd ~/projects/$1

	if [[ $runtime == java7 ]]; then
		setjdk 1.7
	else
		setjdk 1.8
	fi

	~/google-cloud-sdk/bin/dev_appserver.py \
	    --admin_port=8080  \
	    --admin_host=localhost \
	    --host=localhost \
	    --port=$port \
	    --jvm_flag="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=${debug_port}" \
	    --jvm_flag='-Xmx2g' \
	    --jvm_flag='-XX:MaxPermSize=512m' \
	    --runtime=$runtime \
	    build/build-exploded-$project_name		
}

unset gae8
gae8() {
	port=${2:-10778}
	
	setjdk 1.8
	if [[ ! $1 ]]; then
		project_name=${PWD##*/}
	else
		project_name=$1
		cd ~/projects/$project_name
	fi
	gw assemble
	gae_run $1 $port java8 $3
}

alias start_gae="setjdk 1.7 && cd ~/projects/$0 && ~/appengine-java-sdk/bin/dev_appserver.sh --port=10779 --jvm_flag='-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=5005' --jvm_flag='-Xmx2g' --jvm_flag='-XX:MaxPermSize=512m' --runtime=java7  build/build-exploded-$0"

alias kp="killport"
alias killpaceserver="killport 44444"
alias paceserver="cd ~/Desktop/PaceMinecraftServer && java -Xms1G -Xmx1G -jar spigot-1.12.2.jar"

unset bauth
bauth() {
    b64=`echo $1 | base64`
    echo "Authorization: Basic $b64" | pbcopy
}

unset swagit
swagit() {
    if [ $# -eq 0 ]
        then
            echo "No arguments supplied: Usage swagit [port_fragment]"
    else
        swaggers=`curl http://localhost:10$1/api/v1/swagger.json`
        echo $swaggers > ~/Dropbox/Public/swagger-10$1.json
    fi 
    
}

unset killport
killport() {
	if [ $# -eq 0 ]; then
            echo "No arguments supplied: Usage killport [port]"
    else
        pid=`lsport $1 | tr -s ' ' | cut -d' ' -f2`
        if [ ! -z $pid ]; then
            echo "Killing PID $pid"
            kill -9 $pid
        else
            echo "No process found for port $1"
        fi
    fi 
}


unset lsport
lsport() {
	if [ $# -eq 0 ]; then
       	echo "No arguments supplied: Usage lsport [port]"
    else
    	lsof -n -i4TCP:$1 | grep LISTEN
    fi
}

unset delm
delm() {
    find $II -name $@ -exec rm -rf {} \;
}

unset git_remote
git_remote() {
    if [ $# -eq 0 ]
        then
            echo "No arguments supplied: Usage git_remote '[remote]'"
    else
        dir=`basename $PWD`
        echo "Setting up remote for $1 to $dir"
        git remote add $1 ssh://$1.local/Users/ericm/Projects/$dir
    fi
}

git_remote_all() {
    if [ $# -eq 0 ]
        then
            echo "No arguments supplied: Usage git_remote '[remote]'"
    else
        for d in `ls ~/Projects`
        do
            ( cd $d && git_remote $1 )
        done    
    fi
}

alias rds-tunnels='ssh rds-tunnels'

alias gwm='gw publishToMavenLocal'

alias tailf='tail -n 100 -f'
alias u='cd ..'
alias uu='cd ../..'
alias uuu='cd ../../..'
alias psm='ps -A -o pid,%mem,args --sort rss'
alias vp='vi ~/.profile'
alias vz='vi ~/.zshrc'
alias sp='source ~/.profile && source ~/.zshrc'
alias cutf='cut -d " " -f'
alias ll='ls -l'



function setjdk8() {
    export JAVA_HOME=~/Library/Java/JavaVirtualMachines/jdk1.8.0_202.jdk/Contents/Home
    export PATH=$JAVA_HOME/bin:$PATH
    java -version
}

function setjdk11() {
    export JAVA_HOME=~/Library/Java/JavaVirtualMachines/corretto-11.0.8/Contents/Home/
    export PATH=$JAVA_HOME/bin:$PATH
    java -version
}

setjdk8

function lsjdk() {
    /usr/libexec/java_home -V
}


alias java_ls='/usr/libexec/java_home -V 2>&1 | grep -E "\d.\d.\d[,_]" | cut -d , -f 1 | colrm 1 4 | grep -v Home'

unset chmodr
chmodr() {
    chmod -R "$@"
}

unset chgrpr
chgrpr() {
chgrp -R "$@"
}

unset rmr
rmr() {
rm -r --force $*
}

unset grepr
grepr() {
	grep -D skip -n -s -r -I -i "$@" *
}

unset psf
psf() {
	ps auxw | grep $1
}

unset findvi
findvi() {
	vi `find . -name "$1"`
}


# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

source ~/.flutter-completions.sh
