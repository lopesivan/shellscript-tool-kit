#!/bin/bash

# ONLY CHANGE THIS PART
       name="Ivan Carlos Da Silva Lopes"
      email="lopesivan.ufrj@gmail.com"
#   GITORIUS=gitorious.dev.apptechcorp.com
#   GITORIUS=gitorious.dev.apptechcorp.local
# ----------------------------------------------------------------------------

##############################################################################
##############################################################################
##############################################################################

usage() {
	cat <<EOF
Usage  : `basename $0` git-url
Example: `basename $0` git://gitorious.dev.apptechcorp.com/wx-exemplo/zzz.git
EOF
	exit 1
}

[ "$1" ] || { usage; }

# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------
# ----------------------------------------------------------------------------

for i in $(echo $1 | tr '/' "\n")
do
  projects=$repository
  repository=$i
done

echo "project     = $projects"
echo "repository  = $repository"

d=${repository%.git}
pwd=$(pwd| sed 's=.*/==')

howto() {

	cat <<EOF > HOWTO-gitorius
Global setup:
 Download and install Git
  git config --global user.name "$name"
  git config --global user.email $email

Next steps:
  mkdir $d
  cd $d
  git init
  touch README
  touch .gitignore
  git add README .gitignore
  git commit -m 'first commit'
  git remote add origin git@${GITORIUS}:${projects}/$repository
  git push origin master

Existing Git Repo?
  cd $d
  git remote add origin git@${GITORIUS}:${projects}/$repository
  git push origin master
EOF
}

NewProject() {

	echo '#' New Project $d

	if [ ! -d $d ] ; then

		mkdir $d && cd $d
		howto

		echo cd $d
		echo git init
		touch README
		cat << EOF  >.gitignore
#*~
#*.a
#*.aux
#*.cp
#*.d
#*.dll
#*.dvi
#*.exe
#*.fn
#*.ky
#*.log
#.DS_Store
#*.swp*.o
#*.pg
#*.toc
#*.tp
#*.vr
#.pc
#.classpath
#.repository
#.settings
#bin
#target
#pom.xml.releaseBackup
#release.properties
EOF
		echo git add README .gitignore
		echo git commit -m \'first commit\'
		echo git remote add origin git@${GITORIUS}:${projects}/$repository
		echo git push origin master
	else
		echo existe
	fi

}

Update() {

	echo '# ' Update

	echo git add '*'
	echo git add README .gitignore
	echo git commit -m \'$1\'
	echo git remote add origin git@${GITORIUS}:${projects}/$repository
	echo git push origin master
}

# =================================== Main ===================================

echo '# -----------------------8<---------------------copy-paste--------'
echo git config --global user.name \"$name\"
echo git config --global user.email $email

if [ "$d" == "$pwd" ] ; then
	Update "$2"
else
	NewProject
fi
echo '# ----------------------->8---------------------copy-paste--------'

# ----------------------------------------------------------------------------
exit 0
